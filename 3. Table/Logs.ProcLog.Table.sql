USE [Helper]
GO
/****** Object:  Table [Logs].[ProcLog]    Script Date: 2/17/2024 4:27:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logs].[ProcLog](
	[PLID] [int] IDENTITY(1,1) NOT NULL,
	[LogDate] [smalldatetime] NOT NULL,
	[LogDateEnd] [smalldatetime] NULL,
	[LoginName] [sysname] NULL,
	[ExecSPID] [smallint] NULL,
	[ExecPLID] [int] NULL,
	[ExecName] [nvarchar](400) NULL,
	[ProcedureName] [nvarchar](400) NULL,
PRIMARY KEY CLUSTERED 
(
	[PLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Logs].[ProcLog] ADD  DEFAULT (getdate()) FOR [LogDate]
GO
