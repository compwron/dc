select core_user.email, core_usermailing.mailing_id, count(*) as c
from core_click
         join core_usermailing on core_click.user_id = core_usermailing.user_id
         join core_user on core_click.user_id = core_user.id
where core_click.created_at > '2020-01-01'
group by core_user.email, core_usermailing.mailing_id
order by core_usermailing.mailing_id desc
limit 100