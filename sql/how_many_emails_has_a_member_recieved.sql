SELECT core_user.email, core_user.id, core_usermailing.id, count(*) AS c
FROM core_user
         JOIN core_usermailing ON core_user.id = core_usermailing.user_id
GROUP BY core_user.id
ORDER BY c DESC
-- LIMIT 10