local at_mod_path = "mods/alchemy_tutor/files"

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

function at_pick_lab_set( x, y )
	local formula_list = {
		{
			name = "hastium",
			material1 = "magic_liquid_movement_faster",
			material2 = "magic_liquid_faster_levitation",
			output = "magic_liquid_faster_levitation_and_movement",
		},
		{
			material1 = "radioactive_liquid",
			material2 = "powder_empty",
			cauldron_contents = "sand",
			cauldron_material = "air",
			other = at_planterbox,
			output = "fungi_creeping",
		},
		{
			name = "levi",
			material1 = "brass",
			material2 = "material_confusion",
			output = "magic_liquid_faster_levitation",
		},
		{
			material1 = "brass",
			material2 = "diamond",
			output = "purifying_powder",
		},
		{
			name = "void1",
			material1 = "radioactive_liquid",
			material2 = "blood_worm",
			cauldron_contents = "fungi",
			output = "void_liquid",
		},
		{
			name = "void2",
			material1 = "diamond",
			material2 = "magic_liquid_random_polymorph",
			cauldron_contents = "radioactive_liquid",
			output = "void_liquid",
		},
	}
	local formulas = {}
	for i,v in ipairs(formula_list) do
		formulas[v.name or v.output] = v
	end
	SetRandomSeed( x, y )
	local d = math.sqrt(x*x + y*y)
	local r = Random()
	local f = r ^ (12000 / d)
	local i = math.floor( f * #formula_list + 1 )
	return formula_list[i]
	--return formulas.hastium
	--return formulas.fungi_creeping
end

function at_spawn_lab( x, y, skip_biome_checks )
	at_spawn_lab_set( x, y, skip_biome_checks )
end

function at_spawn_lab_set( x, y, skip_biome_checks )
	LoadPixelScene(
		"mods/alchemy_tutor/files/excavation_lab_h.png",
		--"mods/alchemy_tutor/files/coalmine_lab.png",
		--"mods/alchemy_tutor/files/coalmine_lab_alt.png",
		--"mods/alchemy_tutor/files/coalmine_lab_visual.png",

		--"mods/alchemy_tutor/files/coalmine_lab_tall.png",
		"",
		x, y,
		"", -- background
		not not skip_biome_checks, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_spawn_lab_anywhere( x, y )
	at_spawn_lab( x, y, true )
end

function at_container( material_name, x, y )
	local entity
	if material_name == nil or material_name == "" then
		return
	elseif material_name == "red_herring" then
		if Random(0, 100) < 33 then
			entity = at_powder_stash( x, y )
		else
			entity = at_potion( x, y )
		end
	elseif material_name == "powder_empty" then
		entity = at_powder_empty( x, y )
	elseif material_name == "potion_empty" then
		entity = at_potion_empty( x, y )
	elseif at_get_material_type( material_name) == "powder" then
		entity = at_powder_empty( x, y )
		AddMaterialInventoryMaterial(entity, material_name, 1500)
	else
		entity = at_potion_empty( x, y )
		AddMaterialInventoryMaterial(entity, material_name, 1000)
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

function at_cauldron( set, x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/cauldron.png",
		"", -- visual
		x-16, y-39,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = set.cauldron_contents or "air",
			["ff786c42"] = set.cauldron_material or "templebrick_static",
		}, -- color_to_matieral_table
		50 -- z index
	)

	local entity = EntityLoad( "mods/alchemy_tutor/files/entities/caulderon_checker.xml", x, y-18 )
	local material1 = CellFactory_GetType( set.output )
	local material2 = -1

	local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
	if comp_mat ~= nil then
		ComponentSetValue( comp_mat, "material", tostring(material1) )
		ComponentSetValue( comp_mat, "material2", tostring(material2) )
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
