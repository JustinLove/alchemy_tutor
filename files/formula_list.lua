--[[
# Rating system
0 - material in pot, water, could happen accidentally

## material accessibility
0 - water/toxic/slime/blood
1 - common potions
2 - environmental liquids
3 - environmental powders/pouch spawns
4 - enviornmental powders/solids
5 - previous alchemy required
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
5 - meat/impractical detection

## obscurity
0 - toxic/water
1 - mana/environemental reactions
2 - practical alchemy (charm)
3 - undesirable reactions
4 - practical transmustation of metals
5 - impractial

## phyics objects
2 - wide target (mushrooms)
4 - precise target (frog in pot)


]]
at_formula_list = {
	{
		name = "toxicclean",
		materials = {
			{"water", "water", "water", "water", "water", "water_salt", "water_swamp", "swamp"},
		},
		cauldron_contents = "radioactive_liquid",
		output = "water",
		output2 = "water_swamp",
		rating = 0,
	},
	{
		materials = {"magic_liquid_mana_regeneration"},
		cauldron_contents = "water",
		cauldron_material = "templebrick_static",
		output = "magic_liquid_mana_regeneration",
		rating = 3,
	},
	{
		name = "melt_steel",
		materials = {"magic_liquid_mana_regeneration"},
		cauldron = at_block_steel,
		cauldron_material = "steel_static",
		rating = 3,
	},
	{
		name = "manatele",
		materials = { "magic_liquid_mana_regeneration" },
		cauldron_contents = "magic_liquid_unstable_teleportation",
		output = "air",
		rating = 5,
	},
	{
		name = "slimeclean",
		materials = {"water"},
		cauldron_contents = {"slime", "slime", "slime", "slime_green", "slime_yellow"},
		output = "air",
		output2 = "water",
		rating = 5,
	},
	{
		name = "disinfect",
		materials = {"alcohol"},
		cauldron_contents = {"slime", "slime", "slime", "slime_green", "slime_yellow"},
		output = "air",
		output2 = "alcohol",
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
			"brass",
			"material_confusion",
		},
		cauldron_contents = {
			"air",
			"air",
			"material_confusion",
		},
		output = "magic_liquid_faster_levitation",
		rating = 9,
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
		rating = 10,
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
			"material_confusion",
			"oil",
			"blood",
			"blood",
			"blood",
			"air",
			"air",
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
			"magic_liquid_polymorph",
			"radioactive_liquid",
			"radioactive_liquid",
			"air",
			"air",
			"air",
		},
		output = "magic_liquid_random_polymorph",
		rating = 11,
	},
	{
		name = "oddwater",
		materials = {"water"},
		cauldron = at_block_brick,
		rating = 9,
	},
	{
		name = "oddmana",
		materials = {"magic_liquid_mana_regeneration"},
		cauldron = at_block_brick,
		rating = 11,
	},
	{
		name = "oddamb",
		materials = {"magic_liquid_protection_all"},
		cauldron = at_block_brick,
		rating = 11,
	},
	--[[
	{
		name = "oddfire",
		materials = {"fire"},
		cauldron = at_block_brick,
		rating = 14,
	},
	--]]
	{
		materials = {"alcohol"},
		cauldron_contents = {"air", "air", "alcohol"},
		cauldron_material = "templebrick_static",
		other = at_frogs,
		output = "magic_liquid_berserk",
		rating = 13,
	},
	{
		materials = {
			"brass",
			"liquid_fire",
		},
		cauldron = at_electrode,
		cauldron_material = "steel_static_unmeltable",
		output = "shock_powder",
		rating = 12,
	},
	{
		name = "voidfungus",
		materials = { "void_liquid" },
		amounts = {0.1},
		cauldron = at_block_rock,
		cauldron_material = "rock_static_fungal",
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
		output2 = "corruption_static",
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
			"magic_liquid_random_polymorph",
			"radioactive_liquid",
			"radioactive_liquid",
			"air",
			"air",
		},
		output = "void_liquid",
		output2 = "corruption_static",
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
			"air",
			"water",
		},
		output = "silver",
		rating = 18,
	},
	{
		name = "purebrass",
		materials = {
			"brass",
			"diamond",
		},
		output = "purifying_powder",
		rating = 17,
	},
	{
		name = "purelava",
		materials = {
			"purifying_powder",
		},
		cauldron_contents = "lava",
		cauldron_material = "templebrick_static",
		output = "air",
		rating = 10,
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
		hide_reward = true,
		rating = 17,
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
			"air",
			"blood",
		},
		output = "slime",
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
		rating = 19,
	},
	{
		materials = {
			"silver",
			"magic_liquid_polymorph",
		},
		output = "copper",
		rating = 13,
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
			"air",
			"magic_liquid_unstable_teleportation",
			"magic_liquid_unstable_teleportation",
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
		output2 = "water", -- purifying_powder purifies the worm blood
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

