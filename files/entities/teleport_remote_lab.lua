
function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		-- 
		-- print( "teleported from: " .. from_x .. ", " .. from_y )
		-- - 50
		local teleport_back_x = from_x
		local teleport_back_y = from_y + 20

		GlobalsSetValue( "TELEPORT_REMOTE_LAB_POS_X", tostring( teleport_back_x ) )
		GlobalsSetValue( "TELEPORT_REMOTE_LAB_POS_Y", tostring( teleport_back_y ) )

	  EntityLoad( "mods/alchemy_tutor/files/entities/spawn_lab.xml", to_x, to_y )
	end
end
