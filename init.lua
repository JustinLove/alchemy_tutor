dofile_once("mods/alchemy_tutor/files/test.lua")

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	if GameHasFlagRun('AT_RUN_ONCE') then
		return
	end

	at_self_test_translations()
	at_test_player_spawned( player_entity )

	GameAddFlagRun('AT_RUN_ONCE')
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	at_test_world_initialized()

	if GlobalsGetValue( 'AT_SAVE_VERSION' ) == '' then
		GlobalsSetValue( 'AT_SAVE_VERSION', '1' )
	end
end

local function edit_file(path, f, arg)
	local text = ModTextFileGetContent( path )
	if text then
		ModTextFileSetContent( path, f( text, arg ) )
	end
end

local function intercept_ghosts( text )
	text = string.gsub( text, 'if %( #p > 0 %) then', 'local g = EntityGetInRadiusWithTag( x, y, 1000, "at_ghost_crystal" )\r\nif (#p > 0 and #g < 1) then' )
	--print(text)
	return text
end


function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
end

-- This code runs when all mods' filesystems are registered

ModMaterialsFileAdd("mods/alchemy_tutor/files/materials.xml")

dofile_once("mods/alchemy_tutor/files/translations.lua")
at_append_translations()

edit_file( "data/scripts/buildings/snowcrystal.lua", intercept_ghosts )

function OnModInit()

	at_test_lab_spawns()

	ModLuaFileAppend( "data/scripts/newgame_plus.lua", "mods/alchemy_tutor/files/newgame_plus/newgame_plus.lua" )

	ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/alchemy_tutor/files/biomes/coalmine.lua" )
	ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/alchemy_tutor/files/biomes/coalmine_alt.lua" )
	ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/alchemy_tutor/files/biomes/excavationsite.lua" )
	ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/alchemy_tutor/files/biomes/snowcave.lua" )
	ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/alchemy_tutor/files/biomes/snowcastle.lua" )
	ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/alchemy_tutor/files/biomes/vault.lua" )
	ModLuaFileAppend( "data/scripts/biomes/rainforest.lua", "mods/alchemy_tutor/files/biomes/rainforest.lua" )
	ModLuaFileAppend( "data/scripts/biomes/rainforest_dark.lua", "mods/alchemy_tutor/files/biomes/rainforest_dark.lua" )
	ModLuaFileAppend( "data/scripts/biomes/crypt.lua", "mods/alchemy_tutor/files/biomes/crypt.lua" )
	ModLuaFileAppend( "data/scripts/biomes/pyramid.lua", "mods/alchemy_tutor/files/biomes/crypt.lua" )
	ModLuaFileAppend( "data/scripts/biomes/fungiforest.lua", "mods/alchemy_tutor/files/biomes/fungiforest.lua" )

	-- liquidcave doesn't seem to have heart/chest spawns
	ModLuaFileAppend( "data/scripts/biomes/liquidcave.lua", "mods/alchemy_tutor/files/biomes/liquidcave.lua" )

	ModLuaFileAppend( "data/scripts/biomes/lake_deep.lua", "mods/alchemy_tutor/files/spawns.lua" )
	ModLuaFileAppend( "data/scripts/biomes/lake.lua", "mods/alchemy_tutor/files/spawns.lua" )
	ModLuaFileAppend( "data/scripts/biomes/desert.lua", "mods/alchemy_tutor/files/spawns.lua" )

	ModLuaFileAppend( "data/scripts/biomes/hills.lua", "mods/alchemy_tutor/files/biomes/hills_remote_lab.lua" )
	ModLuaFileAppend( "data/scripts/biomes/hills.lua", "mods/alchemy_tutor/files/biomes/hills_hall_of_records.lua" )


	ModLuaFileAppend( "data/scripts/biome_scripts.lua", "mods/alchemy_tutor/files/biome_scripts.lua" )

	if ModIsEnabled( 'Cheat Menu by Everfades' ) then
		ModLuaFileAppend( "mods/Cheat Menu by Everfades/files/locations.lua", "mods/alchemy_tutor/files/Cheat Menu by Everfades/locations.lua" )
	end

	if ModIsEnabled( 'alchemical_reactions_expansion' ) then
		ModLuaFileAppend( "mods/alchemy_tutor/files/props.lua", "mods/alchemy_tutor/files/alchemical_reactions_expansion/props.lua" )
		ModLuaFileAppend( "mods/alchemy_tutor/files/formula_list.lua", "mods/alchemy_tutor/files/alchemical_reactions_expansion/formula_list.lua" )
	end

	if ModIsEnabled( 'New Biomes + Secrets' ) then
		ModLuaFileAppend( "mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_locations.lua", "mods/alchemy_tutor/files/New Biomes + Secrets/hall_of_masters_locations.lua" )
	end

	if ModIsEnabled( 'noitavania' ) then
		dofile("mods/alchemy_tutor/files/noitavania/init.lua")
	end

	if ModIsEnabled( 'Apotheosis' ) then
		dofile("mods/alchemy_tutor/files/Apotheosis/init.lua")
	end
end

-- Noitavania does hard overwrite of pixel scenes in OnModInit
function OnModPostInit()
	if ModSettingGet("alchemy_tutor.fixed_pixel_scenes") then
		dofile( "mods/alchemy_tutor/files/entities/hall_of_records/hall_of_records_pixel_scene.lua" )
		at_add_hall_of_records( "data/biome/_pixel_scenes.xml" )
	end
end
