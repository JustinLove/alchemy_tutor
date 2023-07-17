dofile_once("mods/alchemy_tutor/files/spawns.lua")

if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

--g_pixel_scene_01 = {total_prob = 0}
--g_oiltank = g_pixel_scene_01

at_add_biome_pixel_scene('g_pixel_scene_01', 5, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/coalmine_lab_v.png",
		visual_file		= "mods/alchemy_tutor/files/biome_impl/coalmine_lab_v_visual.png",
		background_file	= "",
	})

-- 726647958
at_add_biome_pixel_scene('g_pixel_scene_02', 10.5, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/coalmine_lab_h.png",
		visual_file		= "mods/alchemy_tutor/files/biome_impl/coalmine_lab_h_visual.png",
		background_file	= "",
	})
