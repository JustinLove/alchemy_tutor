local at_mod_path = "mods/alchemy_tutor/files"
dofile_once(at_mod_path .. "/grand_alchemy.lua")

--at_test_player = true
--at_test_lab = true
--at_test_formula = 'toxicclean'
--at_test_clear = true
--at_test_records = true
--at_test_healing = true
--at_test_portal = true
--at_test_masters = true
--at_test_x = -200
--at_test_y = -100 -- hills
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
--at_test_x = 12300 -- fungiforest
--at_test_y = 2000 -- fungiforest
at_test_x = -5317 -- hall of records
at_test_y = 720 -- hall of records
--at_test_x = -5000 -- hall of records entrance
--at_test_y = 700 -- hall of records entrace
--at_test_x = -5640 -- hall of records ghost
--at_test_y = 1024 -- hall of records ghost

function at_get_material_type( material_name )
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
at_biome_banned_materials = {}
at_raw_materials = {}
at_passed_count = 0

function at_pick_lab_set( x, y, scene_description )
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	if _G['at_test_formula'] then
		at_log( 'test formula', at_test_formula )
		return at_formulas[at_test_formula]
	end
	at_passed_count = tonumber( GlobalsGetValue( "at_passed_count", 0 ) )
	SetRandomSeed( x, y )
	local has_other = #(scene_description.o) > 0
	local banned_materials = {}
	for i,b in ipairs(scene_description.sb) do
		banned_materials[b] = true
	end
	local grand = {}
	local in_grade = {}
	local rating_limit = #at_formula_list
	local banned = false
	if ModSettingGet("alchemy_tutor.formula_progression") then
		rating_limit = at_passed_count + 3
	end
	local function mark_banned(mat)
		if type( mat ) == 'table' then
			if banned_materials[mat[1]] then
				banned = true
			end
		else
			if banned_materials[mat] then
				banned = true
			end
		end
	end
	for i,v in ipairs(at_formula_list) do
		if has_other or not v.other then
			banned = false
			mark_banned(v.output)
			mark_banned(v.cauldron_contents)
			for j,m in ipairs(v.materials) do
				mark_banned(m)
			end
			if not banned then
				if v.grand_alchemy then
					table.insert(grand, v)
				end
				if v.rating <= rating_limit then
					table.insert(in_grade, v)
				end
			end
		end
	end
	if #in_grade < 1 then
		in_grade = at_formula_list
	end
	at_log( 'in grade', #in_grade, 'grand', #grand )
	local grand_chance = 0 --math.min( #grand, 5 )
	if Random(0, 10) < grand_chance then
		local i = Random(1, #grand)
		at_log( 'selection by grand', i, grand[i].name )
		return grand[i]
	else
		local i
		local d = math.sqrt(x*x + y*y)
		if d < 15000 and ModSettingGet("alchemy_tutor.formula_distance") then
			local target = math.floor(#in_grade * (d/12000))
			i = RandomDistribution(1, #in_grade, target)
			at_log( 'selection by distanace', i, in_grade[i].name, d )
		else
			i = Random(1, #in_grade)
			at_log( 'selection by random', i, in_grade[i].name )
		end
		return in_grade[i]
	end
end

local function copy_array( from )
	local new = {}
	for i = 1,#from do
		new[i] = from[i]
	end
	return new
end

local function copy_map( from )
	local new = {}
	for k,v in pairs(from) do
		new[k] = v
	end
	return new
end

local function keys( from )
	local new = {}
	for k,v in pairs(from) do
		table.insert( new, k )
	end
	return new
end

function at_setup_raw_materials()
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	local materials = {}

	local function base_material( mat )
		if mat == nil or mat == 'air' then
			return
		end
		if type( mat ) == 'table' then
			mat = mat[1]
		end
		if mat == 'air' then
			return
		end
		materials[mat] = true
	end

	for i,formula in ipairs(at_formula_list) do
		if not formula.exclude_from_chains then
			for i,mat in ipairs( formula.materials ) do
				base_material( mat )
			end
			base_material( formula.cauldron_contents )
		end
	end

	for i,formula in ipairs(at_formula_list) do
		if not formula.exclude_from_chains then
			materials[formula.output] = nil
		end
	end

	materials['powder_empty'] = nil

	--print( '--------------------------------------' )
	--print(#keys(materials))
	--for k,v in pairs(materials) do
		--print(k)
	--end
	at_raw_materials = keys( materials )
	return at_raw_materials
end

function at_all_others()
	local others = {}
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	for i,formula in ipairs(at_formula_list) do
		if not formula.exclude_from_chains then
			if formula.other then
				local found = false
				for o,x in ipairs(others) do
					if x == formula.other then
						found = true
					end
				end
				if not found then
					others[#others+1] = formula.other
				end
			end
		end
	end
	return others
end

function at_master_sets()
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	local master_tests = {}
	local function base_material( mat,test)
		if mat == nil or mat == 'air' then
			return
		end
		if type( mat ) == 'table' then
			mat = mat[1]
		end
		if mat == 'air' or mat == test.target then
			return
		end
		test.ingredients[mat] = true
	end

	local empty_test = {
		target = '',
		formulas = {'xxxx'},
		created_materials = {},
		ingredients = {},
	}

	local function copy_test( from )
		return {
			target = from.target,
			formulas = copy_array( from.formulas ),
			created_materials = copy_map( from.created_materials ),
			ingredients = copy_map( from.ingredients ),
		}
	end

	local function add_ingredients( test, formula )
		for i,mat in ipairs( formula.materials ) do
			base_material( mat, test )
		end
		base_material( formula.cauldron_contents, test )
	end

	local function mat_used( mat, set )
		if type( mat ) == 'table' then
			mat = mat[1]
		end
		local result = set[mat]
		--print('comparing ', tostring(mat), tostring(result) )
		return result
	end

	local function formula_includes( formula, set )
		for i,mat in ipairs( formula.materials ) do
			if mat_used( mat, set ) then
				return true
			end
		end
		if mat_used( formula.cauldron_contents, set ) then
			return true
		end
		return false
	end

	for i,formula in ipairs(at_formula_list) do
		if not formula.exclude_from_chains then
			local test = copy_test( empty_test )
			test.target = formula.output
			test.formulas = {formula.name}
			test.created_materials[formula.output] = true
			add_ingredients( test, formula )
			table.insert( master_tests, test )
		end
	end

	local old
	local new
	for i = 1,4 do
		old = master_tests
		new = {}
		unique_set = {}
		for t,original_test in ipairs(old) do
			local expansions = 0
			for ing,b in pairs(original_test.ingredients) do
				for f,formula in ipairs(at_formula_list) do
					if ing == formula.output and not formula.exclude_from_chains and not formula_includes( formula, original_test.created_materials ) then
						local new_test = copy_test( original_test )
						table.insert( new_test.formulas, formula.name )
						new_test.created_materials[formula.output] = true
						new_test.ingredients[ing] = nil
						add_ingredients( new_test, formula )
						local list = keys( new_test.ingredients )
						table.sort( list )
						ingredient_key = new_test.target .. table.concat( list )
						if not unique_set[ingredient_key] then
							unique_set[ingredient_key] = true
							table.insert( new, new_test )
						end
						expansions = expansions + 1
					end
				end
			end
			if expansions < 1 then
				table.insert( new, original_test )
			end
		end
		print( #old, #new )
		master_tests = new
	end

	--[[
	print( '--------------------------------------' )
	for i,v in ipairs(master_tests) do
		print(v.target, table.concat( v.formulas, ',' ))
		--for ing,b in pairs(v.created_materials) do
			--print('--' .. ing)
		--end
		for ing,b in pairs(v.ingredients) do
			print('  ' .. ing)
		end
	end
	]]

	return master_tests
end

function at_pick_record_exemplar( formula )
	--print( '-------------------------------', formula.name, type(formula.record) )
	if formula.record_material then
		return formula.record_material
	end
	if formula.cauldron_contents ~= nil and formula.cauldron_contents ~= 'air' then
		local contents
		if type( formula.cauldron_contents ) == 'table' then
			contents = formula.cauldron_contents[1]
		else
			contents = formula.cauldron_contents
		end
		--print( tostring(contents) )
		for i,mat in ipairs( formula.materials ) do
			if type( mat ) == 'table' and mat[1] == formula.output then
				return contents
			elseif mat == formula.output then
				return contents
			end
		end
		--print( 'cauldron default', formula.output )
		return formula.output
	end
	--print( 'output', formula.output )
	return formula.output
end

function at_pick_record_pedestal( formula )
	print( formula.name, type(formula.cauldron_contents) )
	if formula.record then
		return formula.record
	end
	if formula.cauldron_contents ~= nil and formula.cauldron_contents ~= 'air' then
		local contents
		if type( formula.cauldron_contents ) == 'table' then
			contents = formula.cauldron_contents[1]
		else
			contents = formula.cauldron_contents
		end
		print( tostring(contents) )
		for i,mat in ipairs( formula.materials ) do
			if type( mat ) == 'table' and mat[1] == formula.output then
				return contents
			elseif mat == formula.output then
				return contents
			end
		end
		print( 'cauldron default', formula.output )
		return formula.output
	end
	print( 'output', formula.output )
	return formula.output
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
				if mat[1] == v.output then
					v.exclude_from_chains = true
				end
			else
				table.insert(at_materials, mat)
				if mat == v.output then
					v.exclude_from_chains = true
				end
			end
			at_amounts[#at_materials] = v.amounts[i]
		end
		if v.output == 'nil' or v.output == 'air' or v.check_for == at_explosion or (v.cauldron and v.cauldron.exclude_from_chains) then
			v.exclude_from_chains = true
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
	--elseif material_name == "shock_powder" then
		--return at_thunderstone( x, y )
	--elseif material_name == "meat_done" then
		--return at_meat_done( x, y )
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
	local entity = EntityLoad( "data/entities/items/pickup/potion.xml", x+1, y )
	return entity
end

function at_potion_empty( x, y )
	local entity = EntityLoad( "data/entities/items/pickup/potion_empty.xml", x+1, y )
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

function at_random_raw( x, y )
	if #at_raw_materials < 1 then
		at_setup_raw_materials()
	end
	local crazy = 0
	while true do
		local r = Random(1, #at_raw_materials + #at_grand_materials + 5)
		if r <= #at_raw_materials then
			local amount = 1.0
			for i,mat in ipairs(at_materials) do
				if mat == at_raw_materials[r] then
					amount = at_amounts[i] or 1.0
					break
				end
			end
			return at_container( at_raw_materials[r], amount, x, y )
		elseif r <= #at_raw_materials + #at_grand_materials then
			r = r - #at_raw_materials
			return at_container( at_grand_materials[r], 1.0, x, y )
		elseif r <= #at_raw_materials + #at_grand_materials + 3 then
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

at_spawn_logs = {}
local at_print_logs = ModIsEnabled('EnableLogger')

function at_log( ... )
	if at_print_logs then
		print( ... )
		if ModSettingGet("alchemy_tutor.spawn_log_book") then
			table.insert( at_spawn_logs, table.concat( {...}, ' ' ) )
		end
	end
end

function at_log_reset()
	at_spawn_logs = {}
end

function at_log_book( x, y )
	if #at_spawn_logs < 1 then
		return
	end

	local entity = EntityLoad( "mods/alchemy_tutor/files/entities/log_book.xml", x, y )

	local item = EntityGetFirstComponent( entity, "ItemComponent" )
	if item then
		ComponentSetValue2( item, "ui_description", table.concat( at_spawn_logs, "\n" ) )
	end

	at_log_reset()
end

function at_decorate_scene( x, y, scene_description )
	at_log( 'decorate', x, y )
	local scene_cauldron = scene_description.sc and _G[scene_description.sc]
	local materials = scene_description.m
	local cauldrons = scene_description.c
	local other = scene_description.o
	local reward = scene_description.r

	local set = at_pick_lab_set( x, y, scene_description )
	SetRandomSeed( x, y )

	shuffleTable( materials )
	shuffleTable( cauldrons )
	shuffleTable( other )
	shuffleTable( reward )

	local loc
	local red_herrings = 0
	local first = at_first_time( set )
	if not first then
		local max = #materials-#set.materials
		local mean = 1
		if ModSettingGet("alchemy_tutor.formula_progression") then
			max = math.min( at_passed_count, max )
			mean = math.log10( at_passed_count )
		end
		red_herrings = RandomDistribution( 0, max, mean, 2 )
	end
	local in_cauldron = {}
	local present_materials = {}
	local what

	local cauldron = set.cauldron or scene_cauldron or at_default_cauldron
	if cauldron.is_physics and set.cauldron_material and set.cauldron_material ~= cauldron.default_material then
		cauldron = at_cauldron
	elseif cauldron.default_material == "steel" and set.cauldron_material == "steel_static_strong" then
		cauldron = at_cauldron
	end
	for i,loc in ipairs( cauldrons ) do
		what = cauldron.spawn( set, loc.x, loc.y, i )
		if what ~= nil then
			in_cauldron[what] = true
			present_materials[what] = true
			at_log( 'cauldron', what, loc.x, loc.y )
		end
	end

	for i,mat in ipairs( set.materials ) do
		what = at_material( mat, 'potion_empty', first )
		loc = table.remove( materials )
		if loc then
			if in_cauldron[what] then
				at_container( what, 0.0, loc.x, loc.y )
			else
				at_container( what, set.amounts[i] or 1.0, loc.x, loc.y )
			end
			present_materials[what] = true
			at_log( 'material', what, loc.x, loc.y )
		end
	end

	local entity
	for i = 1, red_herrings do
		loc = table.remove( materials )
		if loc then
			entity = at_red_herring( loc.x, loc.y, present_materials )
			if entity ~= nil then
				what = CellFactory_GetName(GetMaterialInventoryMainMaterial( entity ))
				present_materials[what] = true
				at_log( 'red', what, loc.x, loc.y )
			end
		end
	end

	loc = table.remove( other )
	if loc and set.other then
		set.other( loc.x, loc.y )
	end

	if set.hide_reward then
		for r,spot in ipairs( rewards ) do
			local rewards = EntityGetInRadiusWithTag( spot.x + 1, spot.y - 6, 5, "at_reward" )
			for i,v in ipairs( rewards ) do
				EntityKill( v )
			end
		end
	end

	at_log_book( x, y )
end

function at_decorate_hall_of_masters( x, y, scene_description )
	at_log( 'decorate masters', x, y )
	local materials = scene_description.m
	local other = scene_description.o
	local reward = scene_description.r

	local set = at_pick_lab_set( x, y, scene_description )
	SetRandomSeed( x, y )

	shuffleTable( materials )
	shuffleTable( other )
	shuffleTable( reward )

	if #at_raw_materials < 1 then
		at_setup_raw_materials()
	end
	local material_list = {}
	local loc
	local what

	local tests = at_master_sets()
	local test = tests[ Random(1, #tests) ]
	loc = table.remove( reward )
	if loc then
		at_container( test.target, 0.01, loc.x, loc.y )

		local id = EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/test_success_check.xml", loc.x, loc.y )
		local var = EntityGetFirstComponent( id, "VariableStorageComponent" )
		if var then
			ComponentSetValue2( var, "value_string", test.target )
		end

		at_log( 'target', test.target, #test.formulas, loc.x, loc.y )
	end

	for i,mat in ipairs( at_raw_materials ) do
		material_list[#material_list+1] = mat
	end
	for i = 1,3 do
		material_list[#material_list+1] = 'potion_empty'
		material_list[#material_list+1] = 'powder_empty'
	end
	for i,mat in ipairs( at_raw_materials ) do
		material_list[#material_list+1] = mat
	end

	for i,mat in ipairs( material_list ) do
		what = at_material( mat, 'potion_empty', first )
		loc = table.remove( materials )
		if loc then
			-- look up amount
			at_container( what, 1.0, loc.x, loc.y )
			--present_materials[what] = true
			--at_log( 'material', what, loc.x, loc.y )
		end
	end

	local others = at_all_others()

	for i,extra in ipairs( others ) do
		loc = table.remove( other )
		if loc then
			extra( loc.x, loc.y )
		end
	end

	at_log_book( x, y )
end


dofile_once(at_mod_path .. "/props.lua")

--at_default_cauldron = at_suspended_container
at_default_cauldron = at_cauldron

dofile_once(at_mod_path .. "/formula_list.lua")
