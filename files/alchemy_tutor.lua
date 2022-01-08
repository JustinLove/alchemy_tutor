local at_mod_path = "mods/alchemy_tutor/files"
dofile_once(at_mod_path .. "/grand_alchemy.lua")

--1439153766
--1496269479
at_test_x = -200
at_test_y = -100 -- hills
--at_test_y = 2000 -- excavation
--at_test_y = 3500 -- snowcave
--at_test_y = 5500 -- snowcastle
--at_test_y = 7000 -- rainforest
--at_test_y = 9000 -- vault
--at_test_y = 11000 -- crypt
--at_test_formula = 'toxicclean'
--at_test_formula = 'magic_liquid_mana_regeneration'
--at_test_clear = true
--at_test_player = true
--at_test_lab = true
--at_test_portal = true

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

function at_pick_lab_set( x, y )
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	if _G['at_test_formula'] then
		return at_formulas[at_test_formula]
	end
	SetRandomSeed( x, y )
	local grand = {}
	for i,v in ipairs(at_formula_list) do
		if v.grand_alchemy then
			table.insert(grand, v)
		end
	end
	if Random(0, #grand + 5) < #grand then
		local i = Random(1, #grand)
		return grand[i]
	else
		local i
		if ModSettingGet("alchemy_tutor.formula_distance") then
			local d = math.sqrt(x*x + y*y)
			local target = math.floor(#at_formula_list * (d/12000))
			i = RandomDistribution(1, #at_formula_list, target)
		else
			i = Random(1, #at_formula_list)
		end
		return at_formula_list[i]
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

function at_setup()
	for i,v in ipairs(at_formula_list) do
		if v.name == nil then
			v.name = v.output
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
	at_setup_grand_alchemy()
end

function at_material( material, default )
	if type( material ) == 'table' then
		if #material == 0 then
			return default
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

at_cauldron = {
	default_material = "templebrick_static",
	spawn = function( set, x, y )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			"mods/alchemy_tutor/files/props/cauldron.png",
			"", -- visual
			x-18, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["fff2ddb2"] = set.cauldron_minor or contents,
				["ff786c42"] = at_material( set.cauldron_material, "templebrick_static" ),
			} -- color_to_matieral_table
		)

		local entity = EntityLoad( "mods/alchemy_tutor/files/entities/cauldron_checker.xml", x, y-(set.cauldron_check_y or 18) )
		local mat1 = CellFactory_GetType( set.output )
		local mat2 = -1
		if set.output2 then
			mat2 = CellFactory_GetType( set.output2 )
		end

		local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
		if comp_mat ~= nil then
			ComponentSetValue( comp_mat, "material", tostring(mat1) )
			ComponentSetValue( comp_mat, "material2", tostring(mat2) )
		end

		return contents
	end
}

at_steel_pit = {
	default_material = "steel",
	spawn = function( set, x, y, prop )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			"mods/alchemy_tutor/files/props/steel_pit.png",
			"", -- visual
			x-18, y-22,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["fff2ddb2"] = set.cauldron_minor or contents,
			} -- color_to_matieral_table
		)

		local entity = EntityLoad( "mods/alchemy_tutor/files/entities/cauldron_checker.xml", x, y-(set.cauldron_check_y or 6) )
		local mat1 = CellFactory_GetType( set.output )
		local mat2 = -1
		if set.output2 then
			mat2 = CellFactory_GetType( set.output2 )
		end

		local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
		if comp_mat ~= nil then
			ComponentSetValue( comp_mat, "material", tostring(mat1) )
			ComponentSetValue( comp_mat, "material2", tostring(mat2) )
		end

		return contents
	end
}

at_brick_pit = {
	default_material = "templebrick_static",
	spawn = function( set, x, y, prop )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			"mods/alchemy_tutor/files/props/brick_pit.png",
			"", -- visual
			x-26, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["fff2ddb2"] = set.cauldron_minor or contents,
			} -- color_to_matieral_table
		)

		local entity = EntityLoad( "mods/alchemy_tutor/files/entities/cauldron_checker.xml", x, y-(set.cauldron_check_y or 12) )
		local mat1 = CellFactory_GetType( set.output )
		local mat2 = -1
		if set.output2 then
			mat2 = CellFactory_GetType( set.output2 )
		end

		local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
		if comp_mat ~= nil then
			ComponentSetValue( comp_mat, "material", tostring(mat1) )
			ComponentSetValue( comp_mat, "material2", tostring(mat2) )
		end

		return contents
	end
}

