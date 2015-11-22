drop table if exists Wears;
drop table if exists Lives;
drop table if exists Connects;
drop table if exists Reading;
drop table if exists Setting;
drop table if exists Sensor;
drop table if exists Actuator;
drop table if exists Patient;
drop table if exists PAN;
drop table if exists Device;
drop table if exists Municipality;
drop table if exists Period;

  create table Patient (
	  number integer,
	  name varchar(255),
	  address varchar(255),
	  primary key(number));
  
  
  create table PAN (
	  domain varchar(255),
	  phone varchar(255),
	  primary key(domain));
	  
	  
  create table Device (
	 serialnum varchar(255), --   podem ser numeros e letras
	 manufacturer varchar(255),
	 description varchar(255),
	 primary key (serialnum,manufacturer));
	 
  create table Sensor (
	 snum varchar(255),
	 manuf varchar(255),
	 units varchar(255),
	 primary key(snum,manuf),
	 foreign key(snum,manuf) references Device(serialnum,manufacturer));
	 
  create table Actuator (
	 snum varchar(255),
	 manuf varchar(255),
	 units varchar(255),
	 primary key(snum,manuf),
	 foreign key(snum,manuf) references Device(serialnum,manufacturer)); 
	 
  create table Municipality (
	 nut4code char(5), --  ver
	 name varchar(255),
	 primary key (nut4code));
	 
  create table Period ( 
	 start timestamp, --  pode ser data numeros letras etc
	 end timestamp,
	 primary key(start, end));
	 
  create table Reading ( 
	 snum varchar(255),
	 manuf varchar(255),
	 datetime timestamp, --  será timestamp ou varchar?,
	 value double, --  ou float
	 primary key (snum,manuf,datetime),
	 foreign key (snum,manuf) references Sensor(snum,manuf)); --  mais uma vez pode ter de ser alterado
	 
	 
  create table Setting (
	 snum varchar(255),
	 manuf varchar(255),
	 datetime timestamp, -- será timestamp ou varchar?,
	 value double, -- ou float
	 primary key (snum,manuf,datetime),
	 foreign key (snum,manuf) references Actuator(snum,manuf)); --  mais uma vez pode ter de ser alterado
	 
  create table Wears (
	  start timestamp,
	  end timestamp,
	  patient integer,
	  pan varchar(255),
	  primary key (start,end,patient),
	  foreign key (patient) references Patient(number), --  ou Patient(patient)??
	  foreign key (start,end) references Period(start,end),
	  foreign key (pan) references PAN(domain) --  ou PAN??
	  );
	  
  create table Lives (
	  start timestamp,
	  end timestamp,
	  patient integer,
	  muni char(5),
	  primary key (start,end,patient),
	  foreign key (muni) references Municipality(nut4code),
	  foreign key (start,end) references Period(start,end),
	  foreign key (patient) references Patient(number) -- duvidas
	  );
	  
  create table Connects (
	  start timestamp,
	  end timestamp,
	  snum varchar(255),
	  manuf varchar(255),
	  pan varchar(255),
	  primary key (start,end,snum,manuf),
	  foreign key (start,end) references Period(start,end),
	  foreign key (snum,manuf) references Device(serialnum,manufacturer), --  duvida aqui..
	  foreign key (pan) references PAN(domain)); --  e neste tambem


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

insert into Patient values (14075632,'Ricardo Trindade','Rua Professor Alfredo Reis');
insert into Patient values (14200440,'Joana Faria','Rua das Maravilhas');
insert into Patient values (14138466,'Beatriz Almeida','Praça Duque de Cadaval');
insert into Patient values (13998411,'José Portela','Rua Professor Aires de Sousa');
insert into Patient values (14592044,'Mariana Sequeira','Campo');
insert into Patient values (13548484,'Susana Capucho','Rua Catarina Eufémia');
insert into Patient values (14291817,'Jorge Martins','Rua Casimiro Freire');
insert into Patient values (12345678,'Jorge Martins','Rua Duplicada');	

