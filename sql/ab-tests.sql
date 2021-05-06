select title                    as ab_test_title,
       core_mailingtestgroup.id as ab_test_id,
       core_mailing.id          as mailing_id,
       notes                    as mailing_notes
from core_mailing
         join core_mailingtestgroup on core_mailing.test_group_id = core_mailingtestgroup.id
where test_group_id in (
    select distinct id
    from core_mailingtestgroup
    where id in (
        select test_group_id
        from core_mailing
        where core_mailing.id in (
            select mailing_id
            from (select mailing_id, count(*) as c
                  from core_mailing_tags
                  where tag_id in (select id from core_tag where name in ("%long", "%ab", "%lengthtest"))
                  group by mailing_id) as tag_counts_per_mailing
            where tag_counts_per_mailing.c = 3
        )
        order by core_mailing.id, core_mailingtestgroup.title
    )
)
