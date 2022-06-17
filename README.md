# Case_Study1
A Case Study on Healthcare Datasets




'''
select patienttype, sum(revenue)
from twc.data as d
where chargedos like '%19'
  and location like '%10'
group by PatientType
order by sum(revenue) desc
;
'''
