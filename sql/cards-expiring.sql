-- cards going to expire next month
SET @start = DATE_FORMAT(NOW(), '%Y-%m-01') + INTERVAL 1 MONTH;

SELECT CONCAT('/admin/core/user/', cor.user_id, ' ', cor.user_id)                                                  AS 'user ID',
       u.email,
       CONCAT(u.first_name, ' ', u.last_name)                                                                      AS name,
       CONCAT('/admin/orderrecurring/', cor.id, ' ',
              COALESCE(cor.recurring_id, 'None'))                                                                  AS 'recurring profile ID',
       DATE_FORMAT(DATE(MIN(t.created_at)), '%Y-%m-%d')                                                            AS started,
       CONCAT(LEFT(cor.exp_date, 2), '-', RIGHT(cor.exp_date, 2))                                                  AS 'expiration date',
       cor.amount_converted                                                                                        AS 'payment amount',
       COUNT(DISTINCT t.id)                                                                                        AS payments,
       SUM(t.amount_converted)                                                                                     AS 'total paid',
       DATE_FORMAT(DATE(MAX(t.created_at)), '%Y-%m-%d')                                                            AS 'last payment date',
       CAST(IF(cor.status != 'active', cor.status, IF(cor.period = 'months', cor.start + interval ceiling(
                   datediff(current_date() - interval 1 day, cor.start) / 30.4375) month, IF(cor.period = 'weeks',
                                                                                             cor.start +
                                                                                             interval ceiling(datediff(current_date() - interval 1 day, cor.start) / 7) week,
                                                                                             'unknown'))) AS CHAR(50)) as 'next run date'
FROM core_order o
         JOIN core_orderrecurring cor ON o.id = cor.order_id
         JOIN core_transaction t
              ON t.order_id = o.id AND t.type in ('sale', 'credit') AND t.status IN ('completed', '') AND t.success = 1
         JOIN core_user u ON u.id = o.user_id
WHERE o.status = 'completed'
  AND cor.status in ('active', 'past_due')
  AND cor.exp_date = DATE_FORMAT(@start, '%m%y')
GROUP BY 1, cor.id
ORDER BY 4;