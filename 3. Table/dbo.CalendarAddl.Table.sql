USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarAddl](
	[DateKey] [int] NOT NULL,
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
	[IsHoliday] [tinyint] NOT NULL,
	[IsLeapYear] [bit] NOT NULL,
	[TheISOweek] [int] NOT NULL,
	[TheISOYear] [int] NOT NULL,
	[Has53Weeks] [int] NOT NULL,
	[Has53ISOWeeks] [int] NOT NULL,
	[MMYYYY] [char](6) NOT NULL,
	[Style101] [char](10) NOT NULL,
	[Style103] [char](10) NOT NULL,
	[Style112] [char](8) NOT NULL,
	[Style120] [char](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CalendarAddl] ADD  DEFAULT ((0)) FOR [IsHoliday]
GO
ALTER TABLE [dbo].[CalendarAddl]  WITH CHECK ADD FOREIGN KEY([DateKey])
REFERENCES [dbo].[Calendar] ([DateKey])
GO
