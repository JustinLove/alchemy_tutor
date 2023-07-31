at_record_pages = {
	'0_8_0',
	'0_7_0',
	'0_6_1',
	'0_6_0',
	'0_5_1',
	'0_5_0',
	'0_4_0',
	'0_3_0',
	'0_2_0',
	'0_1_0',
	'0_7_0',
}

function at_record_book( x, y, title, desc )
	local id = EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_records/record_book.xml", x, y )
	local newitem = EntityGetFirstComponent( id, 'ItemComponent')
	if newitem then
		ComponentSetValue2( newitem, 'item_name', title )
		ComponentSetValue2( newitem, 'ui_description', desc )
	end
end

function at_record_book_changelog( x, y, versions_back )
	local page = at_record_pages[math.min(#at_record_pages, math.max(1, versions_back or 1))]
	at_record_book( x, y, '$at_title_changelog__'..page, '$at_book_changelog__'..page )
end

function at_record_book_feedback( x, y )
	at_record_book( x, y, '$at_title_feedback', '$at_book_feedback' )
end

function at_record_physics_book( x, y )
	local entity = EntityLoad( "mods/alchemy_tutor/files/entities/log_book.xml", x, y )

	local item = EntityGetFirstComponent( entity, "ItemComponent" )
	if item then
		ComponentSetValue2( item, "ui_description", '$at_book_turning_pages')
		ComponentSetValue2( item, "item_name", '$at_title_turning_pages')
	end

	item = EntityGetFirstComponent( entity, "UIInfoComponent" )
	if item then
		ComponentSetValue2( item, "name", '$at_title_turning_pages')
	end

	item = EntityGetFirstComponent( entity, "AbilityComponent" )
	if item then
		ComponentSetValue2( item, "ui_name", '$at_title_turning_pages')
	end

	at_log_reset()
end

