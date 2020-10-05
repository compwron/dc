# select core_page.name, count(*) as c
# from core_action
#          join core_page on core_action.page_id = core_page.id
# where created_user = 1
# group by core_page.name
# order by c desc

# for month x, what page made the most subscriptions, and how many

# top subscriptions page for
select name,
       ym,
       (
           select count(*)

           from core_action
                    join core_page on core_action.page_id = core_page.id
           where created_user = 1
             and date_format(core_action.created_at, '%Y-%m') = ym
           group by core_page.name, ym
           order by ym, c desc
           limit 1
       )
from (
         select core_page.name,
                date_format(core_action.created_at, '%Y-%m') as ym,
                count(*)                                     as c
         from core_action
                  join core_page on core_action.page_id = core_page.id
         where created_user = 1
           and core_action.created_at >= '2019-01-01'
         group by core_page.name, ym
         order by ym, c desc) enrollment_per_month_per_page
# group by name, ym
# order by ym desc

# join-now,2020-01,55
# contact-dream-corps,2020-01,46
# join-cut50,2020-01,35