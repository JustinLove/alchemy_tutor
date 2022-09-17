local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local radius = 300

local function killall( tag )
	local entities = EntityGetInRadiusWithTag( x, y, radius, tag )
	for _,id in ipairs(entities) do
		-- shame if the player teleported into poly at the wrong time
		-- though a fish that lands in poly will get spared too
		if not EntityHasTag( id, "polymorphed" ) then
			EntityKill( id )
		end
	end
end

killall( "helpless_animal" ) -- fish
killall( "enemy" ) -- eels
