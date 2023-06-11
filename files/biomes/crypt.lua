dofile_once("mods/alchemy_tutor/files/spawns.lua")

if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

at_default_cauldron = at_brick_pit

at_add_biome_pixel_scene('g_pixel_scene_03', 4, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/crypt_lab_v.png",
		visual_file		= "",--"mods/alchemy_tutor/files/biome_impl/coalmine_lab_visual.png",
		background_file	= "",
	})

at_add_biome_pixel_scene('g_pixel_scene_01', 3, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/crypt_lab_h.png",
		visual_file		= "", --"mods/alchemy_tutor/files/biome_impl/coalmine_lab_visual.png",
		background_file	= "",
		is_unique		= 0
	})
