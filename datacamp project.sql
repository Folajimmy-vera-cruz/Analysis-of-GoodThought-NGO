with cte as(
select assignment_id, count(donation_id) as num_total_donations
from donation
group by assignment_id
),

cte2 as(
select a.assignment_name, a.assignment_id, a.region, a.impact_score, cte.num_total_donations,
row_number() over(partition by a.region order by a.impact_score desc) as row_part
from assignment as a
inner join cte 
on a.assignment_id = cte.assignment_id
where cte.num_total_donations > 0
)

SELECT
    assignment_name, region, impact_score, num_total_donations
FROM cte2
WHERE row_part = 1
ORDER BY region asc;
