at_formula_list_hide_reward( 'void1' )
at_formula_list_hide_reward( 'void2' )

at_formula_list_after( 'magic_liquid_charm', {
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
	} )

at_formula_list_after( 'magic_liquid_berserk', {
		materials = {
			"magic_liquid_charm",
			{ "blood", "blood", "blood", "blood_worm", "blood_cold" },
			{ "magic_liquid_polymorph", "magic_liquid_unstable_polymorph", "magic_liquid_random_polymorph" },
		},
		output = "magic_liquid_hp_regeneration",
	} )
