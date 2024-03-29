USE [master]
GO
/****** Object:  Database [METEOROS_AssignmentDB]    Script Date: 15/01/2024 09:15:24 ******/
CREATE DATABASE [METEOROS_AssignmentDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'METEOROS_AssignmentDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\METEOROS_AssignmentDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'METEOROS_AssignmentDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\METEOROS_AssignmentDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [METEOROS_AssignmentDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET RECOVERY FULL 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET  MULTI_USER 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'METEOROS_AssignmentDB', N'ON'
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [METEOROS_AssignmentDB]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 15/01/2024 09:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](50) NOT NULL,
	[PhoneNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customertbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 15/01/2024 09:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
	[Price] [float] NOT NULL,
	[Discount] [float] NULL,
 CONSTRAINT [PK_Producttbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 15/01/2024 09:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[SalesId] [uniqueidentifier] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[SalesPrice] [float] NOT NULL,
	[SalesDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[SalesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (1, N'Jai', N'7004403099')
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (2, N'aaaaa', N'5656756756')
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (6, N'jjjjjjjjjjjjj', N'5656565657')
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (7, N'jjjjjjjjjjjjj', N'5656565657')
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (8, N'kkkkkkkkkk', N'fsdfdg')
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (9, N'Customer1', N'8789667788')
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (10, N'Tst Custome1', N'8789007788')
GO
INSERT [dbo].[Customer] ([Id], [CustomerName], [PhoneNumber]) VALUES (11, N'Tst Custome1', N'8789007788')
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [Discount]) VALUES (2, N'string', N'string', 12.22, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [Discount]) VALUES (3, N'Sri Ram', N'Hanuman', 122.33, 55)
GO
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [Discount]) VALUES (4, N'fgfhfg', N'gnhjnhjgh', 200, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [Discount]) VALUES (5, N'ddd', N'qqq', 22, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [Discount]) VALUES (6, N'abhi', N'banar', 100, 100)
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[Sales] ([SalesId], [CustomerId], [ProductId], [SalesPrice], [SalesDate]) VALUES (N'3fa85f64-5717-4562-b3fc-2c963f66afa6', 1, 3, 50, CAST(N'2024-01-13T18:22:15.607' AS DateTime))
GO
INSERT [dbo].[Sales] ([SalesId], [CustomerId], [ProductId], [SalesPrice], [SalesDate]) VALUES (N'3fa85f64-5717-4562-b5fc-2c963f66afa6', 1, 3, 87, CAST(N'2024-01-13T18:26:16.957' AS DateTime))
GO
INSERT [dbo].[Sales] ([SalesId], [CustomerId], [ProductId], [SalesPrice], [SalesDate]) VALUES (N'3fa85f64-5717-4562-b6fc-2c963f66afa6', 2, 2, 20, CAST(N'2024-01-13T18:27:29.247' AS DateTime))
GO
INSERT [dbo].[Sales] ([SalesId], [CustomerId], [ProductId], [SalesPrice], [SalesDate]) VALUES (N'16625e50-63ac-4fe6-b386-95a360212f35', 1, 3, 122.33, CAST(N'2024-01-14T15:41:07.670' AS DateTime))
GO
INSERT [dbo].[Sales] ([SalesId], [CustomerId], [ProductId], [SalesPrice], [SalesDate]) VALUES (N'bab19852-f6f8-49f3-b431-f28b7d7b5483', 1, 6, 100, CAST(N'2024-01-14T15:38:42.717' AS DateTime))
GO
USE [master]
GO
ALTER DATABASE [METEOROS_AssignmentDB] SET  READ_WRITE 
GO
