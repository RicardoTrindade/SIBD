delimiter $$

create function muni( description varchar(255))
returns varchar(255)
begin
declare names varchar(255);

select m.name into names 
from Wears as w, Lives as l, Municipality as m, Connects as c
where l.patient = w.patient
and m.nut4code=l.muni
and w.pan=c.pan
and c.manuf=description
and current_timestamp<=w.end
and current_timestamp>=w.start
and w.start=c.start
and w.end=c.end
group by m.nut4code
having count(l.patient) >= all( select count(l.patient)
from Wears as w, Lives as l, Municipality as m, Connects as c
where l.patient = w.patient
and m.nut4code=l.muni
and w.pan=c.pan
and c.manuf=description
and w.start=c.start
and w.end=c.end
and current_timestamp<=w.end
and current_timestamp>=w.start
group by m.nut4code);

return names;

end$$

delimiter ;


select muni("Philips");