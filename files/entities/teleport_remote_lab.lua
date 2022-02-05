local function remove_portal( from_x, from_y )
	local portals = EntityGetInRadiusWithTag( from_x, from_y, 10, "at_remote_lab_portal" )
	for i,v in ipairs( portals ) do
		EntityKill( v )
	end
end

local function remember_return_location( teleport_back_x, teleport_back_y )
	-- print( "teleported from: " .. from_x .. ", " .. from_y )
	-- - 50
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", tostring( teleport_back_x ) )
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", tostring( teleport_back_y ) )
end

local function create_return_portal( x, y )
	remove_portal( x, y )
	local portal = EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab_return.xml", x, y )

	local teleport_comp = EntityGetFirstComponentIncludingDisabled( portal, "TeleportComponent" )

	local teleport_back_x = 0
	local teleport_back_y = 0

	-- get the defaults from teleport_comp(s)
	if( teleport_comp ~= nil ) then
		teleport_back_x, teleport_back_y = ComponentGetValue2( teleport_comp, "target" )
		--print( "teleport std pos:" .. teleport_back_x .. ", " .. teleport_back_y )

		teleport_back_x = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", teleport_back_x ) )
		teleport_back_y = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", teleport_back_y ) )

		ComponentSetValue2( teleport_comp, "target", teleport_back_x, teleport_back_y )
	end
end

function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		remove_portal( from_x, from_y )
		remember_return_location( from_x, from_y )

		local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )
		GlobalsSetValue( "AT_REMOTE_LAB_COUNT", tostring( iteration+1 ) )

		to_y = to_y + iteration

		EntitySetTransform( entity_teleported, to_x, to_y )

	  EntityLoad( "mods/alchemy_tutor/files/entities/spawn_lab.xml", to_x, to_y )

		create_return_portal( to_x + 50, to_y )
	end
end
