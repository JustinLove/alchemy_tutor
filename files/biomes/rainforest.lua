dofile_once("mods/alchemy_tutor/files/spawns.lua")

table.insert( g_pixel_scene_01, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_v.png",
		visual_file		= "",
		background_file	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_v_background.png",
		is_unique		= 0
	})

table.insert( g_pixel_scene_02, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_h.png",
		visual_file		= "",
		background_file	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_h_background.png",
		is_unique		= 0
	})
