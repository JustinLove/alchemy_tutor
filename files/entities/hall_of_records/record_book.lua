pages = {
	'0_7_0',
	'0_6_1',
	'0_6_0',
	'0_5_1',
	'0_5_0',
	'0_4_0',
	'0_3_0',
	'0_2_0',
	'0_1_0',
}

function record_book( x, y, title, desc )
	local id = EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_records/record_book.xml", x, y )
	local newitem = EntityGetFirstComponent( id, 'ItemComponent')
	if newitem then
		ComponentSetValue2( newitem, 'item_name', title )
		ComponentSetValue2( newitem, 'ui_description', desc )
	end
end

function record_book_changelog( x, y )
	local page = pages[1]
	record_book( x, y, '$at_title_changelog__'..page, '$at_book_changelog__'..page )
end
