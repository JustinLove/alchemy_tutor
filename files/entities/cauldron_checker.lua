--dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_failed( pos_x, pos_y )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

	local cauldrons = EntityGetInRadiusWithTag( x, y, 130, "cauldron_checker" )

	for i,v in ipairs( cauldrons ) do
		EntityKill( v )
	end

	y = y - 40
	EntityLoad( "data/entities/items/pickup/chest_random.xml", x, y)
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
end

--material_area_checker_failed = material_area_checker_success
--electricity_receiver_switched = material_area_checker_success
