select patientgender, 
	case when patientgender = 'M' 
			then (select (sum(revenue)/count(*))
				  from twc.data
				  where patientgender = 'M')
	 	 when patientgender = 'F' 
			then (select (sum(revenue)/count(*))
				  from twc.data
				  where patientgender = 'F') 	
			end as revperpat
from twc.data
group by PatientGender