function at_spawn_remote_lab( x, y )
	local width, height = 512, 512
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/remote_lab.png",
		"", -- visual
		x, y,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

-- -20,24; ~ 15,48 on biome map
local remote_lab_x = -10240
local remote_lab_y = 17408
local entrance_x = 116
local entrance_y = 77

function at_get_lab_location()
	local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )

	local x = remote_lab_x + ( ( iteration % 6 ) * 512 )
	local y = remote_lab_y + ( iteration * 1024 )
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

