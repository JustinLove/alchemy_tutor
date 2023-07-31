local translations = [[
at_remote_lab,Hall of Apprentices,,,,,,,,,,,,,
at_hall_of_masters,Hall of Masters,,,,,,,,,,,,,
at_hall_of_records,Hall of Records,,,,,,,,,,,,,
at_building_ghost_deflector,Ghost Crystal,,,,,,,,,,,,,
at_log_ghost_deflector_death,Ghost Crystal Shattered,,,,,,,,,,,,,
at_logdesc_ghost_deflector_death,A chill runs up your spine,,,,,,,,,,,,,
at_log_reward_treasure,Treasure,,,,,,,,,,,,,
at_log_reward_knowledge,Knowledge,,,,,,,,,,,,,
at_log_reward_power,Power,,,,,,,,,,,,,
at_log_reward_magic,Magic,,,,,,,,,,,,,
at_log_reward_wealth,Wealth,,,,,,,,,,,,,
at_changelog,Changelog,,,,,,,,,,,,,
at_explosion,To create a violent combustion,,,,,,,,,,,,,
at_create,To create $0,,,,,,,,,,,,,
at_metal_powders,metal powders,,,,,,,,,,,,,
at_shock_powder,an electric spark,,,,,,,,,,,,,
at_lush_soil,lush jungle soil,,,,,,,,,,,,,
at_the_liquid,the liquid,,,,,,,,,,,,,
at_liquid_fire,intense liquid fire,,,,,,,,,,,,,
at_nothing,Nothing,,,,,,,,,,,,,
at_dissolve,To dissolve $2,,,,,,,,,,,,,
at_dissolve_into,To dissolve $1 into $0,,,,,,,,,,,,,
at_dissolve_metal,To dissolve metal,,,,,,,,,,,,,
at_burn,To burn $2,,,,,,,,,,,,,
at_lava_metal_evaporation,To evaporate most liquids,,,,,,,,,,,,,
at_mix1,"Apply $0",,,,,,,,,,,,,
at_mix2,"Mix $0 and $1",,,,,,,,,,,,,
at_mix3,"Mix $0, $1, and $2",,,,,,,,,,,,,
at_title_turning_pages,Notes on the arcane mysteries,,,,,,,,,,,,,
at_book_turning_pages,"The changelog has more pages if you have an empty inventory slot.\n \nCreatures often go into hiding when returning from the Halls.\nExercise caution lest you become surrounded.",,,,,,,,,,,,,
at_title_feedback,Welcome seeker of knowledge,,,,,,,,,,,,,
at_book_feedback,"I hope you are enjoying you journey.\nAs I finish up art and keep polishing things,\ntheres are some questions I am particularly interested in\n- Is the goal in Hall of Masters discoverable?\n(doesn't have to be right away - Noita is a game of mystery)\n- Is the material access in Hall of Masters too good?\n- Are there too many Halls of Masters?\n- Are the labs too common or not common enough?\n(this has a setting,but I want a good default)",,,,,,,,,,,,,
at_title_changelog__0_8_0,Alchemy Tutor 0.8.0,,,,,,,,,,,,,
at_book_changelog__0_8_0,"- Main path spawn rates reworked again\n  - the max value proved insufficient for high intensity mod testing.\n- Locations adjusted for NG+, but random overwrites can still occur\n- The distance/progression settings have been combined, making them mutually exclusive\n  - distance seemed to mainly do melt steel in low progress states.\n- New setting: No Freebies, for the alchemist who likes to do everything themselves.\n- New setting: Run Based Progress, start the progress system from scratch with every run\n- Hall of Records can update after initial spawn\n- Added a teleporter safety note to the arcane mysteries\n- Printing to log is now optional when Enable Logging is on.",,,,,,,,,,,,,
at_title_changelog__0_7_0,Alchemy Tutor 0.7.0,,,,,,,,,,,,,
at_book_changelog__0_7_0,"- Art update for Hall of Records\n- Signs on completed formula in Hall of Records\n- Changelog in Hall of Records\n- Two new evaporation reactions\n- One new bloody reaction\n- One new swampy reaction\n- Hall of Master rewards are proportional to intended complexity.\nFeedback appreciated.\n- Hall of Master locations have assigned complexity based on accessability.\nFeedback appreciated.\n- Main biome lab spawns were perhaps too common in some biomes\nand have been significnatly rebalanced. Feedback appreciated.",,,,,,,,,,,,,
at_title_changelog__0_6_1,Alchemy Tutor 0.6.1,,,,,,,,,,,,,
at_book_changelog__0_6_1,"- Adjusted appends to remove load order dependency with Graham's Things and Anvil of Destiny\n- Adjusted some fixed pixel scenes for Apotheosis map",,,,,,,,,,,,,
at_title_changelog__0_6_0,Alchemy Tutor 0.6.0,,,,,,,,,,,,,
at_book_changelog__0_6_0,"- Reduced maxium steps in Hall of Masters\n- Art update for main biome pixel scenes.\n- Art update for remote labs.\n- Vault horizontal potions have been sterilized in alcohol to try and improve stability.\n- Adjusted fixed scene positions for New Biomes + Secrets.\n- Adjusted fixed scene positions for Noitavania.\n- Added emergency return portal to remote lab in case we are in an incompatible biome mod.\n- Extracted hall of masters locations to separate file to ease integration by other mods.\n- Extracted hall of records pixel scene insert to separate file to ease integration by other mods.\n- Changed remote lab location setup for easier overriding.\n- Changed ghost crystal spawning for easier overriding.\n- Changes to translation setup to deal with changes made by other mods.\n- Notice: further changes that affect mod integration may be investigated.",,,,,,,,,,,,,
at_title_changelog__0_5_1,Alchemy Tutor 0.5.1,,,,,,,,,,,,,
at_book_changelog__0_5_1,"- Precautionary update for teleporters that could be generated into locations\nthat had been previously generated without their intended destination scenes.",,,,,,,,,,,,,
at_title_changelog__0_5_0,Alchemy Tutor 0.5.0 Hall of Masters Update,,,,,,,,,,,,,
at_book_changelog__0_5_0,"- Added Halls of Masters - the other labs are training, this is the test.\nComplete multi-step challenges for new prizes.\nAn entryway may sometimes be found in place of a remote lab, or simply go exploring.\n- Added option setting to not spawn fixed-position scenes,\nfor use with mods that alter the biome map (this of course removes several features)\n- Added several metal sand alternates to Levitatium recipe.\n- Powder sacks are 66% full instead of full, like in vanilla.\n- Frog cage includes a shotgun, in case your wands are inappropriate to the task.",,,,,,,,,,,,,
at_title_changelog__0_4_0,Alchemy Tutor 0.4.0 Hall of Records Update,,,,,,,,,,,,,
at_book_changelog__0_4_0,"- Added the Hall of Records, a treecheivment like area that can be found in the world",,,,,,,,,,,,,
at_title_changelog__0_3_0,Alchemy Tutor 0.3.0 Field Labs Update,,,,,,,,,,,,,
at_book_changelog__0_3_0,"- Added mini field labs to Overgrowth and Ancient Laboratory\n- Testing Dense Steel as the default cauldron material",,,,,,,,,,,,,
at_title_changelog__0_2_0,Alchemy Tutor 0.2.0 Remote Labs Update,,,,,,,,,,,,,
at_book_changelog__0_2_0,"- Remote Alchemy Labs for areas outside the main descent, which do not have pixel scenes,\nlook for the entryways where chests might spawn. Frequency of appearance has a separate setting.\n- Progression tracking. Formulas will be simplified the first time encountered,\nand the obscurity will be limited by the total number solved. (Master alchemists can disable this in settings.)\n- Rework on Hisii vertical; removed a cauldron to make space for sheltered potion storage.\n- Change vault horizontal potion platform from catwalk to solid to try and reduce breakage.\n- Tweaked cloth (pouches) to not conduct electricity.\nAn alchemist who takes the Electicity perk will probably still have a bad day, but at least you can use pouches now.\n- Put lab decoration on a delay to try and give terrain a chance to spawn in.\n- Added smoke to make torches more visible",,,,,,,,,,,,,
at_title_changelog__0_1_0,Alchemy Tutor 0.1.0 Remote Labs Update,,,,,,,,,,,,,
at_book_changelog__0_1_0,"- Went ahead and added Alchemical Reactions Expansion recipes, since I wanted to start testing them\n- As part of the above, made some major updates;\nthere are new fast detector types which should improve several formula;\nthings that were impractical before can now usually trigger a chest - including cooking meat.\n- Also as part of expansion, added a rating system so new recipes can sort in appropriately;\nthis resulted in many formula being reordered.\n- Added formula for salt and brine, since ARE has a salt formula.\n- Formula that need to start a fire now provide a torch wand instead of a fire potion.\n- The fungi garden provides garden shears in case you don't have a good spell on your wands\n- Attempt to fix occasional disappearance of coal pits containers when activated.\n- Tweak potion height in vault horiz.\n- Remove left barrier in first level horiz.\n- jungle pit is made of dense steel, which does not melt to mana.\n- offset material checkers to reduce simultaneous success.\n- removed cables from hisii base horiz.",,,,,,,,,,,,,
]]

local function append_translations(content)
	-- previous blank lines, copied from Noitavania
	while content:find("\r\n\r\n") do
		content = content:gsub("\r\n\r\n","\r\n");
	end
	--print(string.sub(content, -80))
	--print(string.byte(content, -3, string.len(content)))
	-- make sure our first linen doesn't get appended to last line
	local joint = ""
	if (string.sub(content, -1) ~= "\n") then
		joint = "\r\n"
	end
	-- inline lua strings get \n only; compound seems to be more expected by othe other mods
	if (string.sub(translations, -2) ~= "\r\n") then
		translations = string.gsub(translations, "\n", "\r\n")
	end
	local text = content .. joint .. translations
	--print(string.sub(text, -(string.len(translations) + 80)))
	return text
end

local function edit_file(path, f, arg)
	local text = ModTextFileGetContent( path )
	if text then
		ModTextFileSetContent( path, f( text, arg ) )
	end
end

function at_append_translations()
	edit_file( "data/translations/common.csv", append_translations)
end

function at_self_test_translations()
	if GameTextGet( "$at_remote_lab" ) == '' then
		GamePrint( 'Alchemy Tutor translations are broken, please report with your current mod list' )
	end
end
