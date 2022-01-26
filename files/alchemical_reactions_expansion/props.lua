local at_are_path = "mods/alchemy_tutor/files/alchemical_reactions_expansion"

at_bin = {
	name = "bin",
	default_material = "wood_player_b2",
	spawn = function( set, x, y, index )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			at_are_path .. "/bin.png",
			"", -- visual
			x-18, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["ff613e02"] = at_material( set.cauldron_material, "wood_player_b2" ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x-8, y, 18, set, index )
		at_add_checker( nil, x+8, y, 18, set, index )

		return contents
	end
}

at_gold_statue = {
	name = "gold_statue",
	default_material = "gold_box2d",
	is_physics = true,
	spawn = function( set, x, y, index )
		LoadPixelScene(
			at_are_path .. "/table.png",
			"",
			x-18, y-18,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = at_material( set.cauldron_contents, "air" ),
				["ff613e00"] = at_material( set.cauldron_material, "wood" ),
			} -- color_to_matieral_table
		)

		local cauld = EntityLoad( at_are_path .."/gold_statue.xml", x, y - 18 )
		at_add_checker( cauld, x, y, 0, set, index )

		return "gold"
	end
}

at_hollow = {
	name = "hollow",
	default_material = "bluefungi_static",
	spawn = function( set, x, y, index )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			at_are_path .. "/hollow.png",
			"", -- visual
			x-18, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["ff786c42"] = at_material( set.cauldron_material, "bluefungi_static" ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 15, set, index )

		return contents
	end
}

