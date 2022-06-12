with t1 as 
	(select distinct patienttype,
	   sum(revenue) as totrev,
       count(encounternumber) as numenc
	from twc.data 
	group by patienttype)

select distinct patienttype,
	   (totrev/numenc) as revperenc
from t1
group by patienttype
order by revperenc desc
		