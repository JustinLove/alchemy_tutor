dofile_once("mods/alchemy_tutor/files/spawns.lua")

table.insert( g_pixel_scene_03, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/crypt_lab_v.png",
		visual_file		= "",--"mods/alchemy_tutor/files/coalmine_lab_visual.png",
		background_file	= "",
		is_unique		= 0
	})

table.insert( g_pixel_scene_01, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/crypt_lab_h.png",
		visual_file		= "", --"mods/alchemy_tutor/files/coalmine_lab_visual.png",
		background_file	= "",
		is_unique		= 0
	})
