local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local function at_clear_enemies( x, y )
	local enemies = EntityGetInRadiusWithTag( x, y, 1000, "destruction_target" )

	for _,enemy_id in ipairs(enemies) do
		EntityKill( enemy_id )
	end
end

at_clear_enemies( pos_x, pos_y )
