# Case_Study1
## A Case Study on Healthcare Datasets

**This independent case study was conducted to demonstrate applied knowledge of PostgreSQL.**

### Workflow:

4 datasets coontaining fictional health insurance information were injected from Kaggle into MySQL Workbench as csv files within an independent schema. 
Deep dive analyses investigating self-proposed inquiries such as *"what was the most profitable health insurance contract type on a profit per patient basis?"* were performed to understand various trends and outliers within the dataset. 


```
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
```

