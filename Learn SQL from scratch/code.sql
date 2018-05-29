SELECT COUNT (DISTINCT utm_campaign)
from page_visits;

SELECT COUNT (DISTINCT utm_source)
from page_visits;

SELECT distinct utm_campaign, utm_source
FROM page_visits
order by utm_source;

SELECT distinct page_name
FROM page_visits;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
    count(ft.first_touch_at) as 'First Touch Count',
    pv.utm_source,
        pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp    
    group by utm_campaign
    order by 1 desc;


WITH last_touch AS (
    SELECT user_id,
        max(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
    count(lt.last_touch_at) as 'Last Touch Count',
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp    
    group by utm_campaign
    order by 1 desc;

select count(page_name)
from page_visits
where page_name = '4 - purchase';

WITH last_touch AS (
    SELECT user_id,
        max(timestamp) as last_touch_at
    FROM page_visits
  WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT 
    count(lt.last_touch_at) as 'Last Touch Count',
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp    
    group by utm_campaign
    order by 1 desc;