select lpad(format(count(distinct core_user.id), 0), 12, ' ') as "user_count"
from core_user
where exists(
        select *
        from core_subscription
        where core_subscription.user_id = core_user.id
          and core_subscription.list_id in (11)
    )
  and exists(
        select *
        from core_action
                 join core_page_tags using (page_id)
        where core_action.user_id = core_user.id
          and core_page_tags.tag_id in :Tag_ids_for_Took_Action_On_A_Page_With_Tags
    )

# select count(*) from core_subscription #
# select count(*) from core_subscription where list_id = 11 #  # roughly 1/3
# select * from core_subscription where list_id = 11 limit 5 # id	created_at	updated_at	user_id	list_id

# select distinct tag_id from core_page_tags # 1..610, some gaps
# select * from core_page_tags order by id desc limit 10 # id	page_id	tag_id
# select * from core_tag # 610 rows # id,created_at,updated_at,hidden,order_index,name,times_used

SELECT count(*)
FROM core_order
WHERE status = 'completed'
# SELECT COALESCE(SUM(total_converted), 0)
# FROM core_order
# WHERE status = 'completed'

# list size by tag
select lpad(format(count(distinct core_user.id), 0), 12, ' ') as "user_count"
from core_user
where exists(
        select *
        from core_subscription
        where core_subscription.user_id = core_user.id
          and core_subscription.list_id in (11)
    )
  and exists(
        select *
        from core_action
                 join core_page_tags using (page_id)
        where core_action.user_id = core_user.id
#           and core_page_tags.tag_id in (...)
    )

# select * from core_list where id = 11
# new main list - phase 2 of rebrand
# (should receive DC branded email only, regardless of email content). Exclude from program branded sends.


# select count(distinct core_user.id)
# from core_user
# join core_subscription on core_subscription.user_id = core_user.id
#     where core_subscription.list_id = 11


# select count(distinct core_user.id)
# from core_user
#          join core_subscription on core_subscription.user_id = core_user.id
#          join core_action on core_action.user_id = core_user.id
# where core_subscription.list_id = 11

# select count(distinct core_user.id)
# from core_user
#          join core_subscription on core_subscription.user_id = core_user.id
#          join core_action on core_action.user_id = core_user.id
#          join core_page_tags on  core_page_tags.page_id = core_action.page_id
# where core_subscription.list_id = 11

select core_tag.name, count(distinct core_user.id) as user_count
from core_user
         join core_subscription on core_subscription.user_id = core_user.id
         join core_action on core_action.user_id = core_user.id
         join core_page_tags on core_page_tags.page_id = core_action.page_id
         join core_tag on core_page_tags.tag_id = core_tag.id
where core_subscription.list_id = 11
# and core_tag.name in ('name1', '...')
group by core_tag.name
order by user_count desc

select name
from core_tag
order by name

select COLUMN_NAME
from information_schema.columns
where table_schema = 'ak_dcorps'
order by table_name, ordinal_position