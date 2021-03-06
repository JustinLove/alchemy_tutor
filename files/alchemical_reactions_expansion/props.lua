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

function at_potion_polyhp( x, y )
	local entity = EntityLoad( "data/entities/items/pickup/potion_empty.xml", x, y )
	AddMaterialInventoryMaterial(entity, "blood", 500)
	AddMaterialInventoryMaterial(entity, "magic_liquid_random_polymorph", 250)
	AddMaterialInventoryMaterial(entity, "magic_liquid_charm", 250)
	return entity
end

function at_potion_plasma( x, y )
	return at_container( "plasma_fading", 0.1, x, y )
end

function at_potion_magic_liquid( x, y )
	return at_container( "magic_liquid", 0.1, x, y )
end
