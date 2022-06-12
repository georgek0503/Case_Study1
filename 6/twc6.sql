select distinct physician, count(distinct personnumber) as patcount
from twc.data
inner join twc.contractinfo
using(contract)
where lob = 'Medicare'
group by physician
order by patcount desc