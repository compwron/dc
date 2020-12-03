# retention rate

# Customer retention rate formula
# Calculate customer retention rate with the formula ((E - N) / S) * 100 = X
# Start with the number of customers at the end of the time period (E)
# Subtract the number of new customers added in the time period (N)
# Divide the result by the number of customers at the beginning of the time period (S)
# Multiply by 100

# start with the most recent month
# current_subscribe_count =
# new_subscribes_count =
# unsubscribed_count =
# bsubscribed_at_beginning = current_subscribe_count - new_subscribes_count + unsubscribed_count

# ((current_subscribe_count - new_subscribes_count) / (current_subscribe_count - new_subscribes_count + unsubscribed_count))

select count(*)
from core_subscription
where list_id = 11 # 136039
select count(*), list_id
from core_subscription
group by list_id

select *
from core_subscription
where list_id = 11
order by id desc
limit 10

select *
from core_subscriptionhistory
order by id desc
limit 10


select count(*)
from core_subscription
where list_id = 11 # 136039

select count(distinct user_id)
from core_subscriptionhistory
         join core_subscriptionchangetype on core_subscriptionhistory.change_id = core_subscriptionchangetype.id
where core_subscriptionchangetype.name in ('subscribe', 'subscribe_import', 'subscribe_api', 'subscribe_uploader')
  and core_subscriptionhistory.created_at > '2020-11-01'
  and list_id = 11 # 741 w/o distinct, 735

select count(distinct user_id)
from core_subscriptionhistory
         join core_subscriptionchangetype on core_subscriptionhistory.change_id = core_subscriptionchangetype.id
where core_subscriptionchangetype.name in
      ('unsubscribe_bounce', 'unsubscribe', 'unsubscribe', 'unsubscribe_email', 'unsubscribe_import',
       'unsubscribe_spamcheck', 'unsubscribe_reengagement')
  and core_subscriptionhistory.created_at > '2020-11-01'
  and list_id = 11 # 1202

select ((current_subscribe_count - new_subscribes_count) /
        (current_subscribe_count - new_subscribes_count + unsubscribed_count)) as retention_rate,
       current_subscribe_count,
       unsubscribed_count,
       new_subscribes_count
from;

select current_subscribers.c, new_subscribers.c, unsubscribers.c
from (select count(*) as c
      from core_subscription
      where list_id = 11) as current_subscribers

select *
from core_subscriptionchangetype
# 1,2008-01-01 00:00:00,2008-01-01 00:00:00,subscribe,Subscribe,1
# 2,2008-01-01 00:00:00,2008-01-01 00:00:00,subscribe_import,Subscribed by Import,1
# 3,2008-01-01 00:00:00,2008-01-01 00:00:00,unsubscribe_bounce,Unsubscribe Bounce,0
# 4,2008-01-01 00:00:00,2008-01-01 00:00:00,unsubscribe,Unsubscribe,0
# 5,2008-01-01 00:00:00,2008-01-01 00:00:00,unsubscunsubscriberibe_admin,Unsubscribe Admin,0
# 6,2008-01-01 00:00:00,2008-01-01 00:00:00,unsubscribe_email,Unsubscribed by Feedback Loop (Clicked Spam),0
# 7,2008-01-01 00:00:00,2008-01-01 00:00:00,subscribe_api,Subscribed by API,1
# 8,2008-01-01 00:00:00,2008-01-01 00:00:00,unsubscribe_import,Unsubscribed by Import,0
# 9,2008-01-01 00:00:00,2008-01-01 00:00:00,subscribe_uploader,Subscribed by Uploader,1
# 10,2015-02-24 16:44:52,2015-02-24 16:44:52,unsubscribe_spamcheck,Unsubscribed by Spam Check for Actions.,0
# 11,2015-02-24 16:44:52,2015-02-24 16:44:52,subscribe_notspamcheck,"Resubscribed by admin, undo Spam Check.",1
# 12,2015-02-24 16:44:52,2015-02-24 16:44:52,unsubscribe_reengagement,Unsubscribed by re-engagement.,0
# 13,2015-02-24 16:44:52,2014-04-24 16:44:52,subscribe_merge,Subscribed by user merge.,1
# 14,2015-02-24 16:44:52,2014-04-24 16:44:52,unsubscribe_merge,Unsubscribed by user merge.,0
# 15,2017-08-01 16:44:52,2017-08-01 16:44:52,subscribe_migratedonreengagement,Put on re-engagement list.,1
# 16,2017-08-01 16:44:52,2017-08-01 16:44:52,unsubscribe_migratedoffreengagement,"Engaged, so moved off re-engagement list.",0
# 17,2018-05-10 12:00:00,2018-05-12 12:00:00,subscribe_admin,Subscribed by Admin,1


select name, count(distinct user_id) c
from core_subscriptionhistory
         join core_subscriptionchangetype on core_subscriptionhistory.change_id = core_subscriptionchangetype.id
where core_subscriptionhistory.created_at > '2020-11-01'
  and core_subscriptionhistory.list_id = 11
group by name
order by c desc
# unsubscribe,890
# subscribe_uploader,377
# subscribe,358
# unsubscribe_email,198
# unsubscribe_bounce,114
# unsubscribe_admin,3

# 3 + 114 + 198 + 890 = 1205
# 377 + 358 = 735