insert into PAN values ('pan001.healthunit.org',918239456);
insert into PAN values ('pan002.healthunit.org',926096827);
insert into PAN values ('pan003.healthunit.org',968166584); -- pan do zé
insert into PAN values ('pan004.healthunit.org',968873789);
insert into PAN values ('pan005.healthunit.org',916267734);
insert into PAN values ('pan006.healthunit.org',917687839);	
insert into PAN values ('pan007.healthunit.org',910000000);
insert into PAN values ('pan008.healthunit.org',911111111);
insert into PAN values ('pan009.healthunit.org',912222222);	

insert into Device values ('S-100001','Samsung','Blood Pressure Meter');
insert into Device values ('S-000001','Philips','Blood Pressure Meter');
insert into Device values ('S-58956','Siemens','Scale');	-- importante para 3c
insert into Device values ('A-26548','Philips','Rotating Pump');
insert into Device values ('A-6888558','Samsung','Insulin Pump');
insert into Device values ('S-100001','Siemens','Glucose Meter');
insert into Device values ('S-784486','Siemens','Heart Rate Monitor');
insert into Device values ('S-85775','Philips','Heart Rate Monitor');
insert into Device values ('S-12387','Philips', 'Scale'); -- importante para 3c
insert into Device values ('A-75254','Philips','Rotating Pump');	
insert into Device values ('S-99999','Siemens','Scale');
insert into Device values ('S-201201','Samsung','Blood Pressure Meter');
insert into Device values ('A-201201','Samsung','Rotating Pump');
insert into Device values ('S-201202','Siemens','Heart Rate Monitor');	


insert into Sensor values ('S-100001','Samsung','mmHg');
insert into Sensor values ('S-000001','Philips','mmHg');
insert into Sensor values ('S-58956','Siemens','Kg'); -- importante para 3c
insert into Sensor values ('S-100001','Siemens','mg/dL');
insert into Sensor values ('S-784486','Siemens','BPM');
insert into Sensor values ('S-85775','Philips','BPM');
insert into Sensor values ('S-12387','Philips','Kg');	-- importante para 3c
insert into Sensor values ('S-99999','Siemens','Kg');
insert into Sensor values ('S-201201','Samsung','mmHg');
insert into Sensor values ('S-201202','Siemens','BPM');	

insert into Actuator values ('A-26548','Philips','RPM');
insert into Actuator values ('A-6888558','Samsung','mmol/L');
insert into Actuator values ('A-75254','Philips','RPM');
insert into Actuator values ('A-201201','Samsung','RPM');	

insert into Municipality values ('10001','Lisboa'); -- importante para 3c
insert into Municipality values ('20001','Madeira'); -- importante para 3c
insert into Municipality values ('30001','Loures'); -- importante para 3c
insert into Municipality values ('40001','Évora'); -- importante para 3c

insert into Period values ('2015-08-15 15:55:00','2015-10-12 18:26:01');
insert into Period values ('1993-07-17 12:50:00','2017-09-26 09:00:00');
insert into Period values ('2015-09-01 14:00:00','2015-12-25 00:00:00');
insert into Period values ('1993-09-19 08:30:50','2017-09-15 12:30:00');
insert into Period values ('2015-04-01 08:00:00','2015-11-25 08:00:00');
insert into Period values ('2015-05-01 10:00:00','2015-12-11 12:00:00');	
insert into Period values ('1999-09-10 11:00:00','2016-05-22 12:00:00');
insert into Period values ('2015-05-20 12:00:00','2015-12-01 14:00:00');
insert into Period values ('1995-05-14 18:00:00','2016-04-21 12:00:00');
insert into Period values ('2004-02-10 14:00:00','2016-01-15 15:00:00');
insert into Period values ('2015-01-20 14:00:00','2015-11-30 15:00:00');
insert into Period values ('2014-05-10 08:00:00','2014-09-20 08:00:00');
insert into Period values ('2014-02-10 08:00:00','2014-12-28 08:00:00');
insert into Period values ('2014-02-08 10:00:00','2014-05-20 10:00:00');
insert into Period values ('2014-11-10 17:00:00','2014-12-15 18:00:00');
insert into Period values ('2015-01-05 15:30:00','2015-03-10 10:00:00');
insert into Period values ('2005-05-12 10:00:00','2016-05-15 19:30:00');
insert into Period values ('2013-04-01 08:00:00','2013-09-25 08:00:00');
insert into Period values ('2015-01-21 14:00:00','2015-11-29 15:00:00');
insert into Period values ('2013-04-01 09:00:00','2013-09-25 08:00:00');
insert into Period values ('2014-02-08 11:00:00','2014-05-20 10:00:00');	
insert into Period values ('2015-01-05 16:30:00','2015-03-10 10:00:00');
insert into Period values ('2015-04-01 09:00:00','2015-11-25 08:00:00');
insert into Period values ('2015-05-20 13:00:00','2015-12-01 14:00:00');	
insert into Period values ('2015-09-01 15:00:00','2015-12-25 00:00:00');
insert into Period values ('2014-05-10 09:00:00','2014-09-20 08:00:00');
insert into Period values ('2015-05-10 09:00:00','2015-09-20 08:00:00');
insert into Period values ('2015-05-10 08:00:00','2015-09-20 08:00:00');	
insert into Period values ('2014-02-09 08:00:00','2015-12-01 08:00:00');
insert into Period values ('2014-11-09 17:00:00','2015-12-12 12:00:00');
insert into Period values ('2015-05-20 14:00:00', '2015-12-01 14:00:00');
insert into Period values ('2014-11-09 17:00:00','2015-12-12 18:00:00');


insert into Period values ('2007-01-10 08:00:00','2007-07-25 08:00:00'); -- periods for 4b
insert into Period values ('2007-01-10 09:00:00','2007-02-25 08:00:00'); -- sensor1 period
insert into Period values ('2007-02-26 09:00:00','2007-03-25 08:00:00'); -- sensor 2 period
insert into Period values ('2007-03-25 09:00:00','2007-07-20 08:00:00'); -- actuator period	
insert into Period values ('1993-01-12 04:00:00','2020-01-06 03:30:00');
insert into Period values ('2015-03-17 02:00:00','2016-01-20 04:00:00');	

insert into Reading values ('S-12387','Philips','2015-10-17 07:30:00', 130);
insert into Reading values ('S-12387','Philips','2015-11-29 07:30:00',  90);
insert into Reading values ('S-58956','Siemens','2015-01-06 07:30:00', 180);
insert into Reading values ('S-100001','Siemens','2015-06-21 08:00:00',70);
insert into Reading values ('S-100001','Siemens','2015-06-21 14:00:00',250);
-- readings do zé
insert into Reading values ('S-100001','Samsung','2015-05-25 08:00:00',8);
insert into Reading values ('S-100001', 'Samsung' ,'2015-05-26 08:00:00', 9);
insert into Reading values ('S-100001', 'Samsung' ,'2015-06-14 08:00:00',9.2);
insert into Reading values ('S-100001','Samsung' ,'2015-04-20 08:00:00', 10);
insert into Reading values ('S-000001','Philips','2015-11-16 11:58:00', 7); 
insert into Reading values ('S-000001','Philips','2015-11-17 11:58:00', 12);
-- 
-- devia acrescentar readings para as scales

insert into Setting values ('A-26548','Philips','2013-05-03 09:40:00',2500);
insert into Setting values ('A-6888558','Samsung','2015-06-21 14:01:00',15);
insert into Setting values ('A-6888558','Samsung','2015-06-21 14:05:00',6);	


