USE [SampleSales ]
GO

/****** Object:  Table [dbo].[t_date_time]    Script Date: 28.10.2021 20:16:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_date_time](
	[A_time] [time](7) NULL,
	[A_date] [date] NULL,
	[A_smalldatetime] [smalldatetime] NULL,
	[A_datetime] [datetime] NULL,
	[A_datetime2] [datetime2](7) NULL,
	[A_datetimeoffset] [datetimeoffset](7) NULL
) ON [PRIMARY]
GO

INSERT t_date_time
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())


SELECT A_time, A_date, GETDATE(),
       DATEDIFF(MINUTE, A_time, GETDATE()) AS MINUTE_DIFF,
	   DATEDIFF(WEEK, A_date, '2021-11-30') AS WEEK_DIFF
FROM t_date_time


SELECT A_time, A_date, GETDATE(),
		DATEDIFF (MINUTE, A_time, GETDATE())
FROM t_date_time


SELECT DATEDIFF(DAY, shipped_date, order_date) DATE_DIFF, order_date, shipped_date
FROM sale.orders


SELECT ORDER_DATE,
       DATEADD(YEAR , 5 , order_date) YEAR_ADD,
	   DATEADD(DAY, 10 , order_date) DAY_ADD
FROM   sale.orders


SELECT DATEADD(HOUR, 5, GETDATE())



SELECT order_date,
       DATEADD(YEAR, 5 ,order_date) YEAR_ADD,
	   DATEADD(DAY,10, order_date) DAY_ADD,
	   DATEADD(HOUR, 5, GETDATE()) GET_ADD
FROM sale.orders


SELECT EOMONTH(GETDATE()), EOMONTH(GETDATE(),2)

SELECT ISDATE('2021-10-01')

SELECT ISDATE('SELECT')


--Orders tablosuna sipariþlerin teslimat hýzýyla ilgili bir alan ekleyin.
--Bu alanda eðer teslimat gerçekleþmemiþse 'Not Shipped',
--Eðer sipariþ günü teslim edilmiþse 'Fast',
--Eðer sipariþten sonraki iki gün içinde teslim edilmiþse 'Normal'
--2 günden geç teslim edilenler ise 'Slow'
--olarak her bir sipariþi etiketleyin.


SELECT order_id, order_date, shipped_date,
    CASE
        WHEN shipped_date is null THEN 'Not Shipped'
        WHEN DATEDIFF(day, order_date, shipped_date)=0 THEN 'Fast'
        WHEN DATEDIFF(day, order_date, shipped_date)>=1 and DATEDIFF(day, order_date, shipped_date)<=2 THEN 'Normal'
		WHEN DATEDIFF(day, order_date, shipped_date)>2 THEN 'Slow'
    END AS shipping_situation
FROM sale.orders;



WITH T1 AS
(
SELECT *,
		DATEDIFF(DAY, order_date, shipped_date) DIFF_SHIPPED_AND_ORDER
FROM	sale.orders
)
SELECT ORDER_DATE,
		shipped_date,
		CASE WHEN DIFF_SHIPPED_AND_ORDER IS NULL THEN 'Not Shipped'
			 WHEN DIFF_SHIPPED_AND_ORDER = 0 THEN 'Fast'
			 WHEN DIFF_SHIPPED_AND_ORDER <= 2 THEN 'Normal'
			 WHEN DIFF_SHIPPED_AND_ORDER > 2 THEN 'Slow'
		END AS Order_Label
FROM	T1

--2 günden geç teslim edilen sipariþlerin bilgilerini getiriniz.
 
SELECT *,
	DATEDIFF(day,order_date,shipped_date) as diff_day
FROM sale.orders
WHERE DATEDIFF(day,order_date,shipped_date) >2


-- Yukarýdaki sipariþlerin haftanýn günlerine göre daðýlýmýný hesaplayýnýz.

select SUM(TT.a), SUM(TT.b), SUM(TT.c), SUM(TT.d), SUM(TT.e), SUM(TT.f), SUM(TT.g)
from 
(select case when datename(weekday, T1.order_date) = 'Monday' then 1 else 0 end a,
case when datename(weekday, T1.order_date) = 'Tuesday' then 1 else 0 end b,
case when datename(weekday, T1.order_date) = 'Wednesday' then 1 else 0 end c,
case when datename(weekday, T1.order_date) = 'Thursday' then 1 else 0 end d,
case when datename(weekday, T1.order_date) = 'Friday' then 1 else 0 end e,
case when datename(weekday, T1.order_date) = 'Saturday' then 1 else 0 end f,
case when datename(weekday, T1.order_date) = 'Sunday' then 1 else 0 end g
from
(select *, datediff(day, order_date, shipped_date) as gun
from sale.orders
where datediff(day, order_date, shipped_date) > 2) as T1) as TT


select  sum(CASE
		WHEN datename(weekday, order_Date) = 'Monday' THEN 1
		END) AS MONDAY,
		 sum(CASE
		WHEN datename(weekday, order_Date) = 'Tuesday' THEN 1
		END) AS Thuesday,
		 sum(CASE
		WHEN datename(weekday, order_Date) = 'Wednesday' THEN 1
		END) AS Wednesday,
		 sum(CASE
		WHEN datename(weekday, order_Date) = 'Thursday' THEN 1
		END) AS Thursday,
		 sum(CASE
		WHEN datename(weekday, order_Date) = 'Friday' THEN 1
		END) AS Friday,
		 sum(CASE
		WHEN datename(weekday, order_Date) = 'Saturday' THEN 1
		END) AS Saturday,
		 sum(CASE
		WHEN datename(weekday, order_Date) = 'Sunday' THEN 1
		END) AS Sunday
from sale.orders
WHERE DATEDIFF (day, order_date, shipped_date) >2

SELECT	SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Monday' THEN 1 END) MONDAY,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Tuesday' THEN 1 END) Tuesday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Wednesday' THEN 1 END) Wednesday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Thursday' THEN 1 END) Thursday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Friday' THEN 1 END) Friday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Saturday' THEN 1 END) Saturday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Sunday' THEN 1 END) Sunday
FROM	sale.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2





------ string fuctýon----

SELECT LEN(123135456987)

SELECT LEN('WELCOME')

SELECT CHARINDEX('C', 'CHARACTER')

SELECT CHARINDEX('C', 'CHARACTER', 2)

SELECT CHARINDEX('CT', 'CHARACTER')

SELECT CHARINDEX('CT%', 'CHARACTER')

SELECT CHARINDEX('CT%', 'CHARACT%ER')

SELECT PATINDEX('%R', 'CHARACTER')

SELECT PATINDEX('%R%', 'CHARACTER')

SELECT PATINDEX('___R%', 'CHARACTER')


SELECT LEFT ('CHARACTER', 3)

SELECT RIGHT ('CHARACTER', 3)

SELECT RIGHT ('CHARACTER', 1)

SELECT RIGHT ('CHARACTER ', 3)

SELECT SUBSTRING('CHARACTER', 1, 3)    --- BÝRDEN ÝTÝBAREN ÜÇ KARAKTER AL ---

SELECT SUBSTRING('CHARACTER', -1, 3)

SELECT LOWER('CHARACTER')

SELECT UPPER('CHARACTER')

SELECT UPPER(LEFT('character',1))+LOWER(SUBSTRING('character',2,LEN('character')))


SELECT * FROM string_split('ALÝ, MEHMET, AYÞE', ',')

SELECT TRIM('   CHARACTER  ' )

SELECT TRIM('%&' FROM 'CHARACTER %&')

SELECT LTRIM('    CHARA   CTER ')

SELECT RTRIM('   CHARA CTER        ')