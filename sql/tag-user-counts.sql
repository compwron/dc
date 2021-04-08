select core_tag.name, count(distinct core_user.id) as user_count
from core_user
         join core_subscription on core_subscription.user_id = core_user.id
         join core_action on core_action.user_id = core_user.id
         join core_page_tags on core_page_tags.page_id = core_action.page_id
         join core_tag on core_page_tags.tag_id = core_tag.id
group by core_tag.name
order by user_count desc
