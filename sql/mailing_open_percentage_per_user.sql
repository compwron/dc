select core_usermailing.user_id                                                 as "user_id",
       sum((select count(distinct user_id)
                                     from core_open
                                     where core_open.mailing_id = core_mailing.id
                                       and core_open.user_id = core_usermailing.user_id)) /
                          sum(if(core_usermailing.id, 1, 0) as user_open_rate
from core_mailing
         left join core_usermailing on (core_usermailing.mailing_id = core_mailing.id)
group by 1
having sum((select count(distinct user_id)
            from core_open
            where core_open.mailing_id = core_mailing.id
              and core_open.user_id = core_usermailing.user_id)) / sum(if(core_usermailing.id, 1, 0)) >= 26.6 / 100
limit 100