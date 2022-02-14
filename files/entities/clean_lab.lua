local function clean_lab( pos_x, pos_y )
	local entities = EntityGetInRadius( pos_x, pos_y, 520 )
	for i = 1,#entities do
		local id = entities[i]
		--print( id, tostring( EntityGetParent( id ) ), EntityGetFilename( id ), EntityGetTags( id ) )
		if EntityGetParent( id ) ~= 0 then
		elseif EntityHasTag( id, "potion" ) or EntityHasTag( id, "item_pickup" ) or EntityHasTag( id, "cauldron_checker" ) or EntityHasTag( id, "at_reward" ) then
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
			-- collision sound seems to activate on death
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
local pos_x, pos_y = EntityGetTransform( entity_id )

clean_lab( pos_x, pos_y )
