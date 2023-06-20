dofile_once( 'mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_locations.lua' )

at_lab_locations = {
	{ -- northwest corner, near space
		id = 'NW_SPACE',
		level = 2,
		x = 15872,
		y = -5632,
		west_access = 'west_access',
	},
	{ -- lake
		id = 'LAKE',
		level = 2,
		x = -16384,
		y = 1536,
		biome = 'water',
	},
	{ -- above pond
		id = 'POND',
		level = 1,
		x = 2048,
		y = -2048,
		east_access = 'sky_access',
	},
	{ -- west side of power plant along tower border
		id = 'WEST_ROBO',
		level = 3,
		x = 11264,
		y = 8192,
		east_access = 'east_access',
		local_materials = {
			'sand',
			'brass',
		}
	},
	{ -- west side of snowy chasm, east of hive
		id = 'HIVE_CHASM',
		level = 3,
		x = -12288,
		y = 8192,
		west_access = 'west_access',
		east_access = 'east_access',
		local_materials = {
			'honey',
			'snow',
		}
	},
	{ -- lower left forest
		id = 'SE_FOREST',
		level = 4,
		x = -16384,
		y = 14848,
		east_access = 'sky_access',
	},
}

for i,loc in ipairs(at_special_lab_locations) do
	if loc.x == -5632 and loc.y == 1024 then
		table.remove( at_special_lab_locations, i )
	end
end
