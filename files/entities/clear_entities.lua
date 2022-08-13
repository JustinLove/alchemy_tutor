local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local function at_clear_enemies( x, y )
	local enemies = EntityGetInRadiusWithTag( x, y, 1000, "enemy" )

	for _,enemy_id in ipairs(enemies) do
		EntityKill( enemy_id )
	end
end

local function at_visualize_backstage( x, y )
	local backstage = EntityGetInRadiusWithTag( x, y, 600, "at_backstage" )

	for _,entity_id in ipairs(backstage) do
		--print("backstage", entity_id)
		EntitySetComponentsWithTagEnabled(entity_id, "enabled_by_script", true)
	end
end

at_clear_enemies( pos_x, pos_y )
at_visualize_backstage( pos_x, pos_y )
