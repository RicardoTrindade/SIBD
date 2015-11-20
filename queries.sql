SELECT r.value, s.units, r.datetime
FROM Reading as r,Device as d natural join Sensor as s,Connects as c,Wears as w, Patient as p
WHERE r.snum=d.serialnum
AND d.serialnum=c.snum
AND d.description like'%Blood Pressure%' -- read project
AND w.pan=c.pan
AND w.patient=p.number
AND p.name = 'José Portela'
AND d.serialnum=s.snum
AND timestampdiff(month,r.datetime, '2015-11-25')<=6;

SELECT s.value,a.units,s.datetime
FROM Setting as s, Device as d natural join Actuator as a, Connects as c, Wears as w,Patient as p
WHERE s.snum=d.serialnum
and d.serialnum=c.snum
and w.pan=c.pan
and w.patient=p.number
and p.name='José Portela'
and d.serialnum=a.snum; -- query php


select r.value
from Reading as r,Device as d,Connects as c,Wears as w
where r.snum=d.serialnum
and d.serialnum=c.snum
and d.description like'%Blood Pressure%' -- read project
and w.pan=c.pan
and w.patient=13998411
and timestampdiff(month,r.datetime, '2015-11-25')<=6; -- Query for 3a

select m.name
from Municipality as m Lives as l,Patient as p,Connects as c
where c.manuf="Philips"
and l.patient=p.number
and m.nut4code=l.muni;

-- Query para a 4a Readings

Select r.value,s.units, r.datetime
from Patient as p, Wears as w, PAN as pa, Connects as c, Device as d, Sensor as s, Reading as r
where p.name = "José Portela"
and p.number=w.patient
and w.pan=pa.domain
and pa.domain=c.pan
and c.start=w.start
and c.end=w.end
and c.snum=d.serialnum
and d.serialnum=s.snum
and s.snum=r.snum
and c.manuf=d.manufacturer
and d.manufacturer=s.manuf
and s.manuf=r.manuf
and r.datetime>=c.start
and r.datetime<=c.end;


SELECT distinct serialnum,manufacturer,description
	FROM Device as d,Patient as p, Wears as w, Connects as c,PAN as pa
	where p.name="José Portela"
	and d.serialnum=c.snum
	and c.pan=pa.domain
	and w.pan=pa.domain
	and w.patient=p.number
	and d.manufacturer=c.manuf
	and c.start<=current_timestamp
	and c.end>=current_timestamp
	and w.start=c.start
	and w.end=c.end
	;


select c.snum,c.manuf
from Wears as w, PAN as p,Patient as pa, Connects as c
where w.end<current_timestamp
and pa.number=w.patient
and w.pan=p.domain
and pa.number=w.patient
and pa.name='Jorge Martins'
and w.start<=c.start
and w.end>=c.end
and c.pan=w.pan
and w.end>=all (select w.end
from Wears as w,PAN as p, Patient as pa
where w.end<current_timestamp
and pa.number=w.patient
and w.pan=p.domain
and pa.number=w.patient
and pa.name='Jorge Martins');

select pan
from Wears as w, Patient as p
where w.end>current_timestamp
and w.patient=p.number
and p.name='Susana Capucho';	