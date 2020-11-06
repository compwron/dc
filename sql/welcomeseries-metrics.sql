# Query all @welcomeseries emails to show ID,Send Count, OR,CR,AR and USR

select mailing_id, expected_send_count, count( distinct user_id), count( distinct user_id) / expected_send_count
from (
         select core_mailing.id as mailing_id,
                expected_send_count,
                core_open.user_id
         from core_mailing
                  join core_open on core_open.mailing_id = core_mailing.id
         where core_mailing.id = 14512
     ) as mailing_opens;



select core_mailing.id, core_tag.name
from core_mailing
         join core_mailing_tags on core_mailing.id = core_mailing_tags.mailing_id
         join core_tag on core_mailing_tags.tag_id = core_tag.id
where core_tag.name in ('@welcomeseries', '@ws1', '@ws2', '@ws3');




select mailing_id,
       expected_send_count,
       count( distinct user_id),
       count( distinct user_id) / expected_send_count
from (
         select core_mailing.id as mailing_id,
                expected_send_count,
                core_open.user_id
         from core_mailing

                  join core_open on core_open.mailing_id = core_mailing.id
         where core_mailing.id = 14433
     ) as mailing_opens
# 14431,17,8,0.14433
# 14433,5,0,0.0000



# core_bounce

describe core_unsubscribeaction # action_ptr_id

    describe core_action

select * from core_action where referring_mailing_id = 14432