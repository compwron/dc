select open_click_action.mailing_id,
       mailer_count,
       open_count,
       open_count / mailer_count   as avg_opens_per_mailer,
       click_count,
       click_count / mailer_count  as avg_clicks_per_mailer,
       action_count,
       action_count / mailer_count as avg_actions_per_mailer
from (
         select mailer_counts.mailing_id as mailing_id,
                (select count(*)
                 from core_usermailing
                 where core_usermailing.mailing_id = mailer_counts.mailing_id
                ) as mailer_count,
                (
                    select count(*)
                    from core_open
                    where core_open.mailing_id = mailer_counts.mailing_id
                ) as open_count,
                (
                    select count(*)
                    from core_click
                    where core_click.mailing_id = mailer_counts.mailing_id
                ) as click_count,
                (
                    select count(*)
                    from core_action
                    where core_action.mailing_id = mailer_counts.mailing_id
                ) as action_count
         from (
                  select core_mailing.id as mailing_id,
                         count(*)        as mailer_count
                  from core_usermailing
                           join core_mailing on core_usermailing.mailing_id = core_mailing.id
                  group by core_mailing.id
              ) as mailer_counts
     ) as open_click_action
order by open_click_action.mailing_id desc