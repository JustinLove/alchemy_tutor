local at_mod_path = "mods/alchemy_tutor/files"
dofile_once(at_mod_path .. "/grand_alchemy.lua")

--at_test_player = true
--at_test_lab = true
--at_test_formula = 'toxicclean'
--at_test_formula = 'magic_liquid_mana_regeneration'
--at_test_clear = true
--at_test_healing = true
--at_test_portal = true
at_test_x = -200
at_test_y = -100 -- hills
--at_test_y = 2000 -- excavation
--at_test_y = 3500 -- snowcave
--at_test_y = 5500 -- snowcastle
--at_test_y = 7000 -- rainforest
--at_test_y = 9000 -- vault
--at_test_y = 11000 -- crypt
--at_test_x = 10000 -- pyramid
--at_test_y = 0 -- pyramid
--at_test_x = -4000 -- rainforest dark
--at_test_y = 7500 -- rainforest dark

local function at_get_material_type( material_name )
	local material_id = CellFactory_GetType( material_name )
	local tags = CellFactory_GetTags( material_id )

	for i,v in ipairs( tags ) do
		if v == "[sand_ground]" then
			return "powder"
		elseif v == "[sand_metal]" then
			return "powder"
		elseif v == "[sand_other]" then
			return "powder"
		elseif v == "[liquid]" then
			return "liquid"
		end
	end

	local sands = CellFactory_GetAllSands()
	for i,v in ipairs( sands ) do
		if v == material_name then
			return "powder"
		end
	end

	return "liquid" -- punt, use a flask
end

-- from cheatgui
local function empty_container_of_materials(idx)
	for _ = 1, 1000 do -- avoid infinite loop
		local material = GetMaterialInventoryMainMaterial(idx)
		if material <= 0 then break end
		local matname = CellFactory_GetName(material)
		AddMaterialInventoryMaterial(idx, matname, 0)
	end
end

at_formulas = {}
at_materials = {}
at_amounts = {}
at_grand_materials = {}
at_passed_count = 0

