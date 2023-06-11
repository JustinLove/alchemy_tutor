dofile_once("mods/alchemy_tutor/files/spawns.lua")

if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

at_add_biome_pixel_scene('g_pixel_scene_tall', 0.5, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/vault_lab_v.png",
		visual_file		= "",
		background_file	= "",
	})

at_add_biome_pixel_scene('g_pixel_scene_wide', 1, {
		material_file 	= "mods/alchemy_tutor/files/biome_impl/vault_lab_h.png",
		visual_file		= "mods/alchemy_tutor/files/biome_impl/vault_lab_h_visual.png",
		background_file	= "",
	})
