local at_are_path = "mods/alchemy_tutor/files/alchemical_reactions_expansion"

at_bin = {
	name = "at_bin",
	default_material = "wood_player_b2",
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		local contents = at_material( set.cauldron_contents, "air", first )
		LoadPixelScene(
			at_are_path .. "/bin.png",
			"", -- visual
			x-18, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["ff613e02"] = at_material( set.cauldron_material, "wood_player_b2", first ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x-8, y, 18, set, index )
		at_add_checker( nil, x+8, y, 18, set, index )

		return contents
	end
}

at_gold_statue = {
	name = "at_gold_statue",
	default_material = "gold_box2d",
	is_physics = true,
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		LoadPixelScene(
			at_are_path .. "/table.png",
			"",
			x-18, y-18,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = at_material( set.cauldron_contents, "air", first ),
				["ff613e00"] = at_material( set.cauldron_material, "wood", first ),
			} -- color_to_matieral_table
		)

		local cauld = EntityLoad( at_are_path .."/gold_statue.xml", x, y - 18 )
		at_add_checker( cauld, x, y, 0, set, index )

		return "gold"
	end
}

function at_record_gold_statue( x, y )
	return EntityLoad( at_are_path .."/gold_statue.xml", x, y )
end

at_hollow = {
	name = "at_hollow",
	default_material = "bluefungi_static",
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		local contents = at_material( set.cauldron_contents, "air", first )
		LoadPixelScene(
			at_are_path .. "/hollow.png",
			"", -- visual
			x-18, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["ff786c42"] = at_material( set.cauldron_material, "bluefungi_static", first ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 15, set, index )

		return contents
	end
}

function at_candle( x, y )
	local entity = EntityLoad( "data/entities/props/physics_candle_1.xml", x + 3, y )
	return entity
end

function at_cheese( x, y )
	LoadPixelScene(
		at_are_path .. "/record_cheese.png",
		"", -- visual
		x-4, y-6,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_plastic( x, y )
	LoadPixelScene(
		at_are_path .. "/record_plastic.png",
		"", -- visual
		x-4, y-6,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_endslime( x, y )
	LoadPixelScene(
		at_are_path .. "/record_endslime.png",
		"", -- visual
		x-4, y-6,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end
