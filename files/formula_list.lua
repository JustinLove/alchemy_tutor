--[[
# Rating system
0 - material in pot, water, could happen accidentally

## material accessibility
0 - water/toxic/slime/blood
1 - common potions
2 - environmental liquids/common environmental powders
3 - environmental powders/pouch spawns/uncommon potion (fire/gunpowder)
4 - enviornmental powders/solids
5 - previous alchemy required
6 - rare potions spawns (brine)
+ 1 dangerous/inconvenet material

## inventory swaps
0 - water
1 - pickup and add one
2 - empty pot a bit, add something
3 - layering matters
4 - powder mixing

## reaction speed
0 - spreading (mana/tele)
1 - toxic/water
2 - alcohol/slime
3 - water/invis
4 - cycling may be required
5 - impractical detection

## obscurity
0 - toxic/water
1 - mana/environemental reactions
2 - practical alchemy (charm)
3 - undesirable reactions / precursor to practical alchemy
4 - practical transmutation of metals
5 - impractial

## phyics objects
2 - wide target (mushrooms)
4 - precise target (frog in pot)


]]
at_formula_list = {
	{
		name = "toxicclean",
		materials = {
			{"water", "water", "water", "water", "water", "water_salt", "water_swamp", "swamp", "mud"},
		},
		cauldron_contents = "radioactive_liquid",
		output = "water",
		output2 = "water_swamp",
		rating = 0,
	},
	{
		materials = {"magic_liquid_mana_regeneration"},
		cauldron_contents = "water",
		cauldron_material = "steel_static_strong",
		output = "magic_liquid_mana_regeneration",
		record_material = "magic_liquid_mana_regeneration",
		rating = 3,
	},
	{
		name = "melt_steel",
		materials = {"magic_liquid_mana_regeneration"},
		cauldron = at_block_steel,
		cauldron_material = "steel_static",
		output = "magic_liquid_mana_regeneration",
		rating = 3,
	},
	{
		name = "manatele",
		materials = { "magic_liquid_mana_regeneration" },
		cauldron_contents = "magic_liquid_unstable_teleportation",
		output = "air",
		output_sign = "$at_burn",
		record_material = "liquid_fire",
		rating = 5,
	},
	{
		name = "slimeclean",
		materials = {"water"},
		cauldron_contents = {"slime", "slime", "slime", "slime_yellow"},
		output = "air",
		output2 = "water",
		record_material = "slime",
		rating = 5,
	},
	{
		name = "disinfect",
		materials = {"alcohol"},
		cauldron_contents = {"slime", "slime", "slime", "slime_yellow"},
		output = "air",
		output2 = "alcohol",
		record_material = "alcohol",
		rating = 5,
	},
	{
		name = "slimeboom",
		materials = {
			{"magic_liquid_movement_faster", "magic_liquid_faster_levitation"},
			"slime",
		},
		cauldron = at_block_brick,
		cauldron_material = "templerock_soft",
		check_for = at_explosion,
		cauldron_check_y = 25,
		record_material = "gunpowder",
		--record_spawn = at_potion_slimeboom,
		rating = 7,
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
		rating = 7,
	},
	{
		name = "washinvis",
		materials = {"water"},
		cauldron_contents = "magic_liquid_invisibility",
		output = "water",
		rating = 8,
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
		rating = 8,
	},
	{
		materials = {
			"blood_worm",
			"blood_cold",
		},
		amounts = {0.1},
		cauldron_contents = "air",
		output = "blood_worm",
		rating = 8,
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
		rating = 8,
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
		rating = 9,
	},
	{
		name = "levi",
		materials = {
			{"gold", "diamond", "silver", "copper", "brass", "metal_sand"},
			"material_confusion",
		},
		cauldron_contents = {
			"air",
			"air",
			"material_confusion",
		},
		output = "magic_liquid_faster_levitation",
		materials_sign = { gold = "$at_metal_powders" },
		rating = 9,
	},
	{
		name = "liquid_fire_evaporation",
		materials = {
			"liquid_fire",
		},
		cauldron_contents = {
			"magic_liquid_random_polymorph",
			"magic_liquid_polymorph",
			"magic_liquid_unstable_polymorph",
			"material_confusion",
		},
		output = "air",
		output2 = "liquid_fire",
		record_material = "liquid_fire",
		output_sign = "$at_lava_metal_evaporation",
		materials_sign = { magic_liquid_random_polymorph = "$at_the_liquid"},
		rating = 10,
	},
	{
		name = "lava_metal_evaporation",
		materials = {
			"lava",
			{"silver", "copper", "brass", "metal_sand"},
		},
		amounts = {0.1, 0.1},
		cauldron_contents = {
			"magic_liquid_random_polymorph",
			"magic_liquid_unstable_polymorph",
		},
		output = "air",
		output_sign = "$at_lava_metal_evaporation",
		materials_sign = { copper = "$at_metal_powders", magic_liquid_random_polymorph = "$at_the_liquid"},
		record_material = "metal_sand_molten",
		rating = 12,
	},
	{
		materials = {
			"radioactive_liquid",
			"powder_empty",
		},
		cauldron = at_pile,
		cauldron_contents = "sand",
		cauldron_check_y = 10,
		other = at_planterbox,
		other_material = "blood_fungi",
		output = "fungi_creeping",
		rating = 10,
	},
	{
		materials = {
			'water',
			{'soil_lush','soil_lush','fungisoil'},
			'powder_empty',
		},
		cauldron_contents = {
			"water",
			"air",
		},
		output = "swamp",
		rating = 11,
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
		rating = 9,
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
		rating = 10,
	},
	--]]
	{
		name = "drunktele",
		materials = { "alcohol" },
		cauldron_contents = "magic_liquid_teleportation",
		output = "magic_liquid_unstable_teleportation",
		rating = 11,
	},
	{
		materials = {
			"material_confusion",
			"oil",
			"blood",
		},
		cauldron_contents = {
			"blood",
			"blood",
			"blood",
			"air",
			"air",
			"material_confusion",
			"oil",
		},
		output = "magic_liquid_unstable_polymorph",
		rating = 10,
	},
	{
		materials = {
			"magic_liquid_polymorph",
			"radioactive_liquid",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"radioactive_liquid",
			"radioactive_liquid",
			"magic_liquid_polymorph",
		},
		output = "magic_liquid_random_polymorph",
		rating = 11,
	},
	{
		name = "oddwater",
		materials = {"water"},
		cauldron = at_block_brick,
		cauldron_check_y = 30,
		output = "magic_liquid_teleportation",
		rating = 7,
	},
	{
		name = "oddmana",
		materials = {"magic_liquid_mana_regeneration"},
		cauldron = at_block_brick,
		cauldron_check_y = 30,
		output = "acid",
		rating = 9,
	},
	{
		name = "oddamb",
		materials = {"magic_liquid_protection_all"},
		cauldron = at_block_brick,
		cauldron_check_y = 40,
		output = "steam",
		record_material = "magic_liquid_protection_all",
		rating = 9,
	},
	--[[
	{
		name = "oddfire",
		materials = {"fire"
		cauldron = at_block_brick,
		cauldron_check_y = 30,
		output = "lava",
		rating = 12,
	},
	]]
	{
		materials = {"alcohol"},
		cauldron_contents = {"air", "air", "alcohol"},
		other = at_frogs,
		other_material = "meat_frog",
		output = "magic_liquid_berserk",
		rating = 13,
	},
	{
		materials = {
			"brass",
			"liquid_fire", -- standard fire does not work, has to be [fire_strong]
		},
		cauldron = at_electrode,
		cauldron_material = "steel_static_unmeltable",
		output = "shock_powder",
		record_material = "liquid_fire",
		exclude_from_chains = true,
		rating = 12,
	},
	{
		name = "voidfungus",
		materials = { "void_liquid" },
		amounts = {0.1},
		cauldron = at_block_rock,
		cauldron_material = "rock_static_fungal",
		cauldron_check_y = 10,
		output = "void_liquid",
		record_spawn = at_potion_void,
		rating = 12,
	},
	{
		name = "void1",
		materials = {
			"radioactive_liquid",
			"blood_worm",
		},
		cauldron = at_fungus,
		cauldron_contents = {"fungi", "fungi", "fungi", "fungi_creeping", "fungi_green"},
		output = "void_liquid",
		check_for = at_material_presence,
		record_spawn = at_potion_void,
		rating = 10,
	},
	{
		name = "void2",
		materials = {
			"diamond",
			"magic_liquid_random_polymorph",
			"radioactive_liquid",
		},
		cauldron_contents = {
			"air",
			"air",
			"radioactive_liquid",
			"radioactive_liquid",
			"magic_liquid_random_polymorph",
		},
		output = "void_liquid",
		output2 = "corruption_static",
		check_for = at_material_presence,
		record_spawn = at_potion_void,
		rating = 12,
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
		check_for = at_majority,
		rating = 11,
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
		rating = 11,
	},
	{
		name = "silver3",
		materials = {
			"copper",
			"brass",
			"water",
		},
		cauldron_contents = {
			"water",
			"air",
		},
		output = "silver",
		check_for = at_majority,
		rating = 18,
	},
	{
		name = "purebrass",
		materials = {
			"brass",
			"diamond",
		},
		output = "purifying_powder",
		check_for = at_majority,
		rating = 17,
	},
	{
		name = "purelava",
		materials = {
			"purifying_powder",
		},
		cauldron_contents = "lava",
		check_for = at_explosion,
		record_material = "lava",
		rating = 10,
	},
	{
		materials = {
			"torch",
			"oil",
		},
		cauldron_contents = "air",
		cauldron_minor = "meat",
		cauldron_check_y = 10,
		check_for = at_material_presence,
		other = at_meat,
		output = "meat_done",
		record_spawn = at_meat_done,
		exclude_from_chains = true,
		rating = 15,
	},
	{
		materials = {
			"honey",
			"diamond",
		},
		output = "magic_liquid_protection_all",
		output2 = "poison",
		rating = 15,
	},
	{
		materials = {
			"blood",
			"poison", -- evaporating
		},
		cauldron_contents = {
			"blood",
			"air",
		},
		output = "slime",
		record_material = "poison",
		rating = 14,
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
		check_for = at_majority,
		rating = 19,
	},
	{
		materials = {
			{ "copper", "copper", "silver" },
			"magic_liquid_polymorph",
		},
		output = "magic_gas_polymorph",
		check_for = at_material_presence,
		cauldron_check_y = 35,
		rating = 14,
	},
	{
		materials = { "copper" },
		cauldron_contents = "magic_liquid_teleportation",
		output = "brass",
		rating = 13,
	},
	{
		materials = {
			"brass",
			"magic_liquid_unstable_teleportation",
		},
		cauldron_contents = {
			"magic_liquid_unstable_teleportation",
			"magic_liquid_unstable_teleportation",
			"air",
		},
		output = "metal_sand",
		rating = 13,
	},
	{
		name = "pureworm",
		materials = {
			"silver",
			"diamond",
		},
		cauldron_contents = "blood_worm",
		output = "purifying_powder",
		check_for = at_material_presence,
		exclude_from_chains = true, -- turns worm blood to water, can't get enough output
		rating = 15,
	},
	{
		materials = {
			"torch",
			"water_salt",
			"oil",
		},
		cauldron_contents = {
			"water_salt",
			"oil",
			"air",
		},
		output = "salt",
		rating = 18,
	},
	{
		materials = {
			"salt",
			"water",
		},
		cauldron_contents = {
			"water",
			"water",
			"air",
		},
		output = "water_salt",
		rating = 14,
	},
	{
		name = "hellslimeboom",
		materials = {{"magic_liquid_movement_faster", "magic_liquid_faster_levitation"}},
		cauldron = at_block_rock,
		cauldron_material = "endslime",
		check_for = at_explosion,
		cauldron_check_y = 25,
		rating = 9,
	},
	{
		materials = {
			"magic_liquid",
			"lava",
		},
		cauldron_contents = {
			"lava",
			"air",
			"air",
		},
		output = "static_magic_material",
		check_for = at_material_presence,
		rating = 17,
	},
	{
		materials = {
			{"slime_green", "slime_yellow"},
			"lava",
		},
		cauldron_contents = {
			"lava",
			"air",
			"air",
		},
		output = "fungi_green",
		output2 = "fungi_yellow",
		check_for = at_material_presence,
		rating = 13,
	},
	{
		materials = {
			"lava",
			"blood_worm",
		},
		amounts = {0.1},
		cauldron_contents = {
			"lava",
			"blood_worm",
			"air",
		},
		output = "magic_gas_worm_blood",
		check_for = at_material_presence,
		cauldron_check_y = 35,
		rating = 11,
	},
	{
		name = "wormsteam",
		materials = {
			"magic_gas_worm_blood",
			"steam",
		},
		output = "blood_worm",
		cauldron_check_y = 12,
		rating = 13,
	},
	{
		materials = {
			"lava",
			"vomit",
		},
		cauldron_contents = {
			"air",
			"air",
			"vomit",
		},
		output = "acid",
		rating = 12,
	},
	{
		materials = {
			"lava",
			"slime",
		},
		cauldron_contents = {
			"air",
			"air",
			"slime",
		},
		output = "endslime",
		rating = 8,
	},
	{
		name = "endslimetele",
		materials = {
			"magic_liquid_unstable_teleportation",
		},
		cauldron = at_block_rock,
		cauldron_material = "endslime",
		output = "magic_liquid_teleportation",
		rating = 9,
	},
	{
		materials = {
			"lava",
			"magic_liquid_unstable_teleportation", -- also stable, but don't want to give it out
		},
		amounts = {0.1},
		cauldron_contents = {
			"air",
			"air",
			"lava",
			"magic_liquid_unstable_teleportation",
		},
		output = "blood_cold_vapour",
		check_for = at_material_presence,
		cauldron_check_y = 35,
		rating = 9,
	},
	{
		name = "weaktele",
		materials = {
			"magic_liquid_weakness",
		},
		cauldron_contents = "magic_liquid_teleportation",
		output = "magic_liquid_unstable_teleportation",
		rating = 10,
	},
	{
		name = "weakbers",
		materials = {
			"magic_liquid_weakness",
			"magic_liquid_berserk",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"magic_liquid_weakness",
			"magic_liquid_weakness",
			"magic_liquid_berserk",
		},
		output = "water",
		rating = 9,
	},
	{
		name = "weakpoly",
		materials = {
			"magic_liquid_weakness",
			"magic_liquid_polymorph",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"magic_liquid_weakness",
			"magic_liquid_weakness",
			"magic_liquid_polymorph",
		},
		output = "magic_liquid_random_polymorph",
		rating = 10,
	},
	{
		name = "weaklevi",
		materials = {
			"magic_liquid_weakness",
			"magic_liquid_faster_levitation",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"magic_liquid_weakness",
			"magic_liquid_weakness",
			"magic_liquid_faster_levitation",
		},
		output = "radioactive_liquid",
		rating = 9,
	},
	{
		name = "weakmana",
		materials = {
			"magic_liquid_weakness",
			"magic_liquid_mana_regeneration",
		},
		cauldron_contents = {
			"air",
			"air",
			"air",
			"magic_liquid_weakness",
			"magic_liquid_weakness",
			"magic_liquid_mana_regeneration",
		},
		output = "steam",
		check_for = at_material_presence,
		cauldron_check_y = 35,
		rating = 9,
	},
	{
		name = "weakfungi",
		materials = {
			"magic_liquid_weakness",
		},
		cauldron = at_fungus,
		cauldron_contents = {"fungi", "fungi", "fungi", "fungi_creeping", "fungi_green"},
		output = "sand",
		check_for = at_material_presence,
		record_spawn = at_potion_void,
		rating = 10,
	},
	{
		name = "weakgold",
		materials = {
			"magic_liquid_weakness",
			{ "gold", "gold_molten" }
		},
		cauldron_contents = {
			"air",
			"air",
			"magic_liquid_weakness",
		},
		output = "silver",
		output2 = "silver_molten",
		check_for = at_majority,
		rating = 13,
	},
	{
		name = "weakdiamond",
		materials = {
			"magic_liquid_weakness",
			"diamond",
		},
		cauldron_contents = {
			"air",
			"air",
			"magic_liquid_weakness",
		},
		output = "radioactive_liquid",
		output2 = "water",
		rating = 12,
	},
	{
		name = "weaksalt",
		materials = {
			"magic_liquid_weakness",
			"salt",
		},
		amounts = {0.1},
		cauldron_contents = {"salt","air","air"},
		output = "smoke",
		check_for = at_material_presence,
		record_material = "salt",
		rating = 11,
	},
	{
		name = "weakgas",
		materials = {
			"magic_liquid_weakness",
			"acid_gas_static",
		},
		amounts = {0.1},
		cauldron_contents = "acid_gas_static",
		output = "magic_liquid_weakness",
		record_material = "acid_gas_static",
		rating = 8,
	},
	{
		name = "weakamb",
		materials = {
			"magic_liquid_weakness",
			"magic_liquid_protection_all",
		},
		output = "acid",
		output2 = "smoke",
		rating = 10,
	},
	{
		name = "weakslime",
		materials = {
			"magic_liquid_weakness",
			"slime",
		},
		cauldron = at_block_brick,
		cauldron_material = "templerock_soft",
		check_for = at_explosion,
		cauldron_check_y = 25,
		record_material = "gunpowder",
		rating = 7,
	},
	{
		name = "puswater",
		materials = {
			"pus",
			"water",
		},
		amounts = {0.1},
		cauldron_contents = {"air","air","water"},
		output = "pus",
		rating = 6,
	},
	{
		name = "pustoxic",
		materials = {
			"pus",
			"radioactive_liquid",
		},
		amounts = {0.1},
		cauldron_contents = {"air","air","radioactive_liquid"},
		output = "pus",
		rating = 8,
	},
	{
		name = "pusfungi",
		materials = {
			{"fungi", "fungi", "fungi_creeping"},
			"pus",
		},
		amounts = {0.1},
		cauldron_contents = {"air","air","pus"},
		output = "fungi",
		output2 = "fungi_creeping",
		rating = 9,
	},
	{
		name = "pusmetal",
		materials = {
			"pus",
			{"silver", "copper", "brass"},
		},
		output = "smoke",
		cauldron_contents = {"air","air","pus"},
		check_for = at_material_presence,
		cauldron_check_y = 35,
		record_material = "silver",
		rating = 12,
	},
	{
		materials = {
			"pus",
			"soil_lush",
		},
		cauldron_contents = {"air","air","pus"},
		output = "coal",
		rating = 15,
	},
	{
		materials = {
			"pus",
			"urine",
			"material_confusion",
		},
		cauldron_contents = { "pus", "urine", "material_confusion", "air", "air" },
		output = "magic_liquid",
		check_for = at_material_presence,
		rating = 20,
	},
	{
		materials = {
			"beer",
			"milk",
		},
		cauldron_contents = {"air","beer","milk"},
		output = "molut",
		check_for = at_majority,
		rating = 19,
	},
	{
		materials = {
			"vomit",
			"bone",
		},
		cauldron_contents = {"air","vomit","bone"},
		output = "magic_liquid_weakness",
		rating = 12,
	},
	{
		materials = {
			"silver",
		},
		cauldron_contents = "magic_liquid_teleportation",
		output = "magic_gas_teleport",
		check_for = at_material_presence,
		cauldron_check_y = 35,
		rating = 15,
	},
}

