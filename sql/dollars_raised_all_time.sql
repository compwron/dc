SELECT COALESCE(SUM(total_converted), 0)
FROM core_order
WHERE status = 'completed'
{% if partial_run %}
AND created_at BETWEEN {last_run} AND {now}
{% endif %}
;