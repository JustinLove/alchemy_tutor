local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

function at_spawn_lab( x, y )
	local width = 260
	local height = 130
	LoadPixelScene(
		--"mods/alchemy_tutor/files/crypt_lab_v.png",
		--"mods/alchemy_tutor/files/crypt_lab_h.png",
		--"mods/alchemy_tutor/files/vault_lab_v.png",
		--"mods/alchemy_tutor/files/vault_lab_h.png",
		--"mods/alchemy_tutor/files/rainforest_lab_v.png",
		--"mods/alchemy_tutor/files/rainforest_lab_h.png",
		--"mods/alchemy_tutor/files/snowcave_lab_v.png",
		--"mods/alchemy_tutor/files/snowcave_lab_h.png",
		--"mods/alchemy_tutor/files/excavation_lab_h.png",
		"mods/alchemy_tutor/files/coalmine_lab.png",
		--"mods/alchemy_tutor/files/coalmine_lab_alt.png",
		--"mods/alchemy_tutor/files/coalmine_lab_tall.png",
		"",
		--"mods/alchemy_tutor/files/coalmine_lab_visual.png",
		x - width/2, y + height,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

at_spawn_lab( pos_x, pos_y )