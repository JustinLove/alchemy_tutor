at_lab_locations = {
	{ -- west wall of desert chasm west of pyramid
		id = 'DESERT_CHASM',
		x = 4096,
		y = 5632,
		east_access = 'east_access',
	},
	{ -- ne gold
		id = 'NE_GOLD',
		x = 13824,
		y = -4096,
		biome = 'gold',
	},
	{ -- lake
		id = 'LAKE',
		x = -16384,
		y = 4096,
		biome = 'water',
	},
	{ -- above tree
		id = 'TREE',
		x = -2048,
		y = -4608,
		east_access = 'sky_access',
	},
	{ -- sw gold
		id = 'SW_GOLD',
		x = -15360,
		y = 15872,
		biome = 'gold',
	},
	{ -- se corner desert
		id = 'SE_CORNER',
		x = 15872,
		y = 14336,
		biome_modifier = 'hot',
		west_access = 'west_access',
	},
}

at_special_lab_locations = {
	{ -- hall of records, below alchemist
		id = 'RECORDS',
		x = -5632,
		y = 1024,
		west_access = 'records_access',
		west_alcove = 'ghost_deflector_crystal',
		local_materials = {
			'magic_liquid_berserk',
			--'magic_liquid_teleportation',
			--'magic_liquid_unstable_polymorph',
			'magic_liquid_charm',
			'magic_liquid_mana_regeneration',
			'copper',
		}
	},
}

at_hom_entrance_x = 512
at_hom_entrance_y = 213

function at_get_lab( x, y )
	local _,mx = at_check_parallel_pos( x )
	for _,loc in ipairs(at_lab_locations) do
		if loc.x == mx and loc.y == y then
			return loc
		end
	end
	for _,loc in ipairs(at_special_lab_locations) do
		if loc.x == mx and loc.y == y then
			return loc
		end
	end
end

function at_lab_origin(x, y, block_dx, block_dy)
	local _,mx = at_check_parallel_pos( x )
	local block_x = mx - mx % 512 - (block_dx or 0) * 512
	local block_y = y - y % 512 - (block_dy or 0) * 512
	return block_x, block_y
end