select *
from core_list

# select * from core_subscription order by id desc limit 10
# select * from core_subscriptionhistory order by id desc limit 10
#
# # find in db where use is added to mail
#
# select * from core_user where email like '%...%'
#
# select count(*) from core_action where subscribed_user = 1 #
# select count(*) from core_subscription #
#
# # list growth by source and over time

select core_user.source, core_list.name, count(*) as c
from core_user
         join core_subscription on core_user.id = core_subscription.user_id
         join core_list on core_subscription.list_id = core_list.id
group by list_id, source, core_user.id
order by list_id, c
limit 10


select concat(year(core_user.created_at), '-', lpad(month(core_user.created_at), 2, '0')) as "year_montha",
       lpad(format(sum(if(subscription_status = 'subscribed', 1, 0)), 0), 12, ' ')        as "subscriber_count",
       core_user.source                                                                   as "user_source"
#        (select concat(core_page.title, ' (', core_page.id, ')')
#         from core_page
#         where core_page.id = (select core_action.page_id
#                               from core_action
#                               where core_user.id = core_action.user_id
#                                 and core_action.created_user = 1
#                               limit 1))                                                   as "created_on_page_title_id"
from core_user
where exists(select *
             from core_subscription
             where core_subscription.user_id = core_user.id
               and core_subscription.list_id in (3))
group by year_montha, user_source
order by year_montha desc
limit 7
