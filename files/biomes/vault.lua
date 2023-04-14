dofile_once("mods/alchemy_tutor/files/spawns.lua")

if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

table.insert( g_pixel_scene_tall, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/vault_lab_v.png",
		visual_file		= "",
		background_file	= "",
		is_unique		= 0
	})

table.insert( g_pixel_scene_wide, {
		prob   			= at_lab_chance,
		material_file 	= "mods/alchemy_tutor/files/biome_impl/vault_lab_h.png",
		visual_file		= "mods/alchemy_tutor/files/biome_impl/vault_lab_h_visual.png",
		background_file	= "",
		is_unique		= 0
	})
