select core_subscriptionchangetype.name,
       change_id,
       month(core_subscriptionhistory.created_at) as month,
       count(distinct core_user.id)
from core_user
         join core_subscriptionhistory
              on (core_user.id = core_subscriptionhistory.user_id)
         join core_subscriptionchangetype on change_id = core_subscriptionchangetype.id
where list_id = 1
  and date_sub(current_date(), interval 1 year) <= core_subscriptionhistory.created_at
group by core_subscriptionchangetype.name, month(core_subscriptionhistory.created_at)
order by month(core_subscriptionhistory.created_at), core_subscriptionchangetype.name;