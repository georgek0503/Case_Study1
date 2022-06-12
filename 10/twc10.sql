with totalcost
	as(
select con.finclass, 
		sum(case 
			when medicareallowable != 0 then medicareallowable*percmca*.01
            when medicareallowable = 0 then revenue*percrevenue*.01
            end) as CostofPat,
		sum(revenue) as totalrev
from twc.data as d
inner join twc.cptinfo as cpt 
	on d.cpt = cpt.serviceitemid
inner join twc.cost as c 
	on c.cpttype = cpt.cpttype
inner join twc.contractinfo as con
	using(cob1)
where con.finclass = 'FFS'
group by con.finclass
)
select 
	   (totalcost.totalrev - totalcost.costofpat) as totprof
from totalcost
where totalcost.finclass = 'FFS'
