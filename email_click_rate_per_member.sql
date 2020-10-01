select email,
       user_id,
       mailer_count,
       open_count,
       open_count / mailer_count   as avg_opens_per_mailer,
       click_count,
       click_count / mailer_count  as avg_clicks_per_mailer,
       action_count,
       action_count / mailer_count as avg_actions_per_mailer
from (
         select email,
                user_id,
                (select count(*)
                 from core_usermailing
                 where core_usermailing.user_id = user_mailers.user_id
                ) as mailer_count,
                (
                    select count(*)
                    from core_open
                    where core_open.user_id = user_mailers.user_id
                ) as open_count,
                (
                    select count(*)
                    from core_click
                    where core_click.user_id = user_mailers.user_id
                ) as click_count,
                (
                    select count(*)
                    from core_action
                    where core_action.user_id = user_mailers.user_id
                ) as action_count
         from (
                  select core_user.email as email,
                         core_user.id    as user_id,
                         count(*)        as mailer_count
                  from core_usermailing
                           join core_user on core_usermailing.user_id = core_user.id
                  group by core_user.email
              ) as user_mailers
     ) as open_click_action

