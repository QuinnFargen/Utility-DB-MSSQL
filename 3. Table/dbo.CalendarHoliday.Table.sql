USE [Helper]
GO
/****** Object:  Table [dbo].[CalendarHoliday]    Script Date: 2/17/2024 4:27:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarHoliday](
	[DateKey] [int] NOT NULL,
	[TheDate] [date] NOT NULL,
	[HolidayText] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CalendarHoliday]  WITH CHECK ADD FOREIGN KEY([DateKey])
REFERENCES [dbo].[Calendar] ([DateKey])
GO