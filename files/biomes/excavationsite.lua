dofile_once("mods/alchemy_tutor/files/spawns.lua")

if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

at_default_cauldron = at_suspended_container

at_add_biome_pixel_scene('g_pixel_scene_04', 7.9, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/excavation_lab_h.png",
		visual_file		= "",--"mods/alchemy_tutor/files/biome_impl/coalmine_lab_visual.png",
		background_file	= "",
	})

at_add_biome_pixel_scene('g_pixel_scene_04_alt', 7.8, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/excavation_lab_h_alt.png",
		visual_file		= "",--"mods/alchemy_tutor/files/biome_impl/coalmine_lab_visual.png",
		background_file	= "",
	})
