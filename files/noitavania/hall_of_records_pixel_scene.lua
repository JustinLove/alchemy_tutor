function at_add_hall_of_records( path )
	local text = ModTextFileGetContent( path )
	if not text then return end
	text = string.gsub( text, '</PixelSceneFiles>', "<File>mods/alchemy_tutor/files/noitavania/hall_of_records.xml</File>\r\n  </PixelSceneFiles>" )
	ModTextFileSetContent( path, text )
end
