dofile_once("mods/alchemy_tutor/files/entities/hall_of_records/record_book.lua")

function item_pickup( entity_item, entity_who_picked, name )
	local x,y = EntityGetTransform(entity_item)
	local olditem = EntityGetFirstComponent( entity_item, 'ItemComponent')
	if olditem then
		local title = ComponentGetValue2( olditem, 'item_name' )
		local desc = ComponentGetValue2( olditem, 'ui_description' )
		local index = string.find( title, '__', 1, true )
		local page = string.sub( title, index+2 )
		for i = 1,(#at_record_pages-1) do
			if at_record_pages[i] == page then
				title = string.gsub( title, page, at_record_pages[i+1] )
				desc = string.gsub( desc, page, at_record_pages[i+1] )
				break
			end
		end
		at_record_book( x, y, title, desc )
	end
	EntityKill( entity_item )
end
