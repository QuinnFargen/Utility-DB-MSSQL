USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =============================================		
-- Author:		Quinn Fargen
-- Create date: 2024.02.16
-- Description:	US States Dim Table
-- =============================================	  */

CREATE PROCEDURE [dbo].[dimUSStates]
	
AS
BEGIN

	SET NOCOUNT ON;

	
		DROP TABLE IF EXISTS [dbo].[USStates]
		CREATE TABLE [dbo].[USStates](
			[STID] [smallint] IDENTITY(1,1) NOT NULL,
			[Abbr] [varchar](2) NULL,
			[Name] [varchar](50) NULL,
			[Capital] [varchar](50) NULL,
			[Type] [varchar](25) NULL,
			[Pop2019] [int] NULL,
			[AreaSqMi] [int] NULL,
			[Latitude] [float] NULL,
			[Longitude] [float] NULL,
		PRIMARY KEY CLUSTERED 
		(
			[STID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
		

		SET IDENTITY_INSERT [dbo].[USStates] ON 
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (1, N'AL', N' Alabama', N'Montmery', N'State', 4903185, 52420, 32.318231, -86.902298)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (2, N'AK', N' Alaska', N'Juneau', N'State', 731545, 665384, 63.588753, -154.493062)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (3, N'AZ', N' Arizona', N'Phoenix', N'State', 7278717, 113990, 34.048928, -111.093731)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (4, N'AR', N' Arkansas', N'Little Rock', N'State', 3017804, 53179, 35.20105, -91.831833)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (5, N'CA', N' California', N'Sacramento', N'State', 39512223, 163695, 36.778261, -119.417932)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (6, N'CO', N' Colorado', N'Denver', N'State', 5758736, 104094, 39.550051, -105.782067)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (7, N'CT', N' Connecticut', N'Hartford', N'State', 3565278, 5543, 41.603221, -73.087749)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (8, N'DE', N' Delaware', N'Dover', N'State', 973764, 2489, 38.910832, -75.52767)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (9, N'FL', N' Florida', N'Tallahassee', N'State', 21477737, 65758, 27.664827, -81.515754)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (10, N'GA', N' Georgia', N'Atlanta', N'State', 10617423, 59425, 32.157435, -82.907123)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (11, N'HI', N' Hawaii', N'Honolulu', N'State', 1415872, 10932, 19.898682, -155.665857)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (12, N'ID', N' Idaho', N'Boise', N'State', 1787065, 83569, 44.068202, -114.742041)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (13, N'IL', N' Illinois', N'Springfield', N'State', 12671821, 57914, 40.633125, -89.398528)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (14, N'IN', N' Indiana', N'Indianapolis', N'State', 6732219, 36420, 40.551217, -85.602364)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (15, N'IA', N' Iowa', N'Des Moines', N'State', 3155070, 56273, 41.878003, -93.097702)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (16, N'KS', N' Kansas', N'Topeka', N'State', 2913314, 82278, 39.011902, -98.484246)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (17, N'KY', N' Kentucky', N'Frankfort', N'State', 4467673, 40408, 37.839333, -84.270018)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (18, N'LA', N' Louisiana', N'Baton Rouge', N'State', 4648794, 52378, 31.244823, -92.145024)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (19, N'ME', N' Maine', N'Augusta', N'State', 1344212, 35380, 45.253783, -69.445469)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (20, N'MD', N' Maryland', N'Annapolis', N'State', 6045680, 12406, 39.045755, -76.641271)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (21, N'MA', N' Massachusetts', N'Boston', N'State', 6892503, 10554, 42.407211, -71.382437)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (22, N'MI', N' Michigan', N'Lansing', N'State', 9986857, 96714, 44.314844, -85.602364)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (23, N'MN', N' Minnesota', N'St. Paul', N'State', 5639632, 86936, 46.729553, -94.6859)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (24, N'MS', N' Mississippi', N'Jackson', N'State', 2976149, 48432, 32.354668, -89.398528)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (25, N'MO', N' Missouri', N'Jefferson City', N'State', 6137428, 69707, 37.964253, -91.831833)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (26, N'MT', N' Montana', N'Helena', N'State', 1068778, 147040, 46.879682, -110.362566)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (27, N'NE', N' Nebraska', N'Lincoln', N'State', 1934408, 77348, 41.492537, -99.901813)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (28, N'NV', N' Nevada', N'Carson City', N'State', 3080156, 110572, 38.80261, -116.419389)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (29, N'NH', N' New Hampshire', N'Concord', N'State', 1359711, 9349, 43.193852, -71.572395)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (30, N'NJ', N' New Jersey', N'Trenton', N'State', 8882190, 8723, 40.058324, -74.405661)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (31, N'NM', N' New Mexico', N'Santa Fe', N'State', 2096829, 121590, 34.97273, -105.032363)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (32, N'NY', N' New York', N'Albany', N'State', 19453561, 54555, 43.299428, -74.217933)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (33, N'NC', N' North Carolina', N'Raleigh', N'State', 10488084, 53819, 35.759573, -79.0193)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (34, N'ND', N' North Dakota', N'Bismarck', N'State', 762062, 70698, 47.551493, -101.002012)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (35, N'OH', N' Ohio', N'Columbus', N'State', 11689100, 44826, 40.417287, -82.907123)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (36, N'OK', N' Oklahoma', N'Oklahoma City', N'State', 3956971, 69899, 35.007752, -97.092877)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (37, N'OR', N' Oren', N'Salem', N'State', 4217737, 98379, 43.804133, -120.554201)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (38, N'PA', N' Pennsylvania', N'Harrisburg', N'State', 12801989, 46054, 41.203322, -77.194525)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (39, N'RI', N' Rhode Island', N'Providence', N'State', 1059361, 1545, 41.580095, -71.477429)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (40, N'SC', N' South Carolina', N'Columbia', N'State', 5148714, 32020, 33.836081, -81.163725)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (41, N'SD', N' South Dakota', N'Pierre', N'State', 884659, 77116, 43.969515, -99.901813)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (42, N'TN', N' Tennessee', N'Nashville', N'State', 6829174, 42144, 35.517491, -86.580447)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (43, N'TX', N' Texas', N'Austin', N'State', 28995881, 268596, 31.968599, -99.901813)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (44, N'UT', N' Utah', N'Salt Lake City', N'State', 3205958, 84897, 39.32098, -111.093731)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (45, N'VT', N' Vermont', N'Montpelier', N'State', 623989, 9616, 44.558803, -72.577841)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (46, N'VA', N' Virginia', N'Richmond', N'State', 8535519, 42775, 37.431573, -78.656894)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (47, N'WA', N' Washington', N'Olympia', N'State', 7614893, 71298, 47.751074, -120.740139)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (48, N'WV', N' West Virginia', N'Charleston', N'State', 1792147, 24230, 38.597626, -80.454903)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (49, N'WI', N' Wisconsin', N'Madison', N'State', 5822434, 65496, 43.78444, -88.787868)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (50, N'WY', N' Wyoming', N'Cheyenne', N'State', 578759, 97813, 43.075968, -107.290284)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (51, N'DC', N'District of Columbia', N'', N'Federal District', 705749, 68, 38.905985, -77.033418)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (52, N'AS', N'American Samoa', N'Pa Pa', N'Territory', 57400, 581, 14.271, 170.1322)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (53, N'GU', N'Guam', N'Hagatna', N'Territory', 161700, 571, 13.444304, 144.793732)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (54, N'MP', N'Northern Mariana Islands', N'Saipan', N'Territory', 52300, 1976, 15.16282, 145.781036)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (55, N'PR', N'Puerto Rico', N'San Juan', N'Territory', 3193694, 5325, 18.220833, -66.590149)
		 
		INSERT [dbo].[USStates] ([STID], [Abbr], [Name], [Capital], [Type], [Pop2019], [AreaSqMi], [Latitude], [Longitude]) VALUES (56, N'VI', N'U.S. Virgin Islands', N'Charlotte Amalie', N'Territory', 103700, 733, 18.3358, 64.8963)
		 
		SET IDENTITY_INSERT [dbo].[USStates] OFF
		 

END

GO
