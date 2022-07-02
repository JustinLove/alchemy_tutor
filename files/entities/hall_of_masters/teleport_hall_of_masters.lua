dofile_once( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab.lua" )

local function remove_portal( from_x, from_y )
	local portals = EntityGetInRadiusWithTag( from_x, from_y, 10, "at_remote_lab_portal" )
	for i,v in ipairs( portals ) do
		EntityKill( v )
	end
end

function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		remove_portal( from_x, from_y )

		-- portal should already be spawned if coming via remote_lab_meditation, but just in case
		at_remember_return_location( from_x, from_y )

		local ex, ey = at_get_entrance_location()
		if to_x ~= ex or to_y ~= ey then
			EntitySetTransform( entity_teleported, ex, ey )
		end

		-- again, lab should already be down via meditation, but game ignores duplicate pixel scenes, so might as well be safe
		local lx, ly = at_get_lab_location()
		at_spawn_hall_of_masters( lx, ly )

		local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )
		GlobalsSetValue( "AT_REMOTE_LAB_COUNT", tostring( iteration+1 ) )
	end
end
