at_formula_list_hide_reward( 'void1' )
at_formula_list_hide_reward( 'void2' )

at_formula_list_append({
	{
		materials = {
			"vomit",
			"radioactive_liquid",
		},
		cauldron_contents = {
			"air",
			"air",
			"vomit",
		},
		output = "urine",
		rating = 9,
	},
	{
		name = "polyhp",
		materials = {
			"magic_liquid_charm",
			{ "blood", "blood", "blood", "blood_worm", "blood_cold" },
			{ "magic_liquid_polymorph", "magic_liquid_unstable_polymorph", "magic_liquid_random_polymorph" },
		},
		output = "magic_liquid_hp_regeneration",
		rating = 8,
	},
	{
		name = "accel",
		materials = {
			"gunpowder",
			"material_confusion",
		},
		cauldron_contents = {
			"air",
			"air",
			"material_confusion",
		},
		output = "magic_liquid_movement_faster",
		rating = 9,
	},
	{
		name = "goldhp",
		materials = {
			"gold",
			"magic_liquid_protection_all",
		},
		amounts = {0.1},
		cauldron = at_block_rock,
		cauldron_contents = {
			"gold",
			"gold",
			"air",
		},
		-- grass_ice
		-- fungi_creeping
		-- plant_material
		-- ceiling_plant_material
		-- fuse
		-- cloth_box2d
		-- rock_box2d (chain?)
		-- blood_thick
		cauldron_material = "rock_static",
		output = "magic_gas_hp_regeneration",
		rating = 7,
	},
	{
		name = "are_ambrosia",
		materials = {
			"magic_liquid_mana_regeneration",
			"alcohol",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"magic_liquid_mana_regeneration",
			"alcohol",
		},
		output = "magic_liquid_protection_all",
		rating = 7,
	},
	{
		materials = {
			"magic_liquid_unstable_teleportation",
			"blood",
		},
		cauldron_contents = {
			"air",
			"magic_liquid_unstable_teleportation",
			"blood",
			"blood",
			"blood",
		},
		output = "plasma_fading",
		fast_checking = true,
		rating = 5,
	},
})
