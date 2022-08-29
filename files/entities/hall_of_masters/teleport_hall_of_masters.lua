dofile_once( "mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters.lua" )

local function remove_portal( from_x, from_y )
	local portals = EntityGetInRadiusWithTag( from_x, from_y, 10, "at_remote_lab_portal" )
	for i,v in ipairs( portals ) do
		EntityKill( v )
	end
end

function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		remove_portal( from_x, from_y )

		at_remember_return_location( from_x, from_y )

		local ex, ey = at_get_entrance_location()
		if to_x ~= ex or to_y ~= ey then
			EntitySetTransform( entity_teleported, ex, ey )
		end

		at_spawn_return_portal( ex, ey - 35 )

		local iteration = tonumber( GlobalsGetValue( "AT_HALL_OF_MASTERS_COUNT", "0" ) )
		GlobalsSetValue( "AT_HALL_OF_MASTERS_COUNT", tostring( iteration+1 ) )
	end
end
