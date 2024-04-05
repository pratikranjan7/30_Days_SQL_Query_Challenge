with
    cte
    as
    
    (
        select *,
            dense_rank() over(partition by pair_id order by brand1) as rank
        from(SELECT *,
                case 
when brand1 < brand2 then CONCAT(brand1,brand2,YEAR)
else CONCAT(brand2,brand1,year)
end as pair_id
            FROM brands)x
    )

select *
from cte
where rank = 1 or (custom1 <> custom3 and custom2 <> custom4)