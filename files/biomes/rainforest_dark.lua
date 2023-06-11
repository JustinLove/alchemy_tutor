dofile_once("mods/alchemy_tutor/files/spawns.lua")

if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

at_add_biome_pixel_scene('g_pixel_scene_01', 1.5, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_v.png",
		visual_file		= "",
		background_file	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_v_background.png",
		color_material = { ["708040"] = { "soil_dark" } }
	})

at_add_biome_pixel_scene('g_pixel_scene_02', 1.7, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_h.png",
		visual_file		= "",
		background_file	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_h_background.png",
		color_material = { ["708040"] = { "soil_dark" } }
	})
