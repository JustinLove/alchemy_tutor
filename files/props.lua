local at_mod_path = "mods/alchemy_tutor/files"

at_cauldron = {
	name = "at_cauldron",
	default_material = "steel_static_strong",
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		local contents = at_material( set.cauldron_contents, "air", first )
		LoadPixelScene(
			at_mod_path .. "/props/cauldron.png",
			"", -- visual
			x-18, y-39,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = contents,
				["fff2ddb2"] = set.cauldron_minor or contents,
				["ff786c42"] = at_material( set.cauldron_material, "steel_static_strong", first ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 18, set, index )

		return contents
	end
}

at_steel_pit = {
	name = "at_steel_pit",
	default_material = "steel_static_unmeltable",
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		local contents = at_material( set.cauldron_contents, "air", first )
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
	name = "at_brick_pit",
	default_material = "templebrick_static",
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		local contents = at_material( set.cauldron_contents, "air", first )
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
	name = "at_fungus",
	default_material = "wood_player_b2",
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		local contents = at_material( set.cauldron_contents, "fungi", first )
		LoadPixelScene(
			at_mod_path .. "/props/fungus.png",
			"", -- visual
			x-18, y-25,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["ff3abb32"] = contents,
				["ff36312e"] = set.cauldron_minor or "fungisoil",
				["ff613e02"] = at_material( set.cauldron_material, "wood_player_b2", first ),
			} -- color_to_matieral_table
		)

		at_add_checker( nil, x, y, 6, set, index )

		return contents
	end
}

at_suspended_container = {
	name = "at_suspended_container",
	default_material = "steel",
	is_physics = true,
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		local contents = at_material( set.cauldron_contents, "air", first )
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
	name = "at_electrode",
	default_material = "steel_static",
	spawn = function( set, x, y, index )
		local first = at_first_time( set )
		LoadPixelScene(
			at_mod_path .. "/props/electrode.png",
			at_mod_path .. "/props/electrode_visual.png",
			x-18, y-18,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{ ["fff0bbee"] = at_material( set.cauldron_contents, "air", first ),
				["ff404041"] = at_material( set.cauldron_material, "steel_static", first ),
			} -- color_to_matieral_table
		)

		local entity = EntityLoad( at_mod_path .. "/entities/shock_checker.xml", x, y-(set.cauldron_check_y or 18) )
		at_remember_formula( entity, set.name )
	end
}

function at_spawn_block( set, x, y, index, file )
	local first = at_first_time( set )
	local material = at_material( set.cauldron_material, "wizardstone", first )
	LoadPixelScene(
		file,
		"", -- visual
		x-18, y-39,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = at_material( set.cauldron_contents, "air", first ),
			["ff4c4356"] = material,
		} -- color_to_matieral_table
	)

	if set.output and not set.check_for then
		set.check_for = at_material_presence
	end
	at_add_checker( nil, x, y, 18, set, index )
end

at_block_brick = {
	name = "at_block_brick",
	default_material = "wizardstone",
	exclude_from_chains = true,
	spawn = function( set, x, y, index )
		return at_spawn_block( set, x, y, index, at_mod_path .. "/props/block_brick.png" )
	end
}

at_block_rock = {
	name = "at_block_rock",
	default_material = "wizardstone",
	exclude_from_chains = true,
	spawn = function( set, x, y, index )
		return at_spawn_block( set, x, y, index, at_mod_path .. "/props/block_rock.png" )
	end
}

at_block_steel = {
	name = "at_block_steel",
	default_material = "wizardstone",
	exclude_from_chains = true,
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

	EntityLoad( "mods/alchemy_tutor/files/entities/shears.xml", x, y - 13)
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

function at_meat_done( x, y )
	LoadPixelScene(
		at_mod_path .. "/props/meat_done.png",
		"", -- visual
		x-8, y-9,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		} -- color_to_matieral_table
	)
end

function at_thunderstone( x, y )
	local entity = EntityLoad( "data/entities/items/pickup/thunderstone.xml", x, y )
	return entity
end

function at_potion_slimeboom( x, y )
	local entity = EntityLoad( "data/entities/items/pickup/potion_empty.xml", x, y )
	AddMaterialInventoryMaterial(entity, "slime", 500)
	AddMaterialInventoryMaterial(entity, "magic_liquid_faster_levitation", 500)
	return entity
end

function at_potion_void( x, y )
	return at_container( "void_liquid", 0.1, x, y )
end

function at_mushroom( mush, x, y )
	if not mush then
		SetRandomSeed( x, y )
		mush = Random( 1, 5 )
	end
	EntityLoad( at_mod_path .. "/entities/mushroom_big_" .. mush .. ".xml", x, y )
end

function at_record_pedestals( x, y, material, contents )
	--print( 'ped', contents )
	LoadPixelScene(
		at_mod_path .. "/props/record_basin.png",
		"", -- visual
		x, y-48,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = contents,
			["ff786c44"] = at_material( material, "templebrick_static", true ),
		} -- color_to_matieral_table
	)
end

function at_ghost_deflector_base( x, y )
	LoadPixelScene(
		at_mod_path .. "/props/ghost_deflector_base.png",
		at_mod_path .. "/props/ghost_deflector_base_visual.png",
		x - 16, y - 12,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{} -- color_to_matieral_table
	)
end

function at_medium_bin( x, y, contents )
	LoadPixelScene(
		at_mod_path .. "/props/medium_tank.png",
		"", -- visual
		x-7, y,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = contents,
			["ff786c42"] = "steel_static_strong",
		} -- color_to_matieral_table
	)
end

function at_large_bin( x, y, contents )
	LoadPixelScene(
		at_mod_path .. "/props/large_tank.png",
		"", -- visual
		x-12, y-31,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = contents,
			["ff786c42"] = "steel_static_strong",
		} -- color_to_matieral_table
	)
end
