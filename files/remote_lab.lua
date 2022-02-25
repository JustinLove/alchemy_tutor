function at_spawn_remote_lab( x, y )
	local width, height = 512, 512
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/remote_lab_entrance.png",
		"", -- visual
		x, y,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/remote_lab_lab.png",
		"", -- visual
		x + width, y,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

-- 19,45; off bottom of biome map
local remote_lab_x = 8704
local remote_lab_y = 23040
local entrance_x = 330
local entrance_y = 77

function at_get_lab_location()
	local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )

	local x = remote_lab_x + ( ( iteration % 8 ) * 1024 )
	local y = remote_lab_y + ( math.floor( iteration / 8 ) * 512 )
	return x, y
end

function at_get_entrance_location()
	local x, y = at_get_lab_location()
	x = x + entrance_x
	y = y + entrance_y
	return x, y
end

function at_remember_return_location( teleport_back_x, teleport_back_y )
	print( "teleported from: " .. tostring(teleport_back_x) .. ", " .. tostring(teleport_back_y) )
	-- - 50
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", tostring( teleport_back_x ) )
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", tostring( teleport_back_y ) )
end

