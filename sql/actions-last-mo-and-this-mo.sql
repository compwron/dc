select user_id
from (
         select distinct user_id
         from core_action
                  left join core_unsubscribeaction
                            on core_unsubscribeaction.action_ptr_id = core_action.id
         where year(core_action.created_at) = 2021
           and month(core_action.created_at) = 1
     ) as now_users
where user_id in (
    select distinct user_id
    from core_action
             left join core_unsubscribeaction
                       on core_unsubscribeaction.action_ptr_id = core_action.id
    where year(core_action.created_at) = 2020
      and month(core_action.created_at) = 12
) # 3932 count
# 692018
# 704201
# 2862
# 2346
# 5252
# 686834
# 630995
# 7212