function at_pick_lab_set( x, y )
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	if _G['at_test_formula'] then
		return at_formulas[at_test_formula]
	end
	at_passed_count = tonumber( GlobalsGetValue( "at_passed_count", 0 ) )
	SetRandomSeed( x, y )
	local grand = {}
	local in_grade = {}
	local rating_limit = #at_formula_list
	if ModSettingGet("alchemy_tutor.formula_progression") then
		rating_limit = at_passed_count + 3
	end
	for i,v in ipairs(at_formula_list) do
		if v.grand_alchemy then
			table.insert(grand, v)
		end
		if v.rating <= rating_limit then
			table.insert(in_grade, v)
		end
	end
	if #in_grade < 1 then
		in_grade = at_formula_list
	end
	if Random(0, #grand + 5) < #grand then
		local i = Random(1, #grand)
		return grand[i]
	else
		local i
		if ModSettingGet("alchemy_tutor.formula_distance") then
			local d = math.sqrt(x*x + y*y)
			local target = math.floor(#in_grade * (d/12000))
			i = RandomDistribution(1, #in_grade, target)
		else
			i = Random(1, #in_grade)
		end
		return in_grade[i]
	end
end

function at_setup_grand_alchemy()
	local lc_combo, ap_combo = at_grand_alchemy()
	local grand = {}

	local function mark_grand(formula, mat)
		if type( mat ) == 'table' then
			if grand[mat[1]] then
				formula.grand_alchemy = true
			end
		else
			if grand[mat] then
				formula.grand_alchemy = true
			end
		end
	end

	for i,v in ipairs(lc_combo) do
		grand[v] = true
		table.insert(at_grand_materials, v)
	end
	for i,v in ipairs(ap_combo) do
		grand[v] = true
		table.insert(at_grand_materials, v)
	end

	--at_print_table(at_grand_materials)

	for i,v in ipairs(at_formula_list) do
		for i,mat in ipairs( v.materials ) do
			mark_grand(v, mat)
			at_amounts[#at_materials] = v.amounts[i]
		end
		mark_grand(v, v.output)
		mark_grand(v, v.cauldron_contents)
	end
end

local function formula_sort(a, b)
	return (a.rating or 9) < (b.rating or 9)
end

function at_setup()
	at_passed_count = 0
	table.sort(at_formula_list, formula_sort)
	for i,v in ipairs(at_formula_list) do
		if v.name == nil then
			v.name = v.output
		end
		if HasFlagPersistent( "at_formula_" .. v.name ) then
			at_passed_count = at_passed_count + 1
		end
		at_formulas[v.name] = v
		if v.amounts == nil then
			v.amounts = {}
		end
		for i,mat in ipairs( v.materials ) do
			if type( mat ) == 'table' then
				table.insert(at_materials, mat[1])
			else
				table.insert(at_materials, mat)
			end
			at_amounts[#at_materials] = v.amounts[i]
		end
	end
	GlobalsSetValue( "at_passed_count", tostring(at_passed_count) )
	at_setup_grand_alchemy()
end

function at_first_time( set )
	if ModSettingGet("alchemy_tutor.formula_progression") then
		return not HasFlagPersistent( "at_formula_" .. set.name )
	else
		return false
	end
end

function at_material( material, default, first )
	if type( material ) == 'table' then
		if #material == 0 then
			return default
		end
		if first then
			return material[1]
		end
		return material[Random(1, #material)]
	end
	return material or default
end

function at_container( material_name, amount, x, y )
	--print( type(material_name) )
	--print( material_name )
	local entity
	if material_name == nil or material_name == "" then
		return
	elseif material_name == "red_herring" then
		return at_red_herring( x, y )
	elseif material_name == "powder_empty" then
		return at_powder_empty( x, y )
	elseif material_name == "potion_empty" then
		return at_potion_empty( x, y )
	elseif material_name == "fire" and amount < 0.5 then
		return at_torch( x, y )
	elseif material_name == "urine" then
		entity = at_jar_empty( x, y )
		AddMaterialInventoryMaterial(entity, material_name, 1000 * amount)
		return entity
	elseif at_get_material_type( material_name) == "powder" then
		entity = at_powder_empty( x, y )
		AddMaterialInventoryMaterial(entity, material_name, 1500 * amount)
		return entity
	else
		entity = at_potion_empty( x, y )
		AddMaterialInventoryMaterial(entity, material_name, 1000 * amount)
		return entity
	end
end

function at_powder_stash( x, y )
	local entity = EntityLoad("data/entities/items/pickup/powder_stash.xml", x, y)
	return entity
end

function at_powder_empty( x, y )
	local entity = at_powder_stash( x, y )	
	empty_container_of_materials( entity )
	return entity
end

function at_potion( x, y )
	local entity = EntityLoad( "data/entities/items/pickup/potion.xml", x, y )
	return entity
end

function at_potion_empty( x, y )
	local entity = EntityLoad( "data/entities/items/pickup/potion_empty.xml", x, y )
	return entity
end

function at_jar_empty( x, y )
	local entity = EntityLoad( "data/entities/items/pickup/jar.xml", x, y )
	empty_container_of_materials( entity )
	return entity
end

function at_torch( x, y )
	local entity = EntityLoad( "mods/alchemy_tutor/files/entities/torch.xml", x, y )
	return entity
end

function at_red_herring( x, y, present_materials )
	local crazy = 0
	while true do
		local r = Random(1, #at_materials + #at_grand_materials + 10)
		if r <= #at_materials then
			if (not present_materials[at_materials[r]]) or crazy > 10 then
				return at_container( at_materials[r], at_amounts[r] or 1.0, x, y )
			end
		elseif r <= #at_materials + #at_grand_materials then
			r = r - #at_materials
			if (not present_materials[at_grand_materials[r]]) or crazy > 10 then
				return at_container( at_grand_materials[r], 1.0, x, y )
			end
		elseif r <= #at_materials + #at_grand_materials + 3 then
			return at_powder_stash( x, y )
		else
			return at_potion( x, y )
		end

		crazy = crazy + 1
	end
end

function at_remember_formula( entity, formula )
	local s = EntityGetComponent( entity, "VariableStorageComponent" )
	if ( s ~= nil ) then
		for i,v in ipairs( s ) do
			local name = ComponentGetValue2( v, "name" )

			if ( name == "formula" ) then
				ComponentSetValue2( v, "value_string", formula )
			end
		end
	end
end

local function remove_material_checker( entity )
	local comp = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
	if comp ~= nil then
		EntityRemoveComponent( entity, comp )
	end
end

local function remove_damage_model( entity )
	local comp = EntityGetFirstComponent( entity, "DamageModelComponent" )
	if comp ~= nil then
		EntityRemoveComponent( entity, comp )
	end
end

local function setup_material_checker( entity, material1, material2, fast_checking, index )
	local mat1 = CellFactory_GetType( material1 )
	local mat2 = -1
	if material2 then
		mat2 = CellFactory_GetType( material2 )
	end

	local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
	if comp_mat ~= nil then
		ComponentSetValue2( comp_mat, "material", mat1 )
		ComponentSetValue2( comp_mat, "material2", mat2 )
		local frames = ComponentGetValue2( comp_mat, "update_every_x_frame" ) + index
		if fast_checking then
			frames = 1
		end
		ComponentSetValue2( comp_mat, "update_every_x_frame", frames )
	end

	remove_damage_model( entity )
end

local function setup_presence_checker( entity, material1, material2 )
	EntitySetDamageFromMaterial( entity, material1, 1 )
	if material2 then
		EntitySetDamageFromMaterial( entity, material2, 1 )
	end

	remove_material_checker( entity )
end

local function setup_majority_checker( entity, material1, material2 )
	setup_presence_checker( entity, material1, material2 )

	local comp = EntityGetFirstComponent( entity, "DamageModelComponent" )
	if comp ~= nil then
		-- max seems to be 85
		ComponentSetValue2( comp, "material_damage_min_cell_count", 42 )
	end
end

local function setup_explosion_checker( entity )
	local comp = EntityGetFirstComponent( entity, "DamageModelComponent" )
	if comp ~= nil then
		ComponentSetValue2( comp, "materials_create_messages", false )
		ComponentSetValue2( comp, "materials_damage", false )
		ComponentObjectSetValue2( comp, "damage_multipliers", "explosion", 1 )
	end

	remove_material_checker( entity )
end

function at_full_cauldron( entity, x, y, set, index )
	if not entity then
		entity = EntityLoad( "mods/alchemy_tutor/files/entities/full_cauldron.xml", x, y )
	end
	setup_material_checker( entity, set.output, set.output2, set.fast_checking, index )
	return entity
end

function at_material_presence( entity, x, y, set, index )
	if not entity then
		entity = EntityLoad( "mods/alchemy_tutor/files/entities/damage_model.xml", x, y )
	end
	setup_presence_checker( entity, set.output, set.output2 )
	return entity
end

function at_majority( entity, x, y, set, index )
	if not entity then
		entity = EntityLoad( "mods/alchemy_tutor/files/entities/damage_model.xml", x, y )
	end
	setup_majority_checker( entity, set.output, set.output2 )
	return entity
end

function at_explosion( entity, x, y, set, index )
	if not entity then
		entity = EntityLoad( "mods/alchemy_tutor/files/entities/damage_model.xml", x, y )
	end
	setup_explosion_checker( entity )
	return entity
end

function at_material_destruction( entity, x, y, set, index )
	local material = at_material( set.cauldron_material, "wizardstone" )
	if not entity then
		entity = EntityLoad( "mods/alchemy_tutor/files/entities/material_destruction.xml", x, y )
	end
	setup_material_checker( entity, material, '', false, index )
	return entity
end

function at_add_checker( entity, x, y, offset, set, index )
	y = y - (set.cauldron_check_y or offset)
	local checker = (set.check_for or at_full_cauldron)
	local checker_entity = checker( entity, x, y, set, index )
	at_remember_formula( checker_entity, set.name )
end

function shuffleTable( t )
	assert( t, "shuffleTable() expected a table, got nil" )
	local iterations = #t
	local j
	
	for i = iterations, 2, -1 do
		j = Random(1,i)
		t[i], t[j] = t[j], t[i]
	end
end

function at_print_table( t )
	dofile_once( "data/scripts/lib/utilities.lua" )
	debug_print_table( t )
end

dofile_once(at_mod_path .. "/props.lua")

--at_default_cauldron = at_suspended_container
at_default_cauldron = at_cauldron

dofile_once(at_mod_path .. "/formula_list.lua")
