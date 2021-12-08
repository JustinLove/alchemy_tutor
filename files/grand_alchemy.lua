--[[ from cheatgui
MIT License

Copyright (c) 2019 probable-basilisk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local function hax_prng_next(v)
  local hi = math.floor(v / 127773.0)
  local lo = v % 127773
  v = 16807 * lo - 2836 * hi
  if v <= 0 then
    v = v + 2147483647
  end
  return v
end

local function shuffle(arr, seed)
  local v = math.floor(seed / 2) + 0x30f6
  v = hax_prng_next(v)
  for i = #arr, 1, -1 do
    v = hax_prng_next(v)
    local fidx = v / 2^31
    local target = math.floor(fidx * i) + 1
    arr[i], arr[target] = arr[target], arr[i]
  end
end

local LIQUIDS = {"acid",
"alcohol",
"blood",
"blood_fungi",
"blood_worm",
"cement",
"lava",
"magic_liquid_berserk",
"magic_liquid_charm",
"magic_liquid_faster_levitation",
"magic_liquid_faster_levitation_and_movement",
"magic_liquid_invisibility",
"magic_liquid_mana_regeneration",
"magic_liquid_movement_faster",
"magic_liquid_protection_all",
"magic_liquid_teleportation",
"magic_liquid_unstable_polymorph",
"magic_liquid_unstable_teleportation",
"magic_liquid_worm_attractor",
"material_confusion",
"mud",
"oil",
"poison",
"radioactive_liquid",
"swamp",
"urine"  ,
"water",
"water_ice",
"water_swamp",
"magic_liquid_random_polymorph"}

local ORGANICS = {"bone",
"brass",
"coal",
"copper",
"diamond",
"fungi",
"gold",
"grass",
"gunpowder",
"gunpowder_explosive",
"rotten_meat",
"sand",
"silver",
"slime",
"snow",
"soil",
"wax",
"honey"}

local function copy_arr(arr)
  local ret = {}
  for k, v in pairs(arr) do ret[k] = v end
  return ret
end

local function random_material(v, mats)
  for _ = 1, 1000 do
    v = hax_prng_next(v)
    local rval = v / 2^31
    local sel_idx = math.floor(#mats * rval) + 1
    local selection = mats[sel_idx]
    if selection then
      mats[sel_idx] = false
      return v, selection
    end
  end
end

local function random_recipe(rand_state, seed)
  local liqs = copy_arr(LIQUIDS)
  local orgs = copy_arr(ORGANICS)
  local m1, m2, m3, m4 = "?", "?", "?", "?"
  rand_state, m1 = random_material(rand_state, liqs)
  rand_state, m2 = random_material(rand_state, liqs)
  rand_state, m3 = random_material(rand_state, liqs)
  rand_state, m4 = random_material(rand_state, orgs)
  local combo = {m1, m2, m3, m4}

  rand_state = hax_prng_next(rand_state)
  local prob = 10 + math.floor((rand_state / 2^31) * 91)
  rand_state = hax_prng_next(rand_state)

  shuffle(combo, seed)
  return rand_state, {combo[1], combo[2], combo[3]}, prob
end

function at_grand_alchemy()
  local seed = tonumber(StatsGetValue("world_seed"))
  local rand_state = math.floor(seed * 0.17127000 + 1323.59030000)

  for i = 1, 6 do
    rand_state = hax_prng_next(rand_state)
  end

  local lc_combo, ap_combo = {"?"}, {"?"}
  rand_state, lc_combo, lc_prob = random_recipe(rand_state, seed)
  rand_state, ap_combo, ap_prob = random_recipe(rand_state, seed)

  return lc_combo, ap_combo, lc_prob, ap_prob
end
