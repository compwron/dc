select avg(open_rate_per_person.avg_opens_per_mailer) as regular,
       avg(open_rate_per_person.avg_opens_per_mailer_floor) as avg_floor,
       avg(open_rate_per_person.avg_opens_per_mailer_ceiling) as avg_ceiling,
       avg(open_rate_per_person.avg_opens_per_mailer_round) as avg_round
from (
         select open_counts_per_person.user_id,
                open_counts_per_person.mailer_count_per_person,
                open_counts_per_person.open_count,
                floor(open_counts_per_person.open_count /
                      open_counts_per_person.mailer_count_per_person)   as avg_opens_per_mailer_floor,
                ceiling(open_counts_per_person.open_count /
                        open_counts_per_person.mailer_count_per_person) as avg_opens_per_mailer_ceiling,
                round(open_counts_per_person.open_count /
                      open_counts_per_person.mailer_count_per_person)   as avg_opens_per_mailer_round,
                open_counts_per_person.open_count /
                open_counts_per_person.mailer_count_per_person          as avg_opens_per_mailer
         from (
                  select mail_counts_per_person.user_id,
                         mail_counts_per_person.c as mailer_count_per_person,
                         (
                             select count(*)
                             from core_open
                             where core_open.user_id = mail_counts_per_person.user_id
                         )                        as open_count
                  from (
                           select user_id, count(*) as c
                           from core_usermailing
                           where core_usermailing.created_at >= '2020-01-01'
#                            where core_usermailing.mailing_id = 13891 # 32.15463918 vs 38 actionkit
#                            where core_usermailing.mailing_id = 13960 # 22.90975065 vs 30.59 actionkit
#                            where core_usermailing.mailing_id = 13961 # 26.5217 vs 26.09 actionkit
                           group by user_id
                           order by c desc
                       ) as mail_counts_per_person
              ) as open_counts_per_person
     ) open_rate_per_person
# regular, avg_floor, avg_ceiling, avg_round
# 0.34964719,0.1362,0.8328,0.2905

# select ceiling(1.2),
#        ceiling(1.9),
#        floor(1.2),
#        floor(1.9),
#        round(1.2),
#        round(1.9),
#        round(1.499999999999999999)
# from core_user
# limit 1


# select email from core_user where id = 38894

# 40919,99,136
# 23,92,141
# 50,87,126
# 35,82,93
# 630321,78,75
# 3936,77,79
# 45,76,84
# 953,76,120
# select * from core_open where user_id = 40919

# select count(*) from (
# select user_id, count(*) as c
# from core_usermailing
# #                            where core_usermailing.created_at >= '2020-01-01'
# #                            where core_usermailing.mailing_id = 13891 # 32.15463918 vs 38 actionkit
# where core_usermailing.mailing_id = 13960 # 22.90975065 vs 30.59 actionkit
# group by user_id
# order by c desc) as foo # 5374