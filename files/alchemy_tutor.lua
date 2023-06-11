local at_mod_path = "mods/alchemy_tutor/files"
dofile_once(at_mod_path .. "/grand_alchemy.lua")
dofile_once(at_mod_path .. "/entities/hall_of_masters/hall_of_masters.lua")

--at_test_formula = 'toxicclean'

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
at_volatile_materials = {}
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

local function compare_array( a, b )
	if #a ~= #b then
		return #b - #a
	end
	for i = 1,#a do
		if a[i] < b[i] then
			return -1
		elseif a[i] > b[i] then
			return 1
		end
	end
	return 0
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

local function remove_one_from_array( array, value )
	for i = 1,#array do
		if array[i] == value then
			table.remove( array, i )
			return
		end
	end
end

local function table_slice( array, skip, count )
	local t = {}
	count = math.min( count, #array - skip )
	for i = 1,count do
		t[i] = array[skip+i]
	end
	return t
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

	for i = 1,#at_extra_raw_materials do
		local set = at_extra_raw_materials[i]
		local m = Random(1,#set)
		materials[set[m]] = true
	end

	materials['powder_empty'] = nil

	--[[
	print( '--------------------------------------' )
	print(#keys(materials))
	for k,v in pairs(materials) do
	  print(k)
	end
	]]
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
	local function base_material( mat, test, added )
		if mat == nil or mat == 'air' then
			return
		end
		if type( mat ) == 'table' then
			mat = mat[1]
		end
		if mat == 'air' or mat == test.target or added[mat] then
			return
		end
		added[mat] = true
		table.insert( test.ingredients, mat )
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
			ingredients = copy_array( from.ingredients ),
		}
	end

	local function add_ingredients( test, formula )
		local added = {}
		for i,mat in ipairs( formula.materials ) do
			base_material( mat, test, added )
		end
		base_material( formula.cauldron_contents, test, added )
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

	local function print_test( test )
		print(test.target, table.concat( test.formulas, ',' ))
		--for ing,b in pairs(test.created_materials) do
			--print('--' .. ing)
		--end
		for j,ing in pairs(test.ingredients) do
			print('  ' .. ing)
		end
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

	local function expand_tests()
		local old = master_tests
		local new = {}
		local unique_set = {}
		for t,original_test in ipairs(old) do
			local expansions = 0
			for i,ing in ipairs(original_test.ingredients) do
				for f,formula in ipairs(at_formula_list) do
					if ing == formula.output and not formula.exclude_from_chains and not at_first_time( formula ) and not formula_includes( formula, original_test.created_materials ) then
						local new_test = copy_test( original_test )
						table.insert( new_test.formulas, formula.name )
						new_test.created_materials[formula.output] = true
						remove_one_from_array( new_test.ingredients, ing )
						add_ingredients( new_test, formula )
						local list = copy_array( new_test.ingredients )
						table.sort( list )
						ingredient_key = new_test.target .. table.concat( list )
						if not unique_set[ingredient_key] then
							unique_set[ingredient_key] = true
							table.insert( new, new_test )
						end
						expansions = expansions + 1
						--print('old')
						--print_test( original_test )
						--print('new')
						--print_test( new_test )
					end
				end
			end
			if expansions < 1 then
				table.insert( new, original_test )
			end
		end
		--at_log( 'expanded', #old, #new )
		master_tests = new
	end

	---[[
	-- two expansions makes up to three steps
	for i = 1,2 do
		expand_tests()
	end
	--]]

	local bulk_amounts = {}
	for t = 1,#master_tests do
		local ingredients = master_tests[t].ingredients
		local bulk_test = {}
		for i = 1,#ingredients do
			local ing = ingredients[i]
			bulk_test[ing] = (bulk_test[ing] or 0) + 1
		end
		for ing,count in pairs(bulk_test) do
			if not bulk_amounts[ing] or bulk_amounts[ing] < count then
				bulk_amounts[ing] = count
			end
		end
	end

	local grand = copy_array( at_grand_materials )
	shuffleTable( grand )
	local count = math.min( 1, #grand )
	for g = 1,count do
		local ing = grand[g]
		bulk_amounts[ing] = (bulk_amounts[ing] or 0) + 1
	end

	for ing,count in pairs(bulk_amounts) do
		if ing ~= 'torch' then
			bulk_amounts[ing] = math.ceil(count * 1.5)
		end
	end

	--print( '--------------------------------------' )
	--[[
	for ing,count in pairs(bulk_amounts) do
		print( ing, count )
	end
	--]]
	--[[
	for i,v in ipairs(master_tests) do
		print_test( v )
	end
	--]]

	return {
		master_tests = master_tests,
		bulk_amounts = bulk_amounts,
	}
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
	--print( formula.name, type(formula.cauldron_contents) )
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
	
	if #at_materials < 1 then
		return
	end

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
	at_volatile_materials = {}
	for i = 1,#at_volatile_material_list do
		at_volatile_materials[at_volatile_material_list[i]] = true
	end

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
		if v.output == 'nil' or v.output == 'air' or v.check_for == at_explosion or (v.cauldron and v.cauldron.exclude_from_chains) or (v.output and at_volatile_materials[v.output]) then
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
	elseif material_name == "torch" then
		return at_torch( x, y )
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
		AddMaterialInventoryMaterial(entity, material_name, 1000 * amount)
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

at_base_SetRandomSeed = SetRandomSeed

function at_SetRandomSeed( x, y )
	print( '--------------------------------- SetRandomSeed', x, y )
	at_base_SetRandomSeed( x, y )
end

at_master_blocks = {
	{ -- 1
		container = 0,
		medium = 0,
		large = 0,
		other = 0,
	},
	{ -- 2
		container = 0,
		medium = 0,
		large = 0,
		other = 0,
	},
	{ -- 3
		container = 0,
		medium = 6,
		large = 3,
		other = 5,
	},
	{ -- 4
		container = 78,
		medium = 6,
		large = 3,
		other = 0,
	},
	{ -- 5
		container = 0,
		medium = 6,
		large = 0,
		other = 0,
	},
	{ -- 6
		container = 0,
		medium = 6,
		large = 0,
		other = 0,
	},
}

local total_container = 0
local total_medium = 0
local total_large = 0
local total_other = 0

for i = 1,6 do
	at_master_blocks[i].skip_container = total_container
	at_master_blocks[i].skip_medium = total_medium
	at_master_blocks[i].skip_large = total_large
	at_master_blocks[i].skip_other = total_other
	total_container = total_container + at_master_blocks[i].container
	total_medium = total_medium + at_master_blocks[i].medium
	--print('medium', total_medium)
	total_large = total_large + at_master_blocks[i].large
	--print('large', total_large)
	total_other = total_large + at_master_blocks[i].large
end

function at_decorate_hall_of_masters( x, y, scene_description )
	at_log( 'decorate masters', x, y )

	local block_number = scene_description.n

	at_log( 'master block', block_number )

	local block = at_master_blocks[block_number]

	local block_x = math.floor(x / 512)
	local block_y = math.floor(y / 512)

	at_log( 'block', block_x, block_y )

	local block_dx = (block_number-1) % 2
	local block_dy = math.floor((block_number-1) / 2)

	at_log( 'block delta', block_dx, block_dy )

	local lab_block_x = block_x - block_dx
	local lab_block_y = block_y - block_dy

	at_log( 'lab', lab_block_x, lab_block_y )

	local lab_pixel_x = lab_block_x * 512
	local lab_pixel_y = lab_block_y * 512

	SetRandomSeed( lab_block_x, lab_block_y )

	SetRandomSeed = at_SetRandomSeed

	local lab_id = at_get_lab_id( lab_pixel_x, lab_pixel_y )
	local biome_bulk = at_get_lab_biome_bulk( lab_pixel_x, lab_pixel_y )
	local local_materials = at_get_lab_local_materials( lab_pixel_x, lab_pixel_y )

	local facts = at_master_sets()
	local tests = facts.master_tests
	local test = tests[ Random(1, #tests) ]

	local function has_materials(t)
		for _,mat in ipairs(local_materials) do
			if test.created_materials[mat] then
				return true
			end
		end
		return false
	end

	--[[
	--local target = { 'diamond', 'copper', 'silver2', 'magic_liquid_random_polymorph' }
	local target = { 'magic_liquid_charm' }
	for i,t in pairs(tests) do
		if compare_array( test.ingredients, target ) then
			test = t
		end
	end
	--]]

	local crazy = 0
	local trial = test
	while has_materials(trial) and crazy < 5 do
		crazy = crazy + 1
		trial = tests[ Random(1, #tests) ]
	end
	if not has_materials(trial) then
		test = trial
	end
	if test then
		at_log( 'target', test.target, table.concat(test.formulas, ',') )
	end
	local biome_modifier = at_get_lab_biome_modifier( lab_pixel_x, lab_pixel_y )

	local must_be_bottled = {}
	if biome_modifier == 'hot' then
		for _,mat in ipairs(at_evaporating_material_list) do
			must_be_bottled[mat] = true
		end
	end

	local container_list = {}
	local medium_list = {}
	local large_list = {}

	-- initial allocation by volume
	for mat,count in pairs( facts.bulk_amounts ) do
		if mat ~= biome_bulk then
			if not test or not test.created_materials[mat] then
				if count > 2 and not at_volatile_materials[mat] and not must_be_bottled[mat] then
					if count > 3 then
						large_list[#large_list+1] = mat
					else
						medium_list[#medium_list+1] = mat
					end
				else
					for i = 1,count do
						container_list[#container_list+1] = mat
					end
				end
			end
		end
	end

	-- if there are more than that storage location allows, move into next size
	shuffleTable( large_list )
	local extra
	extra = table_slice( large_list, total_large, #large_list )
	large_list = table_slice( large_list, 0, total_large )
	for i,mat in ipairs( extra ) do
		at_log( 'large overflow', tostring(mat) )
		medium_list[#medium_list+1] = mat
		medium_list[#medium_list+1] = mat
	end

	shuffleTable( medium_list )
	extra = table_slice( medium_list, total_medium, #medium_list )
	medium_list = table_slice( medium_list, 0, total_medium )
	for i,mat in ipairs( extra ) do
		at_log( 'medium overflow', tostring(mat) )
		for i = 1,3 do
			container_list[#container_list+1] = mat
		end
	end

	shuffleTable( container_list )

	-- fill some of the empty spots in bulk containers from smaller containers
	local upfill

	upfill = math.min( total_large - #large_list, #medium_list )
	for i = 1,upfill do
		local mat = table.remove( medium_list )
		--at_log( 'large upfill', tostring(mat) )
		large_list[#large_list+1] = mat
	end

	upfill = math.min( Random(0, total_medium - #medium_list), #container_list )
	--upfill = math.min( total_medium - #medium_list, #container_list )
	at_log( 'medium counts', upfill, total_medium )
	local skip = 0
	for i = 1,upfill do
		local mat = container_list[#container_list - skip]
		if not at_volatile_materials[mat] then
			--at_log( 'medium upfill', tostring(mat) )
			medium_list[#medium_list+1] = table.remove( container_list, #container_list - skip )
		else
			skip = skip + 1
			--at_log( 'medium upfill volatile', tostring(mat) )
		end
	end

	upfill = total_medium - #medium_list
	at_log( 'medium counts', upfill, total_medium )
	for i = 1,upfill do
		medium_list[#medium_list+1] = "air"
	end

	shuffleTable( large_list )
	shuffleTable( medium_list )

	-- place materials in respective container location in this scene
	local materials = scene_description.m
	local medium_bins = scene_description.c
	local large_bins = scene_description.l
	local other = scene_description.o
	local reward = scene_description.r

	local loc
	local what

	shuffleTable( materials )
	shuffleTable( medium_bins )
	shuffleTable( large_bins )
	shuffleTable( other )
	shuffleTable( reward )

	local master_rewards = {
		'treasure',
		'knowledge',
		'power',
		'magic',
	}

	shuffleTable( master_rewards )

	loc = table.remove( reward )
	if test and loc then
		if block_number == 2 then
			--at_container( test.target, 0.91, loc.x, loc.y )
			at_container( test.target, 0.01, loc.x, loc.y )
		end

		local altar_reward = master_rewards[block_number]

		at_master_reward_altar( altar_reward, loc.x - 22, loc.y + 5 )

		local id = EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/test_success_check.xml", loc.x, loc.y )
		local vars = EntityGetComponent( id, "VariableStorageComponent" )
		if vars then
			for i = 1,#vars do
				var = vars[i]
				local name = ComponentGetValue2( var, "name" )
				if ( name == "target" ) then
					ComponentSetValue2( var, "value_string", test.target )
				elseif ( name == "reward" ) then
					ComponentSetValue2( var, "value_string", altar_reward )
				elseif ( name == "lab_id" ) then
					ComponentSetValue2( var, "value_string", lab_id )
				end
			end
		end

		at_log( 'target detector', test.target, loc.x, loc.y )
	end

	large_list = table_slice( large_list, block.skip_large, block.large )
	at_log('large', #large_list, #large_bins)
	for i,mat in ipairs( large_list ) do
		what = at_material( mat, 'air', first )

		loc = table.remove( large_bins )
		if loc then
			local amount = 1.0
			if what ~= 'air' then
				local count = facts.bulk_amounts[mat]
				if count >= 6 then
					amount = Randomf( 0.85, 1.0 )
				elseif count == 5 then
					amount = Randomf( 0.75, 1.0 )
				elseif count == 4 then
					amount = Randomf( 0.65, 1.0 )
				elseif count == 3 then
					amount = Randomf( 0.55, 0.90 )
				else
					amount = Randomf( 0.45, 0.80 )
				end
				--print( '--------------------',  what, count, amount )
			end
			at_large_bin( loc.x, loc.y, what, amount )
			--present_materials[what] = true
			at_log( 'large bin', what, loc.x, loc.y )
		else
			at_log( 'unable to place', what )
		end
	end

	at_log('medium', #medium_list, #medium_bins)
	medium_list = table_slice( medium_list, block.skip_medium, block.medium )
	at_log('medium', #medium_list, #medium_bins)
	for i,mat in ipairs( medium_list ) do
		what = at_material( mat, 'air', first )

		loc = table.remove( medium_bins )
		if loc then
			local amount = 1.0
			if what ~= 'air' then
				local count = facts.bulk_amounts[mat]
				if count >= 3 then
					amount = Randomf( 0.75, 1.0 )
				else
					amount = Randomf( 0.66, 1.0 )
				end
				--print( '--------------------',  what, count, amount )
			end
			at_medium_bin( loc.x, loc.y, what, amount )
			--present_materials[what] = true
			at_log( 'medium bin', what, loc.x, loc.y )
		else
			at_log( 'unable to place', what )
		end
	end

	at_log('container', #container_list, #materials)
	container_list = table_slice( container_list, block.skip_container, block.container )
	at_log('container', #container_list, #materials)
	for i,mat in ipairs( container_list ) do
		what = at_material( mat, 'potion_empty', first )

		loc = table.remove( medium_bins )
		loc = table.remove( materials )
		if loc then
			-- look up amount
			at_container( what, 1.0, loc.x, loc.y )
			--present_materials[what] = true
			--at_log( 'material', what, loc.x, loc.y )
		else
			at_log( 'unable to place', what )
		end
	end

	local others = at_all_others()
	at_log('other', #others, #other)

	for i,extra in ipairs( others ) do
		loc = table.remove( other )
		if loc then
			extra( loc.x, loc.y )
		end
	end

	at_log_book( x, y )

	SetRandomSeed = at_base_SetRandomSeed
end


dofile_once(at_mod_path .. "/props.lua")

--at_default_cauldron = at_suspended_container
at_default_cauldron = at_cauldron

dofile_once(at_mod_path .. "/formula_list.lua")
