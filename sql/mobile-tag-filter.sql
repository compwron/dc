# improving on https://act.thedreamcorps.org/report/re_engaged_list_members_mobile_phone_numbers

select core_user.id         as "user_id",
       core_user.state      as state, -- NEW
       core_user.first_name as "first_name",
       core_user.email      as "user_email",
       (
           select coalesce(group_concat(phone order by core_phone.id desc separator ', '), '')
           from core_phone
           where core_phone.user_id = core_user.id
             and core_phone.type = 'mobile'
       )                    as "phone_numbers_mobile",
       (
           select GROUP_CONCAT(distinct name)
           from core_tag
                    join core_page_tags on core_tag.id = core_page_tags.tag_id
                    join core_action on core_page_tags.page_id = core_action.page_id
           where core_action.user_id = core_user.id
             and name in ('dreamcorps', 'JUSTICE', 'DreamCorpsTECH', 'Greenforall', 'Empathy Network', 'LoveArmy')
       )                    as tags,
       (
           select core_tag.name
           from core_action
                    join core_page on core_action.page_id = core_page.id
                    join core_page_tags on core_page_tags.page_id = core_page.id
                    join core_tag on core_page_tags.tag_id = core_tag.id
           where core_action.user_id = core_user.id
             and core_tag.name in
                 ('dreamcorps', 'JUSTICE', 'DreamCorpsTECH', 'Greenforall', 'Empathy Network', 'LoveArmy')
           order by core_action.created_at desc
           limit 1
       )                    as "most_recent_action_tag"

from core_user
where exists(
        select *
        from core_subscription
        where core_subscription.user_id = core_user.id
          and core_subscription.list_id in (2)
    )
  and core_user.id in
      (
          select core_phone.user_id from core_phone where core_phone.type = 'mobile' and length(core_phone.phone) > 0
      )
group by core_user.id