insert into Wears values ('2015-05-10 08:00:00','2015-09-20 08:00:00',13548484,'pan001.healthunit.org'); -- importante para 3c
insert into Wears values ('2015-09-01 14:00:00','2015-12-25 00:00:00',14075632,'pan002.healthunit.org'); -- importante para 3b
insert into Wears values ('2013-04-01 08:00:00','2013-09-25 08:00:00',13998411,'pan003.healthunit.org'); -- 
insert into Wears values ('2014-02-08 10:00:00','2014-05-20 10:00:00',13998411,'pan003.healthunit.org'); -- importante para 3c
insert into Wears values ('2015-01-05 15:30:00','2015-03-10 10:00:00',13998411,'pan003.healthunit.org'); -- importante para 3c
insert into Wears values ('2015-04-01 08:00:00','2015-11-25 08:00:00',13998411,'pan003.healthunit.org'); -- pan do zé
insert into Wears values ('2014-11-09 17:00:00','2015-12-12 18:00:00',14138466,'pan004.healthunit.org'); -- importante para 3c
insert into Wears values ('2015-05-20 12:00:00','2015-12-01 14:00:00',14592044,'pan005.healthunit.org'); -- importante para 3b
insert into Wears values ('2014-02-09 08:00:00','2015-12-01 08:00:00',14200440,'pan006.healthunit.org'); -- importante para 3c
insert into Wears values ('2007-01-10 08:00:00','2007-07-25 08:00:00',14291817,'pan007.healthunit.org');
insert into Wears values ('2015-03-17 02:00:00','2016-01-20 04:00:00',14291817,'pan008.healthunit.org');

insert into Lives values ('1993-09-19 08:30:50','2017-09-15 12:30:00',14200440,'20001'); -- importante para 3b
insert into Lives values ('1993-07-17 12:50:00','2017-09-26 09:00:00',14075632,'40001'); -- importante para 3b
insert into Lives values ('1999-09-10 11:00:00','2016-05-22 12:00:00',14138466,'30001'); -- importante para 3b
insert into Lives values ('1995-05-14 18:00:00','2016-04-21 12:00:00',14592044,'40001'); -- importante para 3b
insert into Lives values ('2004-02-10 14:00:00','2016-01-15 15:00:00',13998411,'10001'); -- importante para 3c
insert into Lives values ('2005-05-12 10:00:00','2016-05-15 19:30:00',13548484,'40001'); -- importante para 3c
insert into Lives values ('1993-01-12 04:00:00','2020-01-06 03:30:00',14291817,'40001');	

insert into Connects values ('2015-05-10 09:00:00','2015-09-20 08:00:00','S-99999','Siemens','pan001.healthunit.org'); -- importante para 3c
insert into Connects values ('2015-09-01 15:00:00','2015-12-25 00:00:00','S-000001','Philips','pan002.healthunit.org');	-- importante para 3b
insert into Connects values ('2013-04-01 09:00:00','2013-09-25 08:00:00','A-26548','Philips','pan003.healthunit.org'); -- pan do zé*/
insert into Connects values ('2014-02-08 11:00:00','2014-05-20 10:00:00','S-12387','Philips','pan003.healthunit.org'); -- importante para 3c
insert into Connects values ('2015-01-05 16:30:00','2015-03-10 10:00:00','S-58956','Siemens','pan003.healthunit.org'); -- importante para 3c
insert into Connects values ('2015-04-01 09:00:00','2015-11-25 08:00:00','S-100001','Samsung','pan003.healthunit.org'); -- pan do zé
insert into Connects values ('2014-11-10 17:00:00','2014-12-15 18:00:00','S-99999','Siemens','pan004.healthunit.org'); -- importante para 3c
insert into Connects values ('2015-05-01 10:00:00','2015-12-11 12:00:00','S-85775','Philips','pan004.healthunit.org');	-- importante para 3b
insert into Connects values ('2015-05-20 13:00:00','2015-12-01 14:00:00','S-12387','Philips','pan005.healthunit.org');	-- importante para 3b
insert into Connects values ('2015-05-20 14:00:00', '2015-12-01 14:00:00','A-6888558','Samsung','pan005.healthunit.org');
insert into Connects values ('2014-02-10 08:00:00','2014-12-28 08:00:00','S-58956','Siemens','pan006.healthunit.org'); -- importante para 3c
insert into Connects values ('2015-01-20 14:00:00','2015-11-30 15:00:00','S-100001','Siemens','pan006.healthunit.org');  -- importante para 3b
insert into Connects values ('2007-01-10 09:00:00','2007-02-25 08:00:00','S-201201','Samsung','pan007.healthunit.org');
insert into Connects values ('2007-02-26 09:00:00','2007-03-25 08:00:00','S-201202','Siemens','pan007.healthunit.org');
insert into Connects values ('2007-03-25 09:00:00','2007-07-20 08:00:00','A-201201','Samsung','pan007.healthunit.org'); 


