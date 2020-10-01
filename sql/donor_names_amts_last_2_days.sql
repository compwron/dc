select concat_ws( ' ', if( core_user.first_name != '', core_user.first_name, null ), if( core_user.middle_name != '', core_user.middle_name, null ), if( core_user.last_name != '', core_user.last_name, null ) ) as "name",
    core_order.user_id as "id",
    concat( date( core_transaction.created_at ), "" ) as "date",
    lpad( concat('$', format( core_order.total_converted, 2 ) ), 14, ' ' ) as "amount",
    lpad( format( ( select count(*) from core_order as user_orders left join core_transaction on user_orders.id = core_transaction.order_id where user_orders.user_id = core_order.user_id and user_orders.status = 'completed' and core_transaction.success = 1 and core_transaction.type = 'sale' and core_transaction.status in ( 'completed', '' ) and core_transaction.amount > 0 ), 0 ), 12, ' ' ) as "numbr_paymts",
    core_action.source as "source",
    ( select group_concat( distinct core_transaction.account order by account separator ', ' ) from core_transaction where core_transaction.order_id = core_order.id ) as "account",
    if(core_order.status = 'completed' and core_orderrecurring.status in ( 'active', 'past_due' ), 'yes', 'no') as "recurring_yn",
    concat( ( select core_page.title from core_page where core_action.page_id = core_page.id ), ' (', core_action.page_id , ')' ) as "page",
    ( select group_concat( core_tag.name separator ', ' ) from core_page_tags join core_tag on ( core_tag.id = core_page_tags.tag_id ) where core_action.page_id = core_page_tags.page_id ) as "pg_tags",
    concat_ws( ', ', if( length( core_user.address1 ), core_user.address1, null ), if( length( core_user.address2 ), core_user.address2, null ), if( length( core_user.city ), core_user.city, null ), if( length( core_user.state ), core_user.state, if( length( core_user.region ), core_user.region, null ) ), if( core_user.zip, concat_ws( '-', core_user.zip, if( length( core_user.plus4 ), core_user.plus4, null ) ), core_user.postal ), if( length( core_user.country ), core_user.country, null ) ) as "address",
    core_user.email as "email",
    ( select group_concat( core_actionfield.value separator ', ' ) from core_actionfield where core_actionfield.parent_id = core_action.id and core_actionfield.name = 'comments' ) as "comments"
from core_order
    left join core_user on core_user.id = core_order.user_id
    left join core_transaction on core_order.id = core_transaction.order_id and core_transaction.type in ( 'sale', 'credit' ) and core_transaction.success = 1
    left join core_action on core_action.id = core_order.action_id
    left join core_orderrecurring on core_order.id = core_orderrecurring.order_id
where core_transaction.created_at between date_sub( date( current_timestamp() ), interval 2 day ) and current_timestamp()
group by core_order.id, core_transaction.id
order by 3 DESC