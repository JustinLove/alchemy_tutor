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

local function clean_lab( pos_x, pos_y, entity_id )
	local entities = EntityGetInRadius( pos_x, pos_y, 520, "at_remote_lab_portal" )
	for i = 1,#entities do
		local id = entities[i]
		if id ~= entity_id and not EntityHasTag( id, "player_unit" ) then
			-- potion spill
			local inv = EntityGetComponentIncludingDisabled( id, "MaterialInventoryComponent" )
			if inv then
				for m = 1,#inv do
					ComponentSetValue2( inv[m], "on_death_spill", false )
				end
			end
			-- glass shards
			local scripts = EntityGetComponent( id, "LuaComponent" )
			if scripts then
				for s = 1,#scripts do
					EntityRemoveComponent( id, scripts[s] )
				end
			end
			-- collion sound seems to activate on death
			local audios = EntityGetComponent( id, "AudioComponent" )
			if audios then
				for a = 1,#audios do
					EntityRemoveComponent( id, audios[a] )
				end
			end
			EntityKill( id )
		end
	end
end

local function spawn_lab( x, y )
	print( DebugBiomeMapGetFilename() )
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

function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		remove_portal( from_x, from_y )
		remember_return_location( from_x, from_y )

		local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )
		GlobalsSetValue( "AT_REMOTE_LAB_COUNT", tostring( iteration+1 ) )

		to_y = to_y + iteration

		EntitySetTransform( entity_teleported, to_x, to_y )

		clean_lab( to_x + 256, to_yl + 256, entity_teleported )
		spawn_lab( to_x, to_y )
	end
end
