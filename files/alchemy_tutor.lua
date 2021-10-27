
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

	spawn_potion( "air", x+59, y+37 )
	spawn_potion( "magic_liquid_movement_faster", x+67, y+37 )
	spawn_potion( "slime", x+76, y+37 )
end

function spawn_lab_anywhere( x, y )
	spawn_lab( x, y, true )
end

function spawn_potion( material, x, y )
	local entity = EntityLoad( "data/entities/items/pickup/potion_empty.xml", x, y )
	AddMaterialInventoryMaterial(entity, material, 1000)
end
