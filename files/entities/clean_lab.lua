function init( entity_id )
	local pos_x, pos_y = EntityGetTransform( entity_id )

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

local entity_id = GetUpdatedEntityID()
init( entity_id )
