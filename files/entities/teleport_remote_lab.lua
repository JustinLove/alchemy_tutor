
function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		local portals = EntityGetInRadiusWithTag( from_x, from_y, 10, "at_remote_lab_portal" )
		for i,v in ipairs( portals ) do
			EntityKill( v )
		end

		-- 
		-- print( "teleported from: " .. from_x .. ", " .. from_y )
		-- - 50
		local teleport_back_x = from_x
		local teleport_back_y = from_y

		GlobalsSetValue( "TELEPORT_REMOTE_LAB_POS_X", tostring( teleport_back_x ) )
		GlobalsSetValue( "TELEPORT_REMOTE_LAB_POS_Y", tostring( teleport_back_y ) )

	  EntityLoad( "mods/alchemy_tutor/files/entities/spawn_lab.xml", to_x, to_y )

	  local portal = EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab_return.xml", to_x + 50, to_y - 50 )

		local teleport_comp = EntityGetFirstComponentIncludingDisabled( portal, "TeleportComponent" )

		local teleport_back_x = 0
		local teleport_back_y = 0

		-- get the defaults from teleport_comp(s)
		if( teleport_comp ~= nil ) then
			teleport_back_x, teleport_back_y = ComponentGetValue2( teleport_comp, "target" )
			--print( "teleport std pos:" .. teleport_back_x .. ", " .. teleport_back_y )
		end

		teleport_back_x = tonumber( GlobalsGetValue( "TELEPORT_REMOTE_LAB_POS_X", teleport_back_x ) )
		teleport_back_y = tonumber( GlobalsGetValue( "TELEPORT_REMOTE_LAB_POS_Y", teleport_back_y ) )

		if( teleport_comp ~= nil ) then
			ComponentSetValue2( teleport_comp, "target", teleport_back_x, teleport_back_y )
			-- ComponentGetValue2( teleport_comp, "target.y", teleport_back_y )
		end
	end
end
