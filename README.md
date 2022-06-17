# Case_Study1
## A Case Study on Healthcare Datasets

**This independent case study was conducted to demonstrate applied knowledge of PostgreSQL.**

### Workflow:

**1.** 4 datasets containing fictional health insurance information were injected from Kaggle into MySQL Workbench as csv files within an independent schema. 

**2.** Deep dive analyses investigating self-proposed inquiries such as *"what was the most profitable health insurance contract type on a profit per patient basis?"* were performed to understand various trends and outliers within the dataset. 

**Example Datset:**

| Code Desc  | Cpt Type | Service Item ID | Medicare Allowable |
| ------------- | ------------- | ------------- | ------------- |
| Description of service provided  | Identifier of medical services/procedures performed by healthcare professionals | Unique CPT code relating to service provided | Payment considered in full by insurance company  |


All 4 tables maintained similar structures and several conditions were identified within each table to allow use of joins to implement various functions. Take the following question as an example: *"what was the most profitable health insurance contract type on a profit per patient basis?"* After 3 inner joins were performed, the costs undertaken by an insurance company was calculated with a case statement that determined whether the Medicare allowable cost was null or not and then multiplied this value by either the percent medicare allowable or percent revenue.

**Example Code:**
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

**3.** The query was then run in MySQL Workbench the obtain the results of the given question. The results grid from the above query is as follows:
| lob | profit | profperpat |
| --- | --- | --- |
| Medicare | 3813270.029506771 | 49522.98739619183 |
| Medicaid | 111083.61983158934 | 7934.544273684953 |
| Commercial | 324338.79094897746 | 7722.3521654518445 |

According to the resulting data, we can conclude that Medicare is the most profitable health insurance company on a profit per patient basis by several margins. 

