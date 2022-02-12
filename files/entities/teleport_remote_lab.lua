dofile_once( "mods/alchemy_tutor/files/remote_lab.lua" )

local function remove_portal( from_x, from_y )
	local portals = EntityGetInRadiusWithTag( from_x, from_y, 10, "at_remote_lab_portal" )
	for i,v in ipairs( portals ) do
		EntityKill( v )
	end
end

local function spawn_lab( x, y )
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
local function get_lab_location()
	local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )

	local x = remote_lab_x + ( ( iteration % 6 ) * 512 )
	local y = remote_lab_y + ( iteration * 1024 )
	return x, y
end

local function get_entrance_location()
	local x, y = get_lab_location()
	x = x + entrance_x
	y = y + entrance_y
	return x, y
end

function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		remove_portal( from_x, from_y )
		EntityLoad("mods/alchemy_tutor/files/entities/meditation_altar_effect.xml", from_x, from_y-8)

		-- portal should already be spawned if coming via remote_lab_meditation, but just in case
		at_remember_return_location( from_x, from_y )

		local ex, ey = at_get_entrance_location()
		if to_x ~= ex or to_y ~= ey then
			EntitySetTransform( entity_teleported, ex, ey )
		end

		-- again, lab should already be down via meditation, but game ignores duplicate pixel scenes, so might as well be safe
		local lx, ly = at_get_lab_location()
		at_spawn_remote_lab( lx, ly )

		local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )
		GlobalsSetValue( "AT_REMOTE_LAB_COUNT", tostring( iteration+1 ) )
	end
end
