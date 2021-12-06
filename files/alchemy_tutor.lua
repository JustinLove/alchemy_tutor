local at_mod_path = "mods/alchemy_tutor/files"

--1439153766
--1496269479
at_test_x = -200
at_test_y = -100
--at_test_formula = 'toxicclean'
--at_test_player = true
--at_test_lab = true

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

function at_pick_lab_set( x, y )
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	if _G['at_test_formula'] then
		return at_formulas[at_test_formula]
	end
	SetRandomSeed( x, y )
	local r = Random()
	if ModSettingGet("alchemy_tutor.formula_distance") then
		local d = math.sqrt(x*x + y*y)
		r = r ^ (12000 / d)
	end
	local i = math.floor( r * #at_formula_list + 1 )
	return at_formula_list[i]
end

function at_setup()
	for i,v in ipairs(at_formula_list) do
		at_formulas[v.name or v.output] = v
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
	print( type(material_name) )
	print( material_name )
	local entity
	if material_name == nil or material_name == "" then
		return
	elseif material_name == "red_herring" then
		at_red_herring( x, y )
	elseif material_name == "powder_empty" then
		entity = at_powder_empty( x, y )
	elseif material_name == "potion_empty" then
		entity = at_potion_empty( x, y )
	elseif at_get_material_type( material_name) == "powder" then
		entity = at_powder_empty( x, y )
		AddMaterialInventoryMaterial(entity, material_name, 1500 * amount)
	else
		entity = at_potion_empty( x, y )
		AddMaterialInventoryMaterial(entity, material_name, 1000 * amount)
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

function at_red_herring( x, y )
	local r = Random(1, #at_materials + 10)
	if r <= #at_materials then
		at_container( at_materials[r], at_amounts[r] or 1.0, x, y )
	elseif r <= #at_materials + 3 then
		at_powder_stash( x, y )
	else
		at_potion( x, y )
	end
end

function at_cauldron( set, x, y )
	local contents = at_material( set.cauldron_contents, "air" )
	LoadPixelScene(
		"mods/alchemy_tutor/files/cauldron.png",
		"", -- visual
		x-18, y-39,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = contents,
			["fff2ddb2"] = set.cauldron_minor or contents,
			["ff786c42"] = at_material( set.cauldron_material, "templebrick_static" ),
		}, -- color_to_matieral_table
		50 -- z index
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

function at_electrode( set, x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/electrode.png",
		"mods/alchemy_tutor/files/electrode_visual.png",
		x-18, y-18,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = at_material( set.cauldron_contents, "air" ),
			["ff404041"] = at_material( set.cauldron_material, "steel_static" ),
		}, -- color_to_matieral_table
		50 -- z index
	)

	local entity = EntityLoad( "mods/alchemy_tutor/files/entities/shock_checker.xml", x, y-(set.cauldron_check_y or 18) )
end

function at_block( set, x, y )
	local material = at_material( set.cauldron_material, "wizardstone" )
	LoadPixelScene(
		"mods/alchemy_tutor/files/block.png",
		"", -- visual
		x-18, y-39,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = at_material( set.cauldron_contents, "air" ),
			["ff4c4356"] = material,
		}, -- color_to_matieral_table
		50 -- z index
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

function at_planterbox( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/planterbox.png",
		"", -- visual
		x-25, y-13,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_frogs( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/frogs.png",
		"", -- visual
		x-25, y-29,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_meat( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/meat.png",
		"", -- visual
		x-25, y-29,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
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

local function at_print_table( t )
	dofile_once( "data/scripts/lib/utilities.lua" )
	debug_print_table( t )
end

dofile_once(at_mod_path .. "/formula_list.lua")
