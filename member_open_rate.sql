SELECT core_user.email, core_user.id, core_usermailing.id, count(*) AS c
FROM core_user
         JOIN core_usermailing ON core_user.id = core_usermailing.user_id
         left outer JOIN core_open
                         ON (core_user.id = core_open.user_id AND core_usermailing.mailing_id = core_open.mailing_id)
GROUP BY core_user.id, core_open.user_id
ORDER BY c DESC
LIMIT 10