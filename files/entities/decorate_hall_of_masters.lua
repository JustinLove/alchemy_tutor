dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")
dofile_once("mods/alchemy_tutor/files/smallfolk.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local var = EntityGetFirstComponent( entity_id, "VariableStorageComponent" )
if var then
	local text = ComponentGetValue2( var, "value_string" )
	local scene_description = smallfolk.loads( text )
	at_decorate_hall_of_masters( pos_x, pos_y, scene_description )
end
