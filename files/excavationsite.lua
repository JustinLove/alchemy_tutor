dofile_once("mods/alchemy_tutor/files/spawns.lua")

at_default_cauldron = at_suspended_container

table.insert( g_pixel_scene_04, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/excavation_lab_h.png",
		visual_file		= "",--"mods/alchemy_tutor/files/coalmine_lab_visual.png",
		background_file	= "",
		is_unique		= 0
	})

table.insert( g_pixel_scene_04_alt, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/excavation_lab_h_alt.png",
		visual_file		= "",--"mods/alchemy_tutor/files/coalmine_lab_visual.png",
		background_file	= "",
		is_unique		= 0
	})
