dofile_once("mods/alchemy_tutor/files/entities/teleport_remote_lab.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
clean_lab( pos_x, pos_y, entity_id )
