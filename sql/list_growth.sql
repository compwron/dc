select *
from (
         select core_list.name as list_name, core_user.source as user_source, count(*) as c
         from core_user
                  join core_subscription on core_user.id = core_subscription.user_id
                  join core_list on core_subscription.list_id = core_list.id
         group by core_list.name, core_user.source
         order by core_list.name, c desc) as source_breakdown
where c > 50