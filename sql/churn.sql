# select * from core_unsubscribeaction order by if
# churn = beginning / (beginning + new - subsub) https://www.google.com/imgres?imgurl=https://phiture.com/wp-content/uploads/2017/12/churn-formula-min.png&imgrefurl=https://phiture.com/mobilegrowthstack/a-simple-guide-to-retaining-valuable-users-50d9e6aed37c/&tbnid=oCcgbnBRBfH06M&vet=1&docid=KqtYBOWUEF6GZM&w=1200&h=768&source=sh/x/im
# 2 / (100 + 5)
# 100 on oct 1
# 2 leave
# 5 join

# (2 x 100) / (100 + 5) = 1.9% churn


select concat(year(created_at), '-', lpad(month(created_at), 2, '0')) as ym,
       count(distinct user_id)                                        as c
from core_subscriptionhistory
where change_id in (4, 5, 6, 8, 10, 12, 14, 15)
group by ym
order by ym
    desc


select count(distinct user_id)
from core_subscriptionhistory
where change_id in (4, 5, 6, 8, 10, 12, 14, 15)
  and created_at > '2020-01-01'
  and created_at < '2020-02-01' # 2041

select *
from core_subscriptionchangetype
where id in (4, 5, 6, 8, 10, 12, 14, 15)


select *
from core_unsubscribeaction
limit 10

select *
from core_subscriptionhistory


select count(distinct (user_id))
from core_subscription
# 137337
# 283 unsub this month

select count(distinct (user_id))
from core_subscription

select concat(year(core_mailing.started_at), '-', lpad(month(core_mailing.started_at), 2, '0')) as year_month_a,
       lpad(format(sum((select count(distinct core_action.user_id)
                        from core_unsubscribeaction
                                 join core_action on (core_unsubscribeaction.action_ptr_id = core_action.id)
                                 join core_subscriptionhistory on (core_action.id = core_subscriptionhistory.action_id)
                        where core_action.mailing_id = core_mailing.id)), 0), 12, ' ')          as "unsubs"
from core_mailing
where core_mailing.status = 'completed'
  and not (notes like '%staff%')
  and not (exists(select *
                  from core_mailing_tags
                  where core_mailing_tags.mailing_id = core_mailing.id
                    and core_mailing_tags.tag_id in (338)))
  and core_mailing.started_at between timestamp(concat(2020, '-01-01')) and timestamp(concat(2020, '-12-31'), '23:59:59')
group by year_month_a
order by year_month_a DESC

# select * from core_tag where id  = 338 # @staffsend

# 2020-09,          50,"     265,725","      98,313",   37.0%,"       3,956",    1.5%,"       2,134",    0.8%,"       1,142",    0.4%,          32,        $68.10
# select distinct(notes) from core_mailing limit 10
# September 2020  	136930	605	1217.00	0.8%	0.1%		1.9


# churn would deal primarily with members that unsubscribe monthly.  You could also do a monthly churn rate for those who cancel their recurring donations or whose card payments go invalid.

select core_action.user_id                                             as "user_id",
       (select core_actionfield.value
        from core_actionfield
        where core_actionfield.parent_id = core_action.id
          and core_actionfield.name = 'survey')                        as "custom_field_survey",
       (select group_concat(text order by id separator ', ')
        from core_mailingsubject
        where core_mailingsubject.mailing_id = core_action.mailing_id) as "mailing_id_subjects_id",
       core_action.created_at as ca
from core_action
         left join core_user on core_user.id = core_action.user_id
where core_action.page_id in (5)
  and exists(select *
             from core_actionfield
             where core_actionfield.parent_id = core_action.id
               and core_actionfield.name = 'survey'
               and length(core_actionfield.value) > 0)
group by core_action.id
order by ca desc