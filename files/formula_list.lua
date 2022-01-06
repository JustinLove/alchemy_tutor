at_formula_list = {
	{
		name = "toxicclean",
		materials = {
			{"water", "water", "water", "water", "water", "water_salt", "water_swamp", "swamp"},
		},
		cauldron_contents = "radioactive_liquid",
		output = "water",
		output2 = "water_swamp",
	},
	{
		name = "melt_steel",
		materials = {"magic_liquid_mana_regeneration"},
		cauldron = at_block,
		cauldron_material = "steel_static",
	},
	{
		name = "hastium",
		materials = {
			"magic_liquid_movement_faster",
			"magic_liquid_faster_levitation",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"magic_liquid_movement_faster",
			"magic_liquid_faster_levitation",
		},
		output = "magic_liquid_faster_levitation_and_movement",
	},
	{
		name = "washinvis",
		materials = {"water"},
		cauldron_contents = "magic_liquid_invisibility",
		output = "water",
	},
	{
		materials = {"magic_liquid_mana_regeneration"},
		cauldron_contents = "water",
		cauldron_material = "templebrick_static",
		output = "magic_liquid_mana_regeneration",
	},
	{
		name = "slimeclean",
		materials = {"water"},
		cauldron_contents = {"slime", "slime", "slime", "slime_green", "slime_yellow"},
		output = "air",
		output2 = "water",
	},
	{
		name = "disinfect",
		materials = {"alcohol"},
		cauldron_contents = {"slime", "slime", "slime", "slime_green", "slime_yellow"},
		output = "air",
		output2 = "alcohol",
	},
	{
		materials = {
			"material_confusion",
			"magic_liquid_berserk",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"material_confusion",
			"magic_liquid_berserk",
		},
		output = "magic_liquid_charm",
	},
	{
		materials = {
			"radioactive_liquid",
			"powder_empty",
		},
		cauldron_contents = "sand",
		cauldron_material = "air",
		cauldron_check_y = 10,
		other = at_planterbox,
		output = "fungi_creeping",
	},
	{
		materials = {"alcohol"},
		cauldron_contents = {"air", "air", "alcohol"},
		cauldron_material = "templebrick_static",
		other = at_frogs,
		output = "magic_liquid_berserk",
	},
	{
		name = "slimeboom",
		materials = {
			{"magic_liquid_movement_faster", "magic_liquid_faster_levitation"},
			"slime",
		},
		cauldron = at_block,
		cauldron_material = "templerock_soft",
	},
	{
		materials = {
			"brass",
			"liquid_fire",
		},
		cauldron = at_electrode,
		cauldron_material = "steel_static_unmeltable",
		output = "shock_powder",
	},
	{
		name = "manatele",
		materials = { "magic_liquid_mana_regeneration" },
		cauldron_contents = "magic_liquid_unstable_teleportation",
		output = "air",
	},
	{
		materials = {
			"magic_liquid_unstable_teleportation",
			"material_confusion",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"material_confusion",
		},
		output = "orb_powder",
	},
	{
		name = "silver1",
		materials = {
			"magic_liquid_random_polymorph",
			"diamond",
		},
		cauldron_contents = {
			"air",
			"air",
			"magic_liquid_random_polymorph",
		},
		output = "silver",
	},
	{
		name = "silver2",
		materials = {
			"gold",
			"magic_liquid_random_polymorph",
		},
		amounts = {0.4},
		cauldron_contents = {
			"air",
			"air",
			"magic_liquid_random_polymorph",
		},
		output = "silver",
	},
	{
		name = "silver3",
		materials = {
			"copper",
			"brass",
			"water",
		},
		cauldron_contents = {
			"air",
			"water",
		},
		output = "silver",
	},
	{
		name = "purebrass",
		materials = {
			"brass",
			"diamond",
		},
		output = "purifying_powder",
	},
	{
		name = "purelava",
		materials = {
			"purifying_powder",
		},
		cauldron_contents = "lava",
		cauldron_material = "templebrick_static",
		output = "air",
	},
	{
		materials = {
			"fire",
			"oil",
		},
		amounts = {0.1},
		cauldron_contents = "air",
		cauldron_minor = "meat",
		cauldron_material = "templebrick_static",
		cauldron_check_y = 10,
		other = at_meat,
		output = "meat_done",
	},
	{
		materials = {
			"honey",
			"diamond",
		},
		output = "magic_liquid_protection_all",
		output2 = "poison",
	},
	{
		name = "levi",
		materials = {
			"brass",
			"material_confusion",
		},
		cauldron_contents = {
			"air",
			"air",
			"material_confusion",
		},
		output = "magic_liquid_faster_levitation",
	},
	{
		materials = {
			"slime",
			"magic_liquid_unstable_teleportation"
		},
		cauldron_contents = {
			"magic_liquid_unstable_teleportation",
			"magic_liquid_unstable_teleportation",
			"magic_liquid_unstable_teleportation",
			"air",
			"slime",
		},
		output = "magic_liquid_teleportation",
	},
	--[[ awkward layering, super slow, can't find a good method
	{
		name = "unstablespread",
		materials = {
			"magic_liquid_unstable_teleportation",
		},
		amounts = {0.22},
		cauldron_contents = "water",
		cauldron_minor = "magic_liquid_teleportation",
		output = "magic_liquid_unstable_teleportation",
	},
	--]]
	{
		name = "drunktele",
		materials = { "alcohol" },
		cauldron_contents = "magic_liquid_teleportation",
		output = "magic_liquid_unstable_teleportation",
	},
	{
		materials = {
			"blood_worm",
			"magic_liquid_worm_attractor",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"blood_worm",
			"magic_liquid_worm_attractor",
		},
		output = "material_confusion",
	},
	{
		materials = {
			"material_confusion",
			"oil",
			"blood",
		},
		cauldron_contents = {
			"material_confusion",
			"oil",
			"blood",
			"blood",
			"blood",
			"air",
			"air",
		},
		output = "magic_liquid_unstable_polymorph",
	},
	{
		materials = {
			"magic_liquid_polymorph",
			"radioactive_liquid",
		},
		cauldron_contents = {
			"magic_liquid_polymorph",
			"radioactive_liquid",
			"radioactive_liquid",
			"air",
			"air",
			"air",
		},
		output = "magic_liquid_random_polymorph",
	},
	{
		materials = {
			"blood",
			"poison", -- evaporating
		},
		cauldron_contents = {
			"air",
			"blood",
		},
		output = "slime",
	},
	{
		materials = {
			"silver",
			"copper",
			"blood",
		},
		cauldron_contents = {
			"blood",
			"air",
		},
		output = "diamond",
	},
	{
		materials = {
			"silver",
			"magic_liquid_polymorph",
		},
		output = "copper",
	},
	{
		materials = { "copper" },
		cauldron_contents = "magic_liquid_teleportation",
		output = "brass",
	},
	{
		materials = {
			"brass",
			"magic_liquid_unstable_teleportation",
		},
		cauldron_contents = {
			"air",
			"magic_liquid_unstable_teleportation",
			"magic_liquid_unstable_teleportation",
		},
		output = "metal_sand",
	},
	{
		name = "pureworm",
		materials = {
			"silver",
			"diamond",
		},
		cauldron_contents = "blood_worm",
		output = "purifying_powder",
		output2 = "water", -- purifying_powder purifies the worm blood
	},
	{
		name = "oddwater",
		materials = {"water"},
		cauldron = at_block,
	},
	{
		name = "oddmana",
		materials = {"magic_liquid_mana_regeneration"},
		cauldron = at_block,
	},
	{
		name = "oddamb",
		materials = {"magic_liquid_protection_all"},
		cauldron = at_block,
	},
	--[[
	{
		name = "oddfire",
		materials = {"fire"},
		cauldron = at_block,
	},
	--]]
	{
		name = "void1",
		materials = {
			"radioactive_liquid",
			"blood_worm",
		},
		cauldron_contents = {"fungi", "fungi", "fungi", "fungi_creeping", "fungi_green"},
		output = "void_liquid",
	},
	{
		name = "void2",
		materials = {
			"diamond",
			"magic_liquid_random_polymorph",
			"radioactive_liquid",
		},
		cauldron_contents = {
			"magic_liquid_random_polymorph",
			"radioactive_liquid",
			"radioactive_liquid",
			"air",
			"air",
		},
		output = "void_liquid",
	},
}
