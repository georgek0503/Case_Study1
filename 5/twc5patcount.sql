select distinct physician,
	   count(personnumber) as patcount
from twc.data as d
group by physician
order by patcount desc