select core_mailing.id, core_mailing.created_at, count(distinct user_id)
from core_mailing_tags
         join core_mailing on core_mailing.id = core_mailing_tags.mailing_id
         join core_tag on core_mailing_tags.tag_id = core_tag.id
         join core_usermailing on core_usermailing.mailing_id = core_mailing.id
where name = "@reengagement"
group by core_mailing.id
order by core_mailing.created_at asc
