select date(stat_date) as stats_at,
       coalesce(added, 0) as added,
       coalesce(removed, 0) as removed,
       coalesce(unsubscribed, 0) as unsubscribed,
       coalesce(engaged, 0) as engaged2,
       coalesce(unengaged, 0) as unengaged2,
       engaged * 100 / unengaged
           re_date
from (
         select date as stat_date
         from numeric_date
         where date between '2020-10-06' and current_date()
     ) as stat_dates
         left join (
    select date( created_at ) as re_date,
           sum( added ) as added,
           sum( removed ) as removed,
           sum( unsubscribed ) as unsubscribed,
           sum( engaged ) as engaged,
           sum( unengaged ) as unengaged
    from core_reengagementlog
    where dry_run = false
      and created_at > '2020-10-06'
    group by re_date
) as re_stats on re_stats.re_date = stat_dates.stat_date
order by stat_dates.stat_date

# core_reengagementlog,id
# core_reengagementlog,created_at
# core_reengagementlog,updated_at
# core_reengagementlog,dry_run
# core_reengagementlog,engaged
# core_reengagementlog,unengaged
# core_reengagementlog,added
# core_reengagementlog,removed
# core_reengagementlog,unsubscribed

select * from core_reengagementlog where date( created_at ) = "2020-10-06"
# https://act.thedreamcorps.org/admin/reports/dashboardreport/44

