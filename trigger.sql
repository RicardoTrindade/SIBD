delimiter $$
drop trigger if exists overlap;
create trigger overlap before insert on Connects
for each row
begin

if (new.start<end OR new.start>start) then 

call error_cant_assign();

else 

insert into Connects values (new.start,
                      new.end,
                      new.snum,
                      new.manuf,
                      new.pan);
insert into Wears values (new.start, 
                  new.end,
                  
                  new.pan);
insert into Period values (new.start,
                     new.end);

end if;

end $$

delimiter ;


