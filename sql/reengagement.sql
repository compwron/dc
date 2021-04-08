select *
from core_subscriptionhistory
limit 10
#, and change_id=15
# select * from core_subscriptionchangetype # 15,2017-08-01 16:44:52,2017-08-01 16:44:52,subscribe_migratedonreengagement,Put on re-engagement list.,1

select *
from core_subscriptionhistory
where change_id = 15
order by id desc
limit 100