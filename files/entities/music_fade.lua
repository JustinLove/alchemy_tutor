local entity_id = GetUpdatedEntityID()

local lifetime = EntityGetFirstComponent( entity_id, "LifetimeComponent" )

local volume = 0.5
if lifetime then
	local kill_frame = ComponentGetValue2( lifetime, "kill_frame")
	local max = ComponentGetValue2( lifetime, "lifetime")
	volume = (kill_frame - GameGetFrameNum()) / max
end

local audio = EntityGetFirstComponent( entity_id, "AudioLoopComponent" )
if audio then
	ComponentSetValue2( audio, "m_volume", volume )
end
