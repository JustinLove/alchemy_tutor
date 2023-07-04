--dofile_once( 'mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_locations.lua' )

for _,loc in ipairs(at_lab_locations) do
	if loc.x == 4096 and loc.y == 5632 then
		-- DESERT_CHASM
		loc.y = 3584
	elseif loc.x == 13824 and loc.y == -4096 then
		-- NE_GOLD
		loc.x = 21504
	elseif loc.x == 15872 and loc.y == 14336 then
		-- SE_CORNER
		loc.y = 15360
	end
end

for i,loc in ipairs(at_special_lab_locations) do
	if loc.x == -5632 and loc.y == 1024 then
		table.remove( at_special_lab_locations, i )
	end
end