function at_formula_list_append( new_formulas )
	local start_length = #at_formula_list
	at_formula_list[start_length + #new_formulas] = {}
	for i = 1, #new_formulas do
		at_formula_list[start_length + i] = new_formulas[i]
	end
end

function at_formula_list_remove( existing_name )
	for i = 1, #at_formula_list do
		local f = at_formula_list[i]
		if (f.name or f.output) == existing_name then
			table.remove( at_formula_list, i )
			return
		end
	end
end

function at_formula_list_hide_reward( existing_name )
	for i = 1, #at_formula_list do
		local f = at_formula_list[i]
		if (f.name or f.output) == existing_name then
			f.hide_reward = true
			return
		end
	end
end


-- evaporating or impractical to bottle; never placed in an open bulk container or used in a master chain
at_volatile_material_list = {
	"poison",
	"acid",
	"blood_cold",
	"blood_fungi",
	"fire",
	"lava",
	"void_liquid",
	"orb_powder",
	"torch",
	"powder_empty",
}

-- slowly evaporates in hot areas, should be in flasks
at_evaporating_material_list = {
	"water",
	"water_salt",
	"water_ice",
}

-- cyclical, needs something in the loop to get started
at_extra_raw_materials = {
	{ "salt", "water_salt" },
	{ "magic_liquid_teleportation", "magic_liquid_unstable_teleportation" },
}

at_material_alias = {
	shock_powder = "$at_shock_powder", -- no name at all
	liquid_fire = "$at_liquid_fire", -- game calls it fire
	soil_lush = "$at_lush_soil", -- game just calls it soil
}

-- an expansion mod makes one of those loops have an entrance point
function at_extra_creatable( mat )
	for i = 1,#at_extra_raw_materials do
		local set = at_extra_raw_materials[i]
		for m = 1,#set do
			if set[m] == mat then
				table.remove( at_extra_raw_materials, i )
				return
			end
		end
	end
end
