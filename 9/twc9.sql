with t1 as (
	select lob,
		sum(case 
		when medicareallowable != 0 then medicareallowable*percmca*0.01
		when medicareallowable = 0 then revenue*percrevenue*0.01
		end) as costs,
        sum(revenue) as rev,
        count(distinct personnumber) as patcount
	from twc.data as d
    inner join twc.cptinfo as cpt 
		on d.cpt = cpt.serviceitemid
	inner join twc.cost as c
		on d.cpttype = c.cpttype
	inner join twc.contractinfo as con
		on d.contract = con.contract
	group by lob
        )
select lob, 
	   (sum(t1.rev - t1.costs)
       ) as profit,
       ((sum(t1.rev - t1.costs)
       )/patcount) as profperpat
from t1
group by lob
order by profperpat desc

/* 
with t1 as (
	select lob,
		sum(case 
		when medicareallowable != 0 then medicareallowable*percmca*0.01
		when medicareallowable = 0 then revenue*percrevenue*0.01
		end) as costs,
        sum(revenue) as rev
	from twc.data as d
    inner join twc.cptinfo as cpt 
		on d.cpt = cpt. serviceitemid
	inner join twc.cost as c
		on d.cpttype = c.cpttype
	inner join twc.contractinfo as con
		on d.contract = con.contract
	group by lob
        ),
	 t2 as(
	select lob,
    count(distinct personnumber) as patcount
	from twc.data as d
	inner join twc.contractinfo as con
		on d.contract = con.contract
group by lob
		)
select lob, 
	   (sum(t1.rev - t1.costs)
       ) as profit,
       ((sum(t1.rev - t1.costs)
       )/t2.patcount) as profperpat
from t1
inner join t2 using(lob)
group by lob
order by profperpat desc
*/