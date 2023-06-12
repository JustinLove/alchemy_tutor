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
