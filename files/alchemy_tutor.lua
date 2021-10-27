
function spawn_lab( x, y, skip_biome_checks )
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

	local material1 = "magic_liquid_movement_faster"
	local material2 = "magic_liquid_faster_levitation"
	local output = "magic_liquid_faster_levitation_and_movement"

	--spawn_potion( "air", x+59, y+37 )
	spawn_potion( material1, x+67, y+37 )
	spawn_potion( material2, x+76, y+37 )

	cauldron( output, x+128, y+88 )
	cauldron( output, x+187, y+88 )
end

function spawn_lab_anywhere( x, y )
	spawn_lab( x, y, true )
end

function spawn_potion( material, x, y )
	local entity = EntityLoad( "data/entities/items/pickup/potion_empty.xml", x, y )
	AddMaterialInventoryMaterial(entity, material, 1000)
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