at_fungus = {
	default_material = "wood_player_b2",
	spawn = function( set, x, y )
		local contents = at_material( set.cauldron_contents, "fungi" )
		LoadPixelScene(
			"mods/alchemy_tutor/files/props/fungus.png",
			"", -- visual
			x-18, y-25,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["ff32bb32"] = contents,
				["ff36312e"] = set.cauldron_minor or "fungisoil",
				["ff613e02"] = at_material( set.cauldron_material, "wood_player_b2" ),
			} -- color_to_matieral_table
		)

		local entity = EntityLoad( "mods/alchemy_tutor/files/entities/cauldron_checker.xml", x, y-(set.cauldron_check_y or 6) )
		local mat1 = CellFactory_GetType( set.output )
		local mat2 = -1
		if set.output2 then
			mat2 = CellFactory_GetType( set.output2 )
		end

		local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
		if comp_mat ~= nil then
			ComponentSetValue( comp_mat, "material", tostring(mat1) )
			ComponentSetValue( comp_mat, "material2", tostring(mat2) )
		end

		return contents
	end
}

at_suspended_container = {
	default_material = "steel",
	is_physics = true,
	spawn = function( set, x, y )
		local contents = at_material( set.cauldron_contents, "air" )
		local cauld = EntityLoad( at_mod_path .."/entities/suspended_container.xml", x, y - 18 )
		if contents ~= "air" then
			local comp_mat = EntityGetFirstComponent( cauld, "ParticleEmitterComponent" )
			if comp_mat ~= nil then
				ComponentSetValue( comp_mat, "emitted_material_name", contents )
				ComponentSetValue( comp_mat, "is_emitting", 1 )
			end
		end

		local mat1 = CellFactory_GetType( set.output )
		local mat2 = -1
		if set.output2 then
			mat2 = CellFactory_GetType( set.output2 )
		end

		local comp_mat = EntityGetFirstComponent( cauld, "MaterialAreaCheckerComponent" )
		if comp_mat ~= nil then
			ComponentSetValue( comp_mat, "material", tostring(mat1) )
			ComponentSetValue( comp_mat, "material2", tostring(mat2) )
		end

		return contents
	end
}

at_electrode = {
	default_material = "steel",
	spawn = function( set, x, y )
		LoadPixelScene(
			"mods/alchemy_tutor/files/props/electrode.png",
			"mods/alchemy_tutor/files/props/electrode_visual.png",
			x-18, y-18,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = at_material( set.cauldron_contents, "air" ),
				["ff404041"] = at_material( set.cauldron_material, "steel_static" ),
			} -- color_to_matieral_table
		)

		local entity = EntityLoad( "mods/alchemy_tutor/files/entities/shock_checker.xml", x, y-(set.cauldron_check_y or 18) )
	end
}

function at_spawn_block( set, x, y, file )
	local material = at_material( set.cauldron_material, "wizardstone" )
	LoadPixelScene(
		file,
		"", -- visual
		x-18, y-39,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = at_material( set.cauldron_contents, "air" ),
			["ff4c4356"] = material,
		} -- color_to_matieral_table
	)

	local entity = EntityLoad( "mods/alchemy_tutor/files/entities/block_checker.xml", x, y-18 )
	local mat1 = CellFactory_GetType( material )
	local mat2 = -1

	local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
	if comp_mat ~= nil then
		ComponentSetValue( comp_mat, "material", tostring(mat1) )
		ComponentSetValue( comp_mat, "material2", tostring(mat2) )
	end
end

at_block_brick = {
	default_material = "wizardstone",
	spawn = function( set, x, y )
		return at_spawn_block( set, x, y, "mods/alchemy_tutor/files/props/block_brick.png" )
	end
}

at_block_rock = {
	default_material = "wizardstone",
	spawn = function( set, x, y )
		return at_spawn_block( set, x, y, "mods/alchemy_tutor/files/props/block_rock.png" )
	end
}

at_block_steel = {
	default_material = "wizardstone",
	spawn = function( set, x, y )
		return at_spawn_block( set, x, y, "mods/alchemy_tutor/files/props/block_steel.png" )
	end
}

function at_planterbox( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/props/planterbox.png",
		"", -- visual
		x-25, y-13,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_frogs( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/props/frogs.png",
		"", -- visual
		x-25, y-28,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_meat( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/props/meat.png",
		"", -- visual
		x-25, y-29,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end


function at_mushroom( mush, x, y )
	if not mush then
		SetRandomSeed( x, y )
		mush = Random( 1, 5 )
	end
	EntityLoad( at_mod_path .. "/entities/mushroom_big_" .. mush .. ".xml", x, y )
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

--at_default_cauldron = at_suspended_container
at_default_cauldron = at_cauldron

dofile_once(at_mod_path .. "/formula_list.lua")
