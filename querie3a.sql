select r.value
from Reading as r, Device as d,Connects as c, Wears as w
where r.snum=d.serialnum
and r.manuf=d.manufacturer
and d.serialnum=c.snum
and d.manufacturer=c.manuf
and w.pan=c.pan
and w.patient=14075632
and timestampdiff(month,r.datetime, current_timestamp)<=6
and r.datetime>=c.start
and r.datetime<=c.end
and d.description like'%Blood Pressure%' 
group by r.value;


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