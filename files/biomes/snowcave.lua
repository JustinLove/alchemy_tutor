dofile_once("mods/alchemy_tutor/files/spawns.lua")

if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

--g_pixel_scene_01 = {total_prob = 0}
--g_oiltank = g_pixel_scene_01

table.insert( g_pixel_scene_01, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_v.png",
		visual_file		= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_visual.png",
		background_file	= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_background.png",
		is_unique		= 0
	})

table.insert( g_pixel_scene_01_alt, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_alt.png",
		visual_file		= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_visual.png",
		background_file	= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_background.png",
		is_unique		= 0
	})

table.insert( g_pixel_scene_02, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_h.png",
		visual_file		= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_h_visual.png",
		background_file	= "mods/alchemy_tutor/files/biome_impl/snowcave_lab_h_background.png",
		is_unique		= 0
	})
