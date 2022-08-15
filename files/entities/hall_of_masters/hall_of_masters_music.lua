dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local volume = 0.01
local player = EntityGetInRadiusWithTag( pos_x, pos_y, 512, "player_unit" )[1]
if player ~= nil then
	local player_x, player_y = EntityGetTransform(player)
	local distance = get_distance(pos_x, pos_y, player_x, player_y)
	volume = math.min(1, math.max(0.01, 1 - (distance / 512)) * 1.5 )
	print(distance, volume)
end

local audio = EntityGetFirstComponent( entity_id, "AudioLoopComponent" )
if audio then
	ComponentSetValue2( audio, "m_volume", volume )
end
