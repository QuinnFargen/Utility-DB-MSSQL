USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calendar](
	[DateKey] [int] NOT NULL,
	[TheDate] [date] NOT NULL,
	[TheDay] [tinyint] NOT NULL,
	[TheWeek] [tinyint] NOT NULL,
	[TheMonth] [tinyint] NOT NULL,
	[TheQuarter] [int] NOT NULL,
	[TheYear] [int] NOT NULL,
	[TheDayOfWeek] [tinyint] NOT NULL,
	[TheDayName] [nvarchar](30) NOT NULL,
	[TheMonthName] [nvarchar](30) NOT NULL,
	[TheFirstOfMonth] [date] NOT NULL,
	[TheLastOfMonth] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
