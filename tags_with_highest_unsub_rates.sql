select core_tag.name as "Tag",
       lpad( concat( format( 100 * sum( ( select count( distinct core_action.user_id ) from core_unsubscribeaction join core_action on (core_unsubscribeaction.action_ptr_id=core_action.id) join core_subscriptionhistory on (core_action.id = core_subscriptionhistory.action_id) where core_action.mailing_id = core_mailing.id  ) ) / sum( ( select count(*) from core_usermailing where core_usermailing.mailing_id = core_mailing.id ) ), 1 ), '%' ), 8, ' ' ) as "unsub_rate_all_pctd"
from core_mailing
         left join core_tag on ( exists ( select * from core_mailing_tags where core_mailing_tags.tag_id = core_tag.id and core_mailing_tags.mailing_id = core_mailing.id ) )
group by 1
having sum( ( select count( distinct core_action.user_id ) from core_unsubscribeaction join core_action on (core_unsubscribeaction.action_ptr_id=core_action.id) join core_subscriptionhistory on (core_action.id = core_subscriptionhistory.action_id) where core_action.mailing_id = core_mailing.id  ) ) / sum( ( select count(*) from core_usermailing where core_usermailing.mailing_id = core_mailing.id ) ) >= 0.3 / 100
order by 2 DESC