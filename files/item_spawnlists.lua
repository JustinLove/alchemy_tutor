at_lab_chance = ModSettingGet("alchemy_tutor.lab_chance")
if at_lab_chance == nil then
	at_lab_chance = 1
end
--at_lab_chance = 9999999

local at_key_chance = math.floor(math.sqrt(at_lab_chance) * 10)
local at_remote_lab_key = "mods/alchemy_tutor/files/entities/remote_lab_meditation.xml"
if spawnlists then
	for k,list in pairs(spawnlists) do
		local chance = at_key_chance
		if k == 'potion_spawlist_liquidcave' then
			chance = at_key_chance * 2
		end
		table.insert(list.spawns, 1, {
			value_min = list.rnd_max + 1,
			value_max = list.rnd_max + chance,
			load_entity = at_remote_lab_key,
			offset_y = -5,
		})
		list.rnd_max = list.rnd_max + chance
	end
end

function at_remove_remote_lab_key()
	if not spawnlists then
		return
	end
	for k,list in pairs(spawnlists) do
		local chance = at_key_chance
		if k == 'potion_spawlist_liquidcave' then
			chance = at_key_chance * 2
		end
		local spawns = list.spawns
		for i = 1,#spawns do
			if spawns[i].load_entity == at_remote_lab_key then
				for k = 1,i-1 do
					local item = spawns[k]
					item.value_min = item.value_min - chance
					item.value_max = item.value_max - chance
				end
				list.rnd_max = list.rnd_max - chance
				table.remove( spawns, i )
				break
			end
		end
	end
end

--at_remove_remote_lab_key()
