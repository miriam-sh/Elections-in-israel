USE [voting]
GO
/****** Object:  UserDefinedFunction [dbo].[ballotPercentInHourInCity]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--אחוזי הצבעה לפי שעות מסוימות לפי עיר מסוימת
create function [dbo].[ballotPercentInHourInCity](@time time, @city smallint) returns smallint
begin
return
(select count(*) as 'countInHour'
from people
where dbo.isBefore(people.ballotTime, @time) = 1
and city = @city)*100
/
(select count(*) as 'count'
from people
where city = @city)
end
GO
/****** Object:  UserDefinedFunction [dbo].[change]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[change](@party varchar(3)) returns int
begin
if(@party in(select party1 from changeAgreement where party1 in
(select letters from partiesInAssembly) and party2 in
(select letters from partiesInAssembly)))
	return (select sum(sumOfPointer)/(sum(sumOfSeats)+1+(
	select sumSeatsForShare from changeAgreement where party1 = @party)) from parties
	where letters = @party or letters = (select party2 from changeAgreement where party1 = @party))

return (select sumOfPointer/(sumOfSeats+1) from parties where letters = @party)
end
GO
/****** Object:  UserDefinedFunction [dbo].[checkChangeAgreement]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[checkChangeAgreement](@id smallint) returns varchar(3)
begin
if((select sumOfPointer/(sumOfSeats+1) from partiesInAssembly where letters = (select party1 from changeAgreement where id = @id))>
(select sumOfPointer/(sumOfSeats+1) from partiesInAssembly where letters = (select party2 from changeAgreement where id = @id))) return
(select party1 from changeAgreement where id = @id)
return (select party2 from changeAgreement where id = @id)
end
GO
/****** Object:  UserDefinedFunction [dbo].[isBefore]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[isBefore](@time1 time, @time2 datetime) returns smallint
begin
if (DATEPART(hour, @time1) < DATEPART(hour, @time2)) return 1
if (DATEPART(hour, @time1) = DATEPART(hour, @time2) and
DATEPART(minute, @time1) < DATEPART(minute, @time2)) return 1
return 0
end
GO
/****** Object:  UserDefinedFunction [dbo].[mathsumSeatsFree]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[mathsumSeatsFree]() returns smallint
begin
declare @sumOfSeats smallint = (select sum(sumOfSeats) from parties)
+ (select sum(sumSeatsForShare) from changeAgreement)
return 120-@sumOfSeats
end
GO
/****** Object:  UserDefinedFunction [dbo].[ballotPercentInTime]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ballotPercentInTime](@time time) returns table
return
select before.city, countInHour*100/count as'ballotPercent' from
(select city 'city', count(*) as 'countInHour'
from people
where dbo.isBefore(people.ballotTime,@time)=1
group by city) before
join
(select city as 'city', count(*) as 'count'
from people 
group by city) general
on before.city = general.city
GO
/****** Object:  View [dbo].[ballotPercentInHour]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ballotPercentInHour] as
select id 'city',
dbo.ballotPercentInHourInCity('08:00', id) '08:00',
dbo.ballotPercentInHourInCity('09:00', id) '09:00',
dbo.ballotPercentInHourInCity('10:00', id) '10:00',
dbo.ballotPercentInHourInCity('11:00', id) '11:00',
dbo.ballotPercentInHourInCity('12:00', id) '12:00',
dbo.ballotPercentInHourInCity('13:00', id) '13:00',
dbo.ballotPercentInHourInCity('14:00', id) '14:00',
dbo.ballotPercentInHourInCity('15:00', id) '15:00',
dbo.ballotPercentInHourInCity('16:00', id) '16:00',
dbo.ballotPercentInHourInCity('17:00', id) '17:00',
dbo.ballotPercentInHourInCity('18:00', id) '18:00',
dbo.ballotPercentInHourInCity('19:00', id) '19:00',
dbo.ballotPercentInHourInCity('20:00', id) '20:00',
dbo.ballotPercentInHourInCity('21:00', id) '21:00',
dbo.ballotPercentInHourInCity('22:00', id) '22:00'
from cities
GO
/****** Object:  View [dbo].[candidatesThatNoBallot]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[candidatesThatNoBallot] as
select LastName, FirsrtName, address from candidates
except
select LastName, FirsrtName, address from people where ballotTime is not null
GO
/****** Object:  View [dbo].[diractors]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[diractors] as
select letters, name, isnull(sumOfSeats, 0) sumOfSeats, case underBarringPercent
when 1 then 'עבר'
else 'לא עבר'
end 'BarringPercent',
isnull(id,'-') diractorId,
isnull(LastName, '-') diractorLastName,
isnull(FirsrtName, '-') diractorFirsrtName,
isnull(address, '-') diractorAddress
from parties left join (select * from candidates where placeInList = 1) diractors
on parties.letters = diractors.party
where letters!='x'
GO
/****** Object:  View [dbo].[directors]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[directors] as
select letters, name, isnull(sumOfSeats, 0) sumOfSeats, case underBarringPercent
when 1 then 'עבר'
else 'לא עבר'
end 'BarringPercent',
isnull(id,'-') directorId,
isnull(LastName, '-') directorLastName,
isnull(FirsrtName, '-') directorFirsrtName,
isnull(address, '-') directorAddress
from parties left join (select * from candidates where placeInList = 1) directors
on parties.letters = directors.party
where letters!='x'
GO
/****** Object:  View [dbo].[firstBallot]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[firstBallot] as
select LastName, FirsrtName, cast(ballotTime as time) as ballotTime from
(select  LastName, FirsrtName, ballotTime, ROW_NUMBER() over(partition by ballotBox order by ballotTime) 'r' from people) p
where r = 1
GO
/****** Object:  View [dbo].[partiesInAssembly]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[partiesInAssembly] as
select * from parties
where letters != 'x' and underBarringPercent != 0
GO
/****** Object:  StoredProcedure [dbo].[addBallotBox]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addBallotBox](@city smallint, @location varchar(30), @address varchar(30)) as
begin
insert into ballotBoxes values(@city,@location, @address)
end
GO
/****** Object:  StoredProcedure [dbo].[addCandidate]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addCandidate](
@tz varchar(9), @lastName varchar(20)=null, @firstName varchar(20)=null,
@address varchar(20)=null, @party varchar(3), @placeInList smallint) as
begin
insert into candidates values(@tz,@lastName,@firstName,@address,@party,@placeInList)
end
GO
/****** Object:  StoredProcedure [dbo].[addChangeAgreement]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addChangeAgreement](@party1 varchar(3), @party2 varchar(3)) as
begin
insert into changeAgreement(party1, party2) values(@party1,@party2)
end
GO
/****** Object:  StoredProcedure [dbo].[addEnvelope]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addEnvelope](@ballotBox smallint = null, @party varchar(3)) as
begin
insert into envelope values(@ballotBox,@party)
end
GO
/****** Object:  StoredProcedure [dbo].[addParty]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addParty](@letter varchar(3), @name varchar(20)=null) as
begin
	insert into parties(letters, name) values(@letter, @name)
end
GO
/****** Object:  StoredProcedure [dbo].[ballot]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ballot](@tz varchar(9), @ballotBox smallint) as
begin
update people set ballotTime = GETDATE() where id = @tz
and (ballotBox = @ballotBox or doubleEnvelope=1)
end
GO
/****** Object:  StoredProcedure [dbo].[calculationSeats]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[calculationSeats] as
begin
exec checkCorrect --בדיקת נכונות
exec updateSumVodes --עדכון כמות הקולות למפלגה
exec partiesUnderBarringPercent --עדכון אחוז חסימה ובודק איזה מפלגות לא עברו אותו
exec mathMandat--עדכון כמות הקולות למנדט
exec firstUpdateSumMandate --חלוקת מנדטים ראשונית
while(dbo.mathsumSeatsFree()>0)--לכל מנדט פנוי מוסיף למפלגה המתאימה
begin
exec shareSeat --מריץ פרוצדורת חלוקת מנדט
end
exec updateChangeAgreementFinal --הוספת מנדטים ע''פ הסכמי עודפים
end
GO
/****** Object:  StoredProcedure [dbo].[checkBallotBox]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[checkBallotBox](@tz varchar(9)) as
begin
declare @name varchar(40)
declare @ballotBox smallint
declare @cityId smallint
select @name=(LastName+' '+FirsrtName), @ballotBox=ballotBox, @cityId=city from people where id=@tz 
declare @assembly smallint = (select top 1 assembly from necessaryInformation)
declare @location varchar(30)
declare @address varchar(30)
select @location= location,@address=address from ballotBoxes where id = @ballotBox
declare @city varchar(30) = (select name from cities where id = @cityId)
declare @date varchar(30) = convert(varchar(20),
(select votingDate from necessaryInformation where assembly = @assembly) ,105)

print 'הודעה לבוחר'
print 'הבחירות לכנסת ה' + cast(@assembly as varchar(4))
print '-----------------'
print 'שלום ' +  @name
print 'את/ה מצביע/ה בקלפי מספר '+ cast(@ballotBox as varchar(100))
print 'מיקום: ' + @location
print 'כתובת: ' + @address + ' '+ @city
print 'הבחירות יתקיימו ביום ג ה-' + @date  + ' בין השעות 22:00  - 7:00 '
print 'נא להביא תעודת זהות או לחילופין דרכון או רשיון נהיגה בתוקף'
end
GO
/****** Object:  StoredProcedure [dbo].[checkCorrect]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[checkCorrect] as
begin
declare cc cursor for
select id from ballotBoxes
open cc
declare @id smallint
fetch next from cc into @id
while @@FETCH_STATUS=0
begin
exec checkCorrectBallotBox @id
fetch next from cc into @id
end
close cc
deallocate cc
end
GO
/****** Object:  StoredProcedure [dbo].[checkCorrectBallotBox]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[checkCorrectBallotBox](@id smallint) as
begin
if((select count(*) from envelope where ballotBox=@id) > 
(select count(*) from people where ballotBox=@id and ballotTime is not null))
update envelope set party = 'x' where ballotBox=@id
end
GO
/****** Object:  StoredProcedure [dbo].[firstUpdateSumMandate]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[firstUpdateSumMandate] as
begin
update parties set sumOfSeats = sumOfPointer/
(select sumVodesForSeat from necessaryInformation where assembly = 26)
where letters not in(select letters from parties where underBarringPercent = 0)
end
GO
/****** Object:  StoredProcedure [dbo].[mathMandat]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[mathMandat] as
update necessaryInformation set sumVodesForSeat =
(select sum(sumOfPointer) from partiesInAssembly)/120
GO
/****** Object:  StoredProcedure [dbo].[partiesUnderBarringPercent]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[partiesUnderBarringPercent] as
begin
update necessaryInformation set BarringPercent = 
(select count(*) from envelope where party != 'x')*0.035
update parties set underBarringPercent = 1
update parties set underBarringPercent = 0 where sumOfPointer <
(select BarringPercent from necessaryInformation)
end
GO
/****** Object:  StoredProcedure [dbo].[shareSeat]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[shareSeat] as
begin
declare @party varchar(3) = 
(select letters from partiesInAssembly where
dbo.change(letters) =
(select max(dbo.change(letters)) from partiesInAssembly where letters not in(select party2 from changeAgreement)))

if(@party in(select party1 from changeAgreement))
	update changeAgreement set sumSeatsForShare = sumSeatsForShare+1 where party1 = @party
else
update parties set sumOfSeats = sumOfSeats+1 where letters = @party
end
GO
/****** Object:  StoredProcedure [dbo].[updateChangeAgreement]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[updateChangeAgreement](@id smallint) as
begin
while((select sumSeatsForShare from changeAgreement where id = @id)>0)
begin
update parties set sumOfSeats = sumOfSeats+1 where letters = dbo.checkChangeAgreement(@id)
update changeAgreement set sumSeatsForShare = sumSeatsForShare-1  where id = @id
end
end
GO
/****** Object:  StoredProcedure [dbo].[updateChangeAgreementFinal]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[updateChangeAgreementFinal] as
begin
declare ca cursor for
select id from changeAgreement where sumSeatsForShare>0
open ca
declare @id smallint
fetch next from ca into @id
while @@FETCH_STATUS=0
begin
exec updateChangeAgreement @id
fetch next from ca into @id
end
close ca
deallocate ca
end
GO
/****** Object:  StoredProcedure [dbo].[updateSumVodes]    Script Date: 18/03/2024 12:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[updateSumVodes] as
begin
update parties set sumOfPointer = 
(select count(*) from envelope where party = letters)
end
GO
