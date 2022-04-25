for i = 1, #at_formula_list do
	local f = at_formula_list[i]
	if f.output == 'void_liquid' then
		f.output2 = 'corruption_static'
	end
end

at_formula_list_append({
	{
		name = "are_urine",
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
		name = "are_polyhp",
		materials = {
			"magic_liquid_charm",
			{ "blood", "blood", "blood", "blood_worm", "blood_cold" },
			{ "magic_liquid_polymorph", "magic_liquid_unstable_polymorph", "magic_liquid_random_polymorph" },
		},
		output = "magic_liquid_hp_regeneration",
		record_material = "blood",
		rating = 8,
	},
	{
		name = "are_accel",
		materials = {
			"gunpowder",
			"material_confusion",
		},
		cauldron = at_bin,
		cauldron_contents = {
			"air",
			"air",
			"gunpowder",
		},
		cauldron_check_y = 25,
		output = "magic_liquid_movement_faster",
		rating = 9,
	},
	{
		name = "are_goldhp",
		materials = {
			"gold",
			"magic_liquid_protection_all",
		},
		amounts = {0.1},
		cauldron = at_gold_statue,
		check_for = at_material_presence,
		output = "magic_gas_hp_regeneration",
		record_spawn = at_record_gold_statue,
		rating = 4,
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
		name = "are_plasma_fading",
		materials = {
			"magic_liquid_unstable_teleportation",
			"blood",
		},
		cauldron_contents = {
			"blood",
			"blood",
			"blood",
			"air",
			"magic_liquid_unstable_teleportation",
		},
		output = "plasma_fading",
		check_for = at_material_presence,
		rating = 5,
	},
	{
		name = "are_magic_liquid",
		materials = {
			"radioactive_liquid",
			"blood",
			"magic_liquid_unstable_teleportation",
		},
		cauldron_contents = {
			"air",
			"radioactive_liquid",
			"blood",
			"magic_liquid_unstable_teleportation",
		},
		cauldron = at_block_brick,
		cauldron_material = "templebrick_static",
		cauldron_check_y = 30,
		output = "magic_liquid",
		rating = 9,
	},
	{
		name = "are_plasmamana",
		materials = {
			"magic_liquid_unstable_teleportation",
			"blood",
			"water",
		},
		cauldron_contents = {
			"blood",
			"blood",
			"water",
			"water",
			"air",
		},
		output = "magic_liquid_mana_regeneration",
		rating = 7,
	},
	{
		name = "are_pea_soup",
		materials = {
			"slime",
			"radioactive_liquid",
		},
		cauldron_contents = {
			"radioactive_liquid",
			"slime",
			"air",
		},
		output = "pea_soup",
		rating = 4,
	},
	{
		name = "are_endslime",
		materials = {
			"lava",
			"slime",
		},
		cauldron_contents = "air",
		cauldron_minor = "lava",
		output = "endslime",
		cauldron_check_y = 10,
		record_spawn = at_endslime,
		rating = 5,
	},
	{
		name = "are_poo",
		materials = {
			"urine",
			"soil",
		},
		cauldron_contents = {
			"air",
			"urine",
		},
		output = "poo",
		rating = 15,
	},
	{
		name = "are_melt_snow",
		materials = {
			"salt",
			"snow",
		},
		cauldron_contents = {
			"snow",
			"snow",
			"snow",
			"salt",
			"air",
		},
		output = "water",
		output2 = "water_salt",
		rating = 12,
	},
	{
		name = "are_salt",
		materials = {
			"fire",
			"urine",
			"oil",
		},
		amounts = {0.1},
		cauldron_contents = {
			"urine",
			"oil",
			"air",
		},
		output = "salt",
		rating = 18,
	},
	{
		name = 'are_polyclean',
		materials = {
			"magic_liquid_worm_attractor",
		},
		cauldron_contents = {
			"magic_liquid_polymorph",
			"magic_liquid_unstable_polymorph",
			"magic_liquid_random_polymorph",
		},
		output = "magic_liquid_worm_attractor",
		record_material = "magic_liquid_worm_attractor",
		rating = 5,
	},
	{
		name = 'are_cheese',
		materials = {
			"water_salt",
			"blood_worm",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"air",
			"blood_worm",
			"blood_worm",
			"water_salt",
		},
		output = "cheese_static",
		check_for = at_material_presence,
		record_spawn = at_cheese,
		rating = 17,
	},
	{
		name = "are_berserk",
		materials = {
			"magic_liquid_worm_attractor",
			"blood",
		},
		cauldron_contents = {
			"air",
			"magic_liquid_worm_attractor",
			"blood",
		},
		output = "magic_liquid_berserk",
		rating = 5,
	},
	{
		name = 'are_polymorph',
		materials = {
			"slime",
			"magic_liquid_unstable_polymorph"
		},
		cauldron_contents = {
			"magic_liquid_unstable_polymorph",
			"magic_liquid_unstable_polymorph",
			"magic_liquid_unstable_polymorph",
			"air",
			"slime",
		},
		output = "magic_liquid_polymorph",
		rating = 9,
	},
	{
		name = "are_tele",
		materials = {
			"coal",
			"material_confusion"
		},
		cauldron_contents = {
			"air",
			"material_confusion",
		},
		output = "magic_liquid_teleportation",
		rating = 9,
	},
	{
		name = 'are_invisburn',
		materials = {
			"magic_liquid_invisibility",
			"fire",
			"oil",
		},
		amounts = {0.1, 0.1},
		cauldron_contents = {
			"air",
			"air",
			"oil",
		},
		output = "magic_liquid_invisibility",
		record_material = "magic_liquid_invisibility",
		rating = 8,
	},
	{
		name = 'are_invisfungi',
		materials = {
			"slime",
		},
		cauldron = at_hollow,
		cauldron_material = "bluefungi_static",
		output = "magic_liquid_invisibility",
		rating = 9,
	},
	{
		name = 'are_flum',
		materials = {
			"blood_fungi",
		},
		cauldron = at_hollow,
		cauldron_material = "bluefungi_static",
		output = "material_confusion",
		rating = 18,
	},
	{
		name = 'are_wax',
		materials = {
			"blood_cold",
			"oil",
		},
		cauldron_contents = {
			"oil",
			"oil",
			"air",
		},
		output = "wax",
		record_spawn = at_candle,
		rating = 10,
	},
	{
		name = 'are_plastic_red',
		materials = {
			"fire",
			"magic_liquid_berserk",
			"oil",
		},
		amounts = {0.1},
		cauldron_contents = {
			"air",
			"air",
			"magic_liquid_berserk",
			"oil",
		},
		cauldron_check_y = 10,
		output = "plastic_red",
		output2 = "plastic_red_molten",
		rating = 13,
	},
	{
		name = "are_pure",
		materials = {
			"blood_worm",
			"water_ice",
		},
		cauldron_contents = {
			"water_ice",
			"water_ice",
			"blood_worm",
			"air",
			"air",
		},
		output = "purifying_powder",
		rating = 12,
	},
	{
		name = "are_sand_blue",
		materials = {
			"diamond",
			"sand",
		},
		output = "sand_blue",
		check_for = at_majority,
		rating = 13,
	},
	{
		name = "are_sand",
		materials = {
			"sand",
		},
		cauldron_contents = "sand_blue",
		cauldron_material = "air",
		output = "sand",
		rating = 9,
	},
	{
		name = "are_bluelava",
		materials = {
			"sand_blue",
			"lava",
		},
		output = "diamond",
		output2 = "templebrick_diamond_static",
		check_for = at_material_presence,
		rating = 12,
	},
	{
		name = "are_burnbone",
		materials = { "lava" },
		cauldron_contents = "bone",
		output = "air",
		record_material = "bone",
		rating = 9,
	},
	{
		name = "are_sodium",
		materials = {
			"bone",
			"sand",
		},
		cauldron_contents = {
			"bone",
			"bone",
			"air",
			"air",
			"sand",
		},
		output = "sodium",
		check_for = at_material_presence,
		rating = 15,
	},
	{
		name = "are_fungi",
		materials = {},
		cauldron = at_bin,
		cauldron_material = "wood",
		cauldron_contents = "sand",
		cauldron_check_y = 30,
		other = at_planterbox,
		output = "fungi",
		check_for = at_material_presence,
		rating = 15,
	},
	{
		name = "are_fungi_green",
		materials = {},
		cauldron = at_bin,
		cauldron_material = "wood",
		cauldron_contents = "sand_blue",
		cauldron_check_y = 30,
		other = at_planterbox,
		output = "fungi_green",
		check_for = at_material_presence,
		rating = 16,
	},
	{
		name = "are_oil",
		materials = {
			"brass",
			"radioactive_liquid",
		},
		cauldron_contents = {
			"radioactive_liquid",
			"radioactive_liquid",
			"air",
		},
		output = "oil",
		rating = 7,
	},
	{
		name = "are_poison1",
		materials = {
			"poison",
			"swamp",
		},
		amounts = {0.3},
		cauldron_contents = {
			"swamp",
			"swamp",
			"air",
		},
		output = "poison",
		rating = 9,
	},
	{
		name = "are_poison2",
		materials = {
			"slime",
		},
		cauldron = at_hollow,
		cauldron_material = "soil_dead",
		output = "poison",
		rating = 9,
	},
})
