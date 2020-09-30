select lpad( format( count(distinct core_user.id), 0 ), 12, ' ' ) as "user_count"
from core_user
where exists ( select * from core_subscription where core_subscription.user_id = core_user.id and core_subscription.list_id in ( 11 ) )
  and exists ( select * from core_action join core_page_tags using ( page_id ) where  core_action.user_id = core_user.id and core_page_tags.tag_id in ( {{ Tag_ids_for_Took_Action_On_A_Page_With_Tags }} ) )