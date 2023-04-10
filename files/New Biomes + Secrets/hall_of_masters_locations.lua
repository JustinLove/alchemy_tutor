dofile_once( 'mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_locations.lua' )

for _,loc in ipairs(at_lab_locations) do
	if loc.x == 4096 and loc.y == 5632 then
		loc.x = 7680
		loc.east_access = nil
		loc.west_access = 'west_access'
	end
end
