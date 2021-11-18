-- Steps to follow: 
-- Format date to YYYY-MM
-- Format date using to_char
-- Calculate the total number of buyers retained of the current month or (day's value)
-- Calculate the last months retention number(or the last records total retention)


SELECT to_char(new_subscriber_cohort, 'YYYY-Mon') AS year_month,
(sum(num_buyers_retained) - lag(sum(num_buyers_retained),1) OVER (w)) as ret_diff,
lag(sum(num_buyers_retained),1) OVER (w) as prev_month_ret,
round((sum(num_buyers_retained) - lag(sum(num_buyers_retained),1) OVER (w))/ lag(sum(num_buyers_retained),1) OVER (w) *100,2) as Month_diff
FROM retention
GROUP BY year_month
WINDOW w as (ORDER BY to_char(new_subscriber_cohort, 'YYYY-Mon'))
ORDER BY year_month ASC;
