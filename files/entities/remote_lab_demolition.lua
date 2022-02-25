dofile_once('mods/alchemy_tutor/files/remote_lab.lua')

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

at_collapse_lab( x, y )
