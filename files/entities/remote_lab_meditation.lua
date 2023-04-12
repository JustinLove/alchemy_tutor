dofile_once( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab.lua" )

function setup_lab_teleport( entity_with_teleport )
	local lx, ly = at_get_lab_location()
	at_spawn_remote_lab( lx, ly )
end

dofile( "mods/alchemy_tutor/files/entities/box_meditation.lua" )
