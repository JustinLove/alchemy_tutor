dofile_once( 'mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_locations.lua' )

AT_BIOME_WIDTH = BiomeMapGetSize() * 512

saved_locations[#saved_locations+1] =
	{ west={ name="Hall of Records",x=-5317-AT_BIOME_WIDTH,y=720},
		main={ name="Hall of Records",x=-5317,y=720},
		east={ name="Hall of Records",x=-5317+AT_BIOME_WIDTH,y=720}}

local function add_loc(loc)
	saved_locations[#saved_locations+1] = {
		west = {
			name = "Hall of Masters " .. loc.id,
			x = loc.x + at_hom_entrance_x - AT_BIOME_WIDTH,
			y = loc.y + at_hom_entrance_y,
		},
		main = {
			name = "Hall of Masters " .. loc.id,
			x = loc.x + at_hom_entrance_x,
			y = loc.y + at_hom_entrance_y,
		},
		east = {
			name = "Hall of Masters " .. loc.id,
			x = loc.x + at_hom_entrance_x + AT_BIOME_WIDTH,
			y = loc.y + at_hom_entrance_y,
		},
	}
end

for _,loc in ipairs(at_lab_locations) do
	add_loc(loc)
end
for _,loc in ipairs(at_special_lab_locations) do
	add_loc(loc)
end
