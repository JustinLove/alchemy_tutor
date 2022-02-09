RegisterSpawnFunction( 0xff9027a1, "at_spawn_remote_lab_meditation")
if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

function at_spawn_remote_lab_meditation( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab_meditation.xml", x, y - 5 )
end

function at_spawn_meditation_altar_vault( x, y )
	LoadPixelScene( "mods/alchemy_tutor/files/props/meditation_altar_vault.png", "mods/alchemy_tutor/files/props/meditation_altar_vault_visual.png", x-3, y-10, "", true )
end

function at_spawn_meditation_altar( x, y )
	LoadPixelScene( "mods/alchemy_tutor/files/props/meditation_altar.png", "mods/alchemy_tutor/files/props/meditation_altar_visual.png", x-5, y-15, "", true )
end
