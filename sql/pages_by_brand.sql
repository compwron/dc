
select core_page.id, core_tag.name
from core_tag
         join core_page_tags on core_tag.id = core_page_tags.tag_id
         join core_page on core_page_tags.page_id = core_page.id
where core_page.type not in ('import', 'unsubscribe')
#   and (
#         core_tag.name like '%cut50%' or
#         core_tag.name like '%green%' or
#         core_tag.name like '%dream%' or
#         core_tag.name like '%tech%'
#     )
group by core_page.id, core_tag.name
order by core_page.id asc;

select core_page.id, core_tag.name
from core_tag
         join core_page_tags on core_tag.id = core_page_tags.tag_id
         join core_page on core_page_tags.page_id = core_page.id
where core_page.type not in ('import', 'unsubscribe')
  and core_tag.name not like '&%'
  and core_tag.name not like '-%'
  and core_tag.name not like '*%'
  and core_tag.name not like '#%'
  and core_tag.name not like '!%'
  and core_tag.name not like '\_%'
group by core_page.id, core_tag.name
order by core_page.id asc;