select concat(year(core_user.created_at), '-', lpad(month(core_user.created_at), 2, '0')) as "year_month",
       lpad(format(sum(if(subscription_status = 'subscribed', 1, 0)), 0), 12, ' ')        as "subscriber_count",
       core_user.source                                                                   as "source",
       (select concat(core_page.title, ' (', core_page.id, ')')
        from core_page
        where core_page.id = (select core_action.page_id
                              from core_action
                              where core_user.id = core_action.user_id
                                and core_action.created_user = 1
                              limit 1))                                                   as "created_on_page_title_id"
from core_user
where exists(select *
             from core_subscription
             where core_subscription.user_id = core_user.id and core_subscription.list_id in (3))
group by 1, 3, 4
order by 1 DESC