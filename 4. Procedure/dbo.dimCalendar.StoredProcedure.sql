USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================		
-- Author:		Quinn Fargen
-- Create date: 2024.02.16
-- Description:	Calendar Dim Table
-- =============================================	  */
CREATE PROCEDURE [dbo].[dimCalendar]
	
AS
BEGIN

	SET NOCOUNT ON;

	/*  https://www.mssqltips.com/sqlservertip/4054/creating-a-date-dimension-or-calendar-table-in-sql-server/	*/
	
	
		DROP TABLE IF EXISTS [dbo].CalendarHoliday
		DROP TABLE IF EXISTS [dbo].[CalendarAddl]
		DROP TABLE IF EXISTS [dbo].[Calendar]
			CREATE TABLE [dbo].[Calendar](
				[DateKey] [int] NOT NULL PRIMARY KEY,
				[TheDate] [date] NOT NULL,
				[TheDay] [tinyint] NOT NULL,
				[TheWeek] [tinyint] NOT NULL,
				[TheMonth] [tinyint] NOT NULL,
				[TheQuarter] [int] NOT NULL,
				[TheYear] [int] NOT NULL,
				[TheDayOfWeek] [tinyint] NOT NULL,
				[TheDayName] [nvarchar](30) NOT NULL,
				[TheMonthName] [nvarchar](30) NOT NULL,
				[TheFirstOfMonth] [date] NOT NULL,	/* Useful in Both */
				[TheLastOfMonth] [date] NOT NULL	/* Useful in Both */
			) ON [PRIMARY]
			
			CREATE TABLE [dbo].[CalendarAddl](
				[DateKey] [int] NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES [dbo].[Calendar] ([DateKey]),
				[TheDate] [date] NOT NULL,
				
				[TheFirstOfWeek] [date] NOT NULL,
				[TheLastOfWeek] [date] NOT NULL,
				[TheFirstOfMonth] [date] NOT NULL,
				[TheLastOfMonth] [date] NOT NULL,
				[TheFirstOfNextMonth] [date] NOT NULL,
				[TheLastOfNextMonth] [date] NOT NULL,
				[TheFirstOfPriorMonth] [date] NOT NULL,
				[TheLastOfPriorMonth] [date] NOT NULL,
				[TheFirstOfQuarter] [date] NOT NULL,
				[TheLastOfQuarter] [date] NOT NULL,
				[TheFirstOfYear] [date] NOT NULL,
				[TheLastOfYear] [date] NOT NULL,

				[TheDaySuffix] [char](2) NOT NULL,
				[TheDayOfWeekInMonth] [tinyint] NOT NULL,
				[TheDayOfYear] [int] NOT NULL,
				[TheWeekOfMonth] [tinyint] NOT NULL,
				[IsWeekend] [tinyint] NOT NULL,
				[IsHoliday] [tinyint] NOT NULL DEFAULT (0),	/* UPDATED After Populated */
				[IsLeapYear] [bit] NOT NULL,
				[TheISOweek] [int] NOT NULL,
				[TheISOYear] [int] NOT NULL,
				[Has53Weeks] [int] NOT NULL,
				[Has53ISOWeeks] [int] NOT NULL,
				[MMYYYY] [char](6) NOT NULL,
				[Style101] [char](10) NOT NULL,
				[Style103] [char](10) NOT NULL,
				[Style112] [char](8) NOT NULL,
				[Style120] [char](10) NOT NULL
			) ON [PRIMARY]
			
			CREATE TABLE dbo.CalendarHoliday
			(
				[DateKey] [int] NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES [dbo].[Calendar] ([DateKey]),		  
				TheDate date NOT NULL,
				HolidayText nvarchar(255) NOT NULL
			);

			
	/*		--------------------------------------------------------------		*/

	
	DROP TABLE IF EXISTS #CalandarFull

	DECLARE @StartDate  date = '20100101';

	DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 30, @StartDate));

	;WITH seq(n) AS 
	(
	  SELECT 0 UNION ALL SELECT n + 1 FROM seq
	  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
	),
	d(d) AS 
	(
	  SELECT DATEADD(DAY, n, @StartDate) FROM seq
	),
	src AS
	(
	  SELECT
		TheDate         = CONVERT(date, d),
		TheDay          = DATEPART(DAY,       d),
		TheDayName      = DATENAME(WEEKDAY,   d),
		TheWeek         = DATEPART(WEEK,      d),
		TheISOWeek      = DATEPART(ISO_WEEK,  d),
		TheDayOfWeek    = DATEPART(WEEKDAY,   d),
		TheMonth        = DATEPART(MONTH,     d),
		TheMonthName    = DATENAME(MONTH,     d),
		TheQuarter      = DATEPART(Quarter,   d),
		TheYear         = DATEPART(YEAR,      d),
		TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
		TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
		TheDayOfYear    = DATEPART(DAYOFYEAR, d)
	  FROM d
	),
	dim AS
	(
	  SELECT
		TheDate, 
		TheDay,
		TheDaySuffix        = CONVERT(char(2), CASE WHEN TheDay / 10 = 1 THEN 'th' ELSE 
								CASE RIGHT(TheDay, 1) WHEN '1' THEN 'st' WHEN '2' THEN 'nd' 
								WHEN '3' THEN 'rd' ELSE 'th' END END),
		TheDayName,
		TheDayOfWeek,
		TheDayOfWeekInMonth = CONVERT(tinyint, ROW_NUMBER() OVER 
								(PARTITION BY TheFirstOfMonth, TheDayOfWeek ORDER BY TheDate)),
		TheDayOfYear,
		IsWeekend           = CASE WHEN TheDayOfWeek IN (CASE @@DATEFIRST WHEN 1 THEN 6 WHEN 7 THEN 1 END,7) 
								THEN 1 ELSE 0 END,
		TheWeek,
		TheISOweek,
		TheFirstOfWeek      = DATEADD(DAY, 1 - TheDayOfWeek, TheDate),
		TheLastOfWeek       = DATEADD(DAY, 6, DATEADD(DAY, 1 - TheDayOfWeek, TheDate)),
		TheWeekOfMonth      = CONVERT(tinyint, DENSE_RANK() OVER 
								(PARTITION BY TheYear, TheMonth ORDER BY TheWeek)),
		TheMonth,
		TheMonthName,
		TheFirstOfMonth,
		TheLastOfMonth      = MAX(TheDate) OVER (PARTITION BY TheYear, TheMonth),
		TheFirstOfNextMonth = DATEADD(MONTH, 1, TheFirstOfMonth),
		TheLastOfNextMonth  = DATEADD(DAY, -1, DATEADD(MONTH, 2, TheFirstOfMonth)),
		TheFirstOfPriorMonth = DATEADD(MONTH, -1, TheFirstOfMonth),
		TheLastOfPriorMonth  = DATEADD(DAY, -1, TheFirstOfMonth),
		TheQuarter,
		TheFirstOfQuarter   = MIN(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
		TheLastOfQuarter    = MAX(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
		TheYear,
		TheISOYear          = TheYear - CASE WHEN TheMonth = 1 AND TheISOWeek > 51 THEN 1 
								WHEN TheMonth = 12 AND TheISOWeek = 1  THEN -1 ELSE 0 END,      
		TheFirstOfYear      = DATEFROMPARTS(TheYear, 1,  1),
		TheLastOfYear,
		IsLeapYear          = CONVERT(bit, CASE WHEN (TheYear % 400 = 0) 
								OR (TheYear % 4 = 0 AND TheYear % 100 <> 0) 
								THEN 1 ELSE 0 END),
		Has53Weeks          = CASE WHEN DATEPART(WEEK,     TheLastOfYear) = 53 THEN 1 ELSE 0 END,
		Has53ISOWeeks       = CASE WHEN DATEPART(ISO_WEEK, TheLastOfYear) = 53 THEN 1 ELSE 0 END,
		MMYYYY              = CONVERT(char(2), CONVERT(char(8), TheDate, 101))
							  + CONVERT(char(4), TheYear),
		Style101            = CONVERT(char(10), TheDate, 101),
		Style103            = CONVERT(char(10), TheDate, 103),
		Style112            = CONVERT(char(8),  TheDate, 112),
		Style120            = CONVERT(char(10), TheDate, 120)
	  FROM src
	)
	
	/*		--------------------------------------------------------------		*/

	
		SELECT 
			DateKey = (TheYear * 10000) + (TheMonth * 100) + TheDay
			,TheDate,TheDay,TheWeek,TheMonth,TheYear,TheDayOfWeek,TheMonthName,TheFirstOfMonth,TheLastOfMonth,TheFirstOfPriorMonth,TheLastOfPriorMonth
			,TheDaySuffix,TheDayName,TheDayOfWeekInMonth,TheDayOfYear,IsWeekend,TheISOweek,TheFirstOfWeek,TheLastOfWeek,TheWeekOfMonth,TheFirstOfNextMonth,TheLastOfNextMonth
			,TheQuarter,TheFirstOfQuarter,TheLastOfQuarter,TheISOYear,TheFirstOfYear,TheLastOfYear,IsLeapYear,Has53Weeks,Has53ISOWeeks,MMYYYY,style101,Style103,Style112,Style120  
		INTO #CalandarFull
		FROM dim d
		ORDER BY TheDate
		OPTION (MAXRECURSION 0);
		/* 10957 */
		

	  INSERT INTO dbo.Calendar (DateKey,TheDate,TheDay,TheWeek,TheMonth,TheQuarter,TheYear,TheDayOfWeek,TheDayName,TheMonthName,TheFirstOfMonth,TheLastOfMonth)
	  SELECT 
		DateKey = (TheYear * 10000) + (TheMonth * 100) + TheDay
		,TheDate,TheDay,TheWeek,TheMonth,TheQuarter,TheYear,TheDayOfWeek,TheDayName,TheMonthName,TheFirstOfMonth,TheLastOfMonth
	  FROM #CalandarFull A
	  
	  INSERT INTO dbo.CalendarAddl (DateKey,TheDate,
					TheFirstOfWeek,TheLastOfWeek,TheFirstOfMonth,TheLastOfMonth,TheFirstOfNextMonth,TheLastOfNextMonth,TheFirstOfPriorMonth,TheLastOfPriorMonth,TheFirstOfQuarter,TheLastOfQuarter,TheFirstOfYear,TheLastOfYear
					,TheDaySuffix,TheDayOfWeekInMonth,TheDayOfYear,TheWeekOfMonth,IsWeekend/*,IsHoliday*/,IsLeapYear,TheISOweek,TheISOYear,Has53Weeks,Has53ISOWeeks,MMYYYY,Style101,Style103,Style112,Style120   )
	  SELECT 
		DateKey = (TheYear * 10000) + (TheMonth * 100) + TheDay
		,TheDate, TheFirstOfWeek,TheLastOfWeek,TheFirstOfMonth,TheLastOfMonth,TheFirstOfNextMonth,TheLastOfNextMonth,TheFirstOfPriorMonth,TheLastOfPriorMonth,TheFirstOfQuarter,TheLastOfQuarter,TheFirstOfYear,TheLastOfYear
		,TheDaySuffix,TheDayOfWeekInMonth,TheDayOfYear,TheWeekOfMonth,IsWeekend/*,IsHoliday*/,IsLeapYear,TheISOweek,TheISOYear,Has53Weeks,Has53ISOWeeks,MMYYYY,Style101,Style103,Style112,Style120
	  FROM #CalandarFull A
	  
	  
	/*		--------------------------------------------------------------		*/


		;WITH x AS 
		(
		  SELECT
			A.TheDate,
			A.DateKey,
			TheFirstOfYear,
			TheDayOfWeekInMonth, 
			TheMonth, 
			TheDayName, 
			TheDay,
			TheLastDayOfWeekInMonth = ROW_NUMBER() OVER 
			(
			  PARTITION BY A.TheFirstOfMonth, TheDayOfWeek
			  ORDER BY A.TheDate DESC
			)
		  FROM dbo.Calendar A
		  JOIN dbo.CalendarAddl B on A.DateKey = B.DateKey
		),
		s AS
		(
		  SELECT TheDate, DateKey, HolidayText = CASE
		  WHEN (TheDate = TheFirstOfYear) 
			THEN 'New Year''s Day'
		  WHEN (TheDayOfWeekInMonth = 3 AND TheMonth = 1 AND TheDayName = 'Monday')
			THEN 'Martin Luther King Day'    /* (3rd Monday in January)	*/
		  WHEN (TheDayOfWeekInMonth = 3 AND TheMonth = 2 AND TheDayName = 'Monday')
			THEN 'President''s Day'          /* (3rd Monday in February)	*/
		  WHEN (TheLastDayOfWeekInMonth = 1 AND TheMonth = 5 AND TheDayName = 'Monday')
			THEN 'Memorial Day'              /* (last Monday in May)	*/
		  WHEN (TheMonth = 7 AND TheDay = 4)
			THEN 'Independence Day'          /* (July 4th)	*/
		  WHEN (TheDayOfWeekInMonth = 1 AND TheMonth = 9 AND TheDayName = 'Monday')
			THEN 'Labour Day'                /* (first Monday in September)	*/
		  WHEN (TheDayOfWeekInMonth = 2 AND TheMonth = 10 AND TheDayName = 'Monday')
			THEN 'Columbus Day'              /* Columbus Day (second Monday in October)	*/
		  WHEN (TheMonth = 11 AND TheDay = 11)
			THEN 'Veterans'' Day'            /* (November 11th)	*/
		  WHEN (TheDayOfWeekInMonth = 4 AND TheMonth = 11 AND TheDayName = 'Thursday')
			THEN 'Thanksgiving Day'          /* (Thanksgiving Day ()fourth Thursday in November) */
		  WHEN (TheMonth = 12 AND TheDay = 25)
			THEN 'Christmas Day'
		  END
		  FROM x
		  WHERE 
			(TheDate = TheFirstOfYear)
			OR (TheDayOfWeekInMonth = 3     AND TheMonth = 1  AND TheDayName = 'Monday')
			OR (TheDayOfWeekInMonth = 3     AND TheMonth = 2  AND TheDayName = 'Monday')
			OR (TheLastDayOfWeekInMonth = 1 AND TheMonth = 5  AND TheDayName = 'Monday')
			OR (TheMonth = 7 AND TheDay = 4)
			OR (TheDayOfWeekInMonth = 1     AND TheMonth = 9  AND TheDayName = 'Monday')
			OR (TheDayOfWeekInMonth = 2     AND TheMonth = 10 AND TheDayName = 'Monday')
			OR (TheMonth = 11 AND TheDay = 11)
			OR (TheDayOfWeekInMonth = 4     AND TheMonth = 11 AND TheDayName = 'Thursday')
			OR (TheMonth = 12 AND TheDay = 25)
		)

		INSERT dbo.CalendarHoliday(DateKey ,TheDate, HolidayText)
			SELECT DateKey, TheDate, HolidayText FROM s 
			UNION ALL 
			SELECT DateKey + 1 ,DATEADD(DAY, 1, TheDate), 'Black Friday'
			  FROM s WHERE HolidayText = 'Thanksgiving Day'
			ORDER BY TheDate;
			
		INSERT dbo.CalendarHoliday(DateKey ,TheDate, HolidayText)
			SELECT D.DateKey ,d.TheDate, h.HolidayText
			FROM dbo.Calendar AS d
			CROSS APPLY dbo.[udf_tblGetEasterHolidays](d.TheYear) AS h
			WHERE d.TheDate = h.TheDate;

		UPDATE D
		SET	IsHoliday = CASE WHEN h.TheDate IS NOT NULL THEN 1 ELSE 0 END
		FROM dbo.CalendarAddl AS d
		JOIN dbo.CalendarHoliday AS h ON d.TheDate = h.TheDate;

END

GO
