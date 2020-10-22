# limitatio of actionkit - cant create ybrid reports by type, only tools per query type (Mailings, users, etc)
# cant add tags clicked. in user, can click tags assocaited with actions theyve taken
# Andrew learns: do user under mailing
# harrison: open rate per email, not total opens


select core_usermailing.user_id,
       format(
                       100 * sum(
                           (
                               select count(distinct user_id)
                               from core_open
                               where core_open.mailing_id = core_mailing.id
                                 and core_open.user_id = core_usermailing.user_id)
                       ) /
                       sum(if(core_usermailing.id, 1, 0)), 1)
from core_mailing
         left join core_usermailing on (core_usermailing.mailing_id = core_mailing.id)
group by 1
having sum((select count(distinct user_id)
            from core_open
            where core_open.mailing_id = core_mailing.id
              and core_open.user_id = core_usermailing.user_id)) / sum(if(core_usermailing.id, 1, 0)) >= 26.6 / 100
limit 100