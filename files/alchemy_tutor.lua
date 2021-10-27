
function spawn_lab( x, y, skip_biome_checks )
	local hastium = {
		material1 = "magic_liquid_movement_faster",
		material2 = "magic_liquid_faster_levitation",
		output = "magic_liquid_faster_levitation_and_movement",
	}
	local purify = {
		material1 = "brass",
		material2 = "diamond",
		output = "purifying_powder",
	}
	local levi = {
		material1 = "brass",
		material2 = "material_confusion",
		output = "magic_liquid_faster_levitation",
	}
	--spawn_lab_set( x, y, skip_biome_checks, hastium )
	--spawn_lab_set( x, y, skip_biome_checks, purify )
	spawn_lab_set( x, y, skip_biome_checks, levi )
end

function spawn_lab_set( x, y, skip_biome_checks, set )
	-- 59, 37
	-- 67, 37
	-- 76, 37

	LoadPixelScene(
		"mods/alchemy_tutor/files/coalmine_lab.png",
		"mods/alchemy_tutor/files/coalmine_lab_visual.png",
		--"data/biome_impl/coalmine/laboratory.png",
		--"data/biome_impl/coalmine/laboratory_visual.png",
		x, y,
		"", -- background
		not not skip_biome_checks, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = "air" }, -- color_to_matieral_table
		50 -- z index
	)

	--spawn_potion( "air", x+59, y+37 )
	spawn_container( set.material1, x+67, y+37 )
	spawn_container( set.material2, x+76, y+37 )

	cauldron( set.output, x+128, y+93 )
	cauldron( set.output, x+187, y+93 )
end

function spawn_lab_anywhere( x, y )
	spawn_lab( x, y, true )
end

function spawn_container( material_name, x, y )
	local entity
	if get_material_type( material_name) == "powder" then
    entity = EntityLoad("data/entities/items/pickup/powder_stash.xml", x, y)
		empty_container_of_materials( entity )
	else
		entity = EntityLoad( "data/entities/items/pickup/potion_empty.xml", x, y )
	end

	AddMaterialInventoryMaterial(entity, material_name, 1000)
end

function empty_container_of_materials(idx)
  for _ = 1, 1000 do -- avoid infinite loop
    local material = GetMaterialInventoryMainMaterial(idx)
    if material <= 0 then break end
    local matname = CellFactory_GetName(material)
    AddMaterialInventoryMaterial(idx, matname, 0)
  end
end

function get_material_type( material_name )
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

function cauldron( material, x, y )
	local entity = EntityLoad( "mods/alchemy_tutor/files/entities/caulderon_checker.xml", x, y )
	local material1 = CellFactory_GetType( material )
	local material2 = -1

	local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
	if comp_mat ~= nil then
		ComponentSetValue( comp_mat, "material", tostring(material1) )
		ComponentSetValue( comp_mat, "material2", tostring(material2) )
	end
end
