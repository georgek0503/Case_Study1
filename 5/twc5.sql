with t1 as (
	select physician,
		sum(case 
		when medicareallowable != 0 then medicareallowable*percmca*0.01
		when medicareallowable = 0 then revenue*percrevenue*0.01
		end) as costs,
        sum(revenue) as rev,
        count(personnumber) as patcount
	from twc.data as d
    inner join twc.cptinfo as cpt 
		on d.cpt = cpt. serviceitemid
	inner join twc.cost as c
		on d.cpttype = c.cpttype
	group by physician
        )
select physician, 
	   (sum(t1.rev - t1.costs)
       ) as profit,
       ((sum(t1.rev - t1.costs)
       )/patcount) as profperpat
from t1
group by physician
order by profperpat desc