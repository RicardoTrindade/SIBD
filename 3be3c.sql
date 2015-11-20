 
3b

select m.nut4code, m.name as municipality, count(l.patient) as number_of_devices
from Wears as w, Lives as l, Municipality as m, PAN as pa, Connects as c
where l.patient = w.patient
and m.nut4code=l.muni
and w.pan=pa.domain
and pa.domain=c.pan
and c.manuf="Philips"
and w.end >= current_timestamp
and w.start <= current_timestamp
group by m.nut4code
having count(l.patient) >= all( select count(l.patient)
from Wears as w, Lives as l, Municipality as m, PAN as pa, Connects as c
where l.patient = w.patient
and m.nut4code=l.muni
and w.pan=pa.domain
and pa.domain=c.pan
and c.manuf="Philips"
and w.end >= current_timestamp
and w.start <= current_timestamp
group by m.nut4code);







3c


 select d.manufacturer as Manufacturer, count(m.nut4code) as Number_of_Scales, GROUP_CONCAT(m.name) as Municipalities 
 from Device as d, Connects as c, PAN as p, Wears as w, Lives as l,Municipality as m, Patient as pa
  where d.description='Scale'  
  and c.pan=p.domain 
  and d.serialnum=c.snum 
  and w.pan=p.domain 
  and w.patient=l.patient 
  and l.muni=m.nut4code 
  and w.patient=pa.number
  and w.start<=c.start
  and w.end>=c.end
  and timestampdiff(YEAR, c.end,current_timestamp)<=1 
  group by d.manufacturer
  having count(m.nut4code)>=(select count(m.nut4code)from Municipality as m);
