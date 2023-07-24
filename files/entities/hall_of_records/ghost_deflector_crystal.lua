local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local function at_clear_ghosts( x, y )
	local enemies = EntityGetInRadiusWithTag( x, y, 480, "enemy" )
	local ghost = StringToHerdId( "ghost" )

	for _,enemy_id in ipairs(enemies) do
		local genome = EntityGetFirstComponent( enemy_id, "GenomeDataComponent" )
		if genome then
			local herd_id = ComponentGetValue2( genome, "herd_id" )
			if herd_id == ghost then
				-- attempt to remove disappear sound effect; doesn't seem to be working
				local scripts = EntityGetComponent( enemy_id, "LuaComponent" )
				if scripts then
					for s = 1,#scripts do
						EntityRemoveComponent( enemy_id, scripts[s] )
					end
				end
				EntityKill( enemy_id )
			end
		end
	end
end

at_clear_ghosts( pos_x, pos_y )
