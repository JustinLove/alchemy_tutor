dofile_once("mods/alchemy_tutor/files/spawns.lua")

table.insert( g_pixel_scene_01, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_v.png",
		visual_file		= "",--"mods/alchemy_tutor/files/biome_impl/coalmine_lab_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["708040"] = { "soil_dark" } }
	})

table.insert( g_pixel_scene_02, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/rainforest_lab_h.png",
		visual_file		= "", --"mods/alchemy_tutor/files/biome_impl/coalmine_lab_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["708040"] = { "soil_dark" } }
	})
