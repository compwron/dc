select core_user.email,
       case
           when core_open.user_id is NULL
               then 'not opened'
           else 'opened'
           end  as opened,
       count(*) as c
from core_user
         join core_usermailing on core_user.id = core_usermailing.user_id
         left join core_open
                   on (core_user.id = core_open.user_id and core_usermailing.mailing_id = core_open.mailing_id)
group by core_user.email, core_open.user_id
order by core_user.email desc
limit 10;

select *
from core_usermailing
         join core_user on core_user.id = core_usermailing.user_id
         JOIN core_open
              ON (core_user.id = core_open.user_id AND core_usermailing.mailing_id = core_open.mailing_id)
where core_user.email = 'example email' # shows only opens