select distinct core_page.id
from core_page
         left join core_pagefield on core_page.id = core_pagefield.parent_id
where core_page.type = 'Import'
  and core_page.name not like '%test%'
  and core_page.title not like '%test%'
  and core_page.name not like '%sample%'
  and core_page.title not like '%sample%'
  and (core_pagefield.name is NULL or core_pagefield.name not like '%test%')
  and (core_pagefield.name is NULL or core_pagefield.name not like '%sample%')
  and (core_pagefield.value is NULL or core_pagefield.name not like '%test%')
  and (core_pagefield.value is NULL or core_pagefield.name not like '%sample%')
order by core_page.id


select distinct core_page.id, core_page.name
from core_page
         left join core_pagefield on core_page.id = core_pagefield.parent_id
where core_page.type = 'Import'
  and (
        core_page.name like '%test%'
        or core_page.title like '%test%'
        or core_page.name like '%sample%'
        or core_page.title like '%sample%'
        or core_pagefield.name like '%test%'
        or core_pagefield.name like '%sample%'
        or core_pagefield.value like '%test%'
        or core_pagefield.value like '%sample%'
    )
order by core_page.id

