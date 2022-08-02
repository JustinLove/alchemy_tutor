dofile_once("data/scripts/lib/utilities.lua")

local stand_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( stand_id )

for _,container_id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 10, "potion")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(container_id) == container_id then
		--print( "found", container_id )
		local drains = EntityGetInRadiusWithTag(pos_x, pos_y - 36, 2, "at_bottle_filler_drain")
		--print( tostring(drains), #drains )
		if #drains < 1 then
			EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/bottle_filler_drain.xml", pos_x, pos_y - 36 )
		end
		return
	end
end
