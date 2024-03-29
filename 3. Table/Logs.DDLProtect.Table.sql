USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logs].[DDLProtect](
	[DDLPID] [int] IDENTITY(1,1) NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[DatabaseName] [nvarchar](255) NOT NULL,
	[SchemaName] [nvarchar](255) NOT NULL,
	[ObjectName] [nvarchar](255) NOT NULL,
	[ObjectType] [nvarchar](64) NOT NULL,
	[AllowALTER] [bit] NOT NULL,
	[AllowDROP] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DDLPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Logs].[DDLProtect] ADD  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [Logs].[DDLProtect] ADD  DEFAULT ((0)) FOR [AllowALTER]
GO
ALTER TABLE [Logs].[DDLProtect] ADD  DEFAULT ((0)) FOR [AllowDROP]
GO
