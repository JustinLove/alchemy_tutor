local at_mod_path = "mods/alchemy_tutor/files"

at_cauldron = {
	name = "cauldron",
	default_material = "templebrick_static",
	spawn = function( set, x, y, index )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			at_mod_path .. "/props/cauldron.png",
			"", -- visual
			x-18, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["fff2ddb2"] = set.cauldron_minor or contents,
				["ff786c42"] = at_material( set.cauldron_material, "templebrick_static" ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 18, set, index )

		return contents
	end
}

at_steel_pit = {
	name = "steel pit",
	default_material = "steel_static_unmeltable",
	spawn = function( set, x, y, index )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			at_mod_path .. "/props/steel_pit.png",
			"", -- visual
			x-18, y-22,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["fff2ddb2"] = set.cauldron_minor or contents,
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 6, set, index )

		return contents
	end
}

at_brick_pit = {
	name = "brick pit",
	default_material = "templebrick_static",
	spawn = function( set, x, y, index )
		local contents = at_material( set.cauldron_contents, "air" )
		LoadPixelScene(
			at_mod_path .. "/props/brick_pit.png",
			"", -- visual
			x-26, y-29,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["fff2ddb2"] = set.cauldron_minor or contents,
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 8, set, index )

		return contents
	end
}

at_fungus = {
	name = "fungus",
	default_material = "wood_player_b2",
	spawn = function( set, x, y, index )
		local contents = at_material( set.cauldron_contents, "fungi" )
		LoadPixelScene(
			at_mod_path .. "/props/fungus.png",
			"", -- visual
			x-18, y-25,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["ff3abb32"] = contents,
				["ff36312e"] = set.cauldron_minor or "fungisoil",
				["ff613e02"] = at_material( set.cauldron_material, "wood_player_b2" ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 6, set, index )

		return contents
	end
}

at_suspended_container = {
	name = "suspended container",
	default_material = "steel",
	is_physics = true,
	spawn = function( set, x, y, index )
		local contents = at_material( set.cauldron_contents, "air" )
		local cauld = EntityLoad( at_mod_path .."/entities/suspended_container.xml", x, y - 18 )
		if contents ~= "air" then
			local comp_mat = EntityGetFirstComponent( cauld, "ParticleEmitterComponent" )
			if comp_mat ~= nil then
				ComponentSetValue2( comp_mat, "emitted_material_name", contents )
				ComponentSetValue2( comp_mat, "is_emitting", true )
			end
		end

		at_add_checker( cauld, x, y, 0, set, index )

		return contents
	end
}

at_electrode = {
	name = "electrode",
	default_material = "steel_static",
	spawn = function( set, x, y, index )
		LoadPixelScene(
			at_mod_path .. "/props/electrode.png",
			at_mod_path .. "/props/electrode_visual.png",
			x-18, y-18,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = at_material( set.cauldron_contents, "air" ),
				["ff404041"] = at_material( set.cauldron_material, "steel_static" ),
			} -- color_to_matieral_table
		)

		local entity = EntityLoad( at_mod_path .. "/entities/shock_checker.xml", x, y-(set.cauldron_check_y or 18) )
	end
}

function at_spawn_block( set, x, y, index, file )
	local material = at_material( set.cauldron_material, "wizardstone" )
	LoadPixelScene(
		file,
		"", -- visual
		x-18, y-39,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = at_material( set.cauldron_contents, "air" ),
			["ff4c4356"] = material,
		} -- color_to_matieral_table
	)

	if set.output and not set.check_for then
		set.check_for = at_material_presence
	end
	at_add_checker( nil, x, y, 18, set, index )
end

at_block_brick = {
	name = "block brick",
	default_material = "wizardstone",
	spawn = function( set, x, y, index )
		return at_spawn_block( set, x, y, index, at_mod_path .. "/props/block_brick.png" )
	end
}

at_block_rock = {
	name = "block rock",
	default_material = "wizardstone",
	spawn = function( set, x, y, index )
		return at_spawn_block( set, x, y, index, at_mod_path .. "/props/block_rock.png" )
	end
}

at_block_steel = {
	name = "block steel",
	default_material = "wizardstone",
	spawn = function( set, x, y, index )
		return at_spawn_block( set, x, y, index, at_mod_path .. "/props/block_steel.png" )
	end
}

function at_planterbox( x, y )
	LoadPixelScene(
		at_mod_path .. "/props/planterbox.png",
		"", -- visual
		x-25, y-13,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_frogs( x, y )
	LoadPixelScene(
		at_mod_path .. "/props/frogs.png",
		"", -- visual
		x-25, y-28,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_meat( x, y )
	LoadPixelScene(
		at_mod_path .. "/props/meat.png",
		"", -- visual
		x-25, y-29,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_mushroom( mush, x, y )
	if not mush then
		SetRandomSeed( x, y )
		mush = Random( 1, 5 )
	end
	EntityLoad( at_mod_path .. "/entities/mushroom_big_" .. mush .. ".xml", x, y )
end
