local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

function at_spawn_lab( x, y )
	--local width, height = 260, 130
	--local width, height = 130, 260
	local width, height = 400, 200
	--local width, height = 200, 400
	--local width, height = 520, 260
	--local width, height = 260, 520
	LoadPixelScene(
		--"mods/alchemy_tutor/files/biome_impl/crypt_lab_v.png",
		--"mods/alchemy_tutor/files/biome_impl/crypt_lab_h.png",
		--"mods/alchemy_tutor/files/biome_impl/vault_lab_v.png",
		--"mods/alchemy_tutor/files/biome_impl/vault_lab_h.png",
		--"mods/alchemy_tutor/files/biome_impl/rainforest_lab_v.png",
		--"mods/alchemy_tutor/files/biome_impl/rainforest_lab_h.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcastle_lab_v.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcastle_lab_h.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcave_lab_v.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_alt.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcave_lab_h.png",
		--"mods/alchemy_tutor/files/biome_impl/excavation_lab_h.png",
		--"mods/alchemy_tutor/files/biome_impl/excavation_lab_h_alt.png",
		"mods/alchemy_tutor/files/biome_impl/coalmine_lab_h.png",
		--"mods/alchemy_tutor/files/biome_impl/coalmine_lab_h_alt.png",
		--"mods/alchemy_tutor/files/biome_impl/coalmine_lab_v.png",
		--"",
		--"mods/alchemy_tutor/files/biome_impl/vault_lab_h_visual.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_visual.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcave_lab_h_visual.png",
		"mods/alchemy_tutor/files/biome_impl/coalmine_lab_h_visual.png",
		--"mods/alchemy_tutor/files/biome_impl/coalmine_lab_v_visual.png",
		x - width/2, y - height/2,
		--"mods/alchemy_tutor/files/biome_impl/rainforest_lab_v_background.png",
		--"mods/alchemy_tutor/files/biome_impl/rainforest_lab_h_background.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcastle_lab_v_background.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcastle_lab_h_background.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcave_lab_v_background.png",
		--"mods/alchemy_tutor/files/biome_impl/snowcave_lab_h_background.png",
		--"data/biome_impl/snowcastle/greenhouse_background.png",
		--"data/biome_impl/snowcastle/bedroom_background.png",
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

local function at_reset_player( x, y )
	local players = EntityGetWithTag( "player_unit" )
	for _,player_id in ipairs(players) do
		EntitySetTransform( player_id, x, y )
	end
end

at_spawn_lab( pos_x, pos_y )
at_reset_player( pos_x, pos_y )
