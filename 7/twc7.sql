select avg(PatientAge) as avg_age
from twc.data 
where PatientGender = 'F'
	and chargeDOS like '%19' 
    and cpttype like 'Glaucoma%'