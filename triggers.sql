  drop trigger if exists check_connects;
drop trigger if exists check_wears;
 
delimiter $$
create trigger check_connects before insert on Connects
for each row
begin
declare n integer;
select count(*) into n
from Connects as c
where c.snum = new.snum and c.manuf = new.manuf
and ((timestampdiff(hour,new.start,start)>=0 and timestampdiff(hour,new.end,start)<=0)||
(timestampdiff(hour,new.start,start)<=0 and timestampdiff(hour,new.start,end)>=0));
if n>0 || new.start>new.end then
call the_device_is_already_connected_to_a_PAN_in_this_period();
end if;
end$$
delimiter ;
 
delimiter $$
create trigger check_wears before insert on Wears
for each row
begin
declare n integer;
select count(*) into n
from Wears as w
where w.patient = new.patient
and w.pan=new.pan

and ((timestampdiff(hour,new.start,start)>=0 and timestampdiff(hour,new.end,start)<=0)||
(timestampdiff(hour,new.start,start)<=0 and timestampdiff(hour,new.start,end)>=0));
if n>0 || new.start>new.end then
call the_patient_wears_already_a_PAN_in_this_period();
end if;
end$$
delimiter ;