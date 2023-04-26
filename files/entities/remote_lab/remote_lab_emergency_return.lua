local function spawn_return_portal( x, y )
	local portal = EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_return.xml", x, y )

	local teleport_comp = EntityGetFirstComponentIncludingDisabled( portal, "TeleportComponent" )

	local teleport_back_x = 0
	local teleport_back_y = 0

	-- get the defaults from teleport_comp(s)
	if( teleport_comp ~= nil ) then
		teleport_back_x, teleport_back_y = ComponentGetValue2( teleport_comp, "target" )
		--print( "teleport std pos:" .. teleport_back_x .. ", " .. teleport_back_y )

		teleport_back_x = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", teleport_back_x ) )
		teleport_back_y = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", teleport_back_y ) )

		--print( "teleport stored pos:" .. teleport_back_x .. ", " .. teleport_back_y )

		ComponentSetValue2( teleport_comp, "target", teleport_back_x, teleport_back_y )
	end
end

local function portal_check( x, y )
	local portals = EntityGetInRadiusWithTag( x, y, 250, "at_remote_lab_portal" )

	if #portals < 1 then
		spawn_return_portal( x, y )
		GamePrintImportant( "Emergency Return Activated", "Probably an incompatible biome mod, please report mods in use" )
	end
end


local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

portal_check( pos_x, pos_y )
EntityKill( entity_id )
