USE [master]
GO
/****** Object:  Database [HRDatabase]    Script Date: 5/11/2024 3:14:40 AM ******/
CREATE DATABASE [HRDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HRDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HRDatabase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HRDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HRDatabase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HRDatabase] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HRDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HRDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HRDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HRDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HRDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HRDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [HRDatabase] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [HRDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HRDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HRDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HRDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HRDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HRDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HRDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HRDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HRDatabase] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HRDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HRDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HRDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HRDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HRDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HRDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HRDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HRDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HRDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [HRDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HRDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HRDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HRDatabase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HRDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HRDatabase] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HRDatabase] SET QUERY_STORE = ON
GO
ALTER DATABASE [HRDatabase] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HRDatabase]
GO
/****** Object:  User [HRDBUser]    Script Date: 5/11/2024 3:14:40 AM ******/
CREATE USER [HRDBUser] FOR LOGIN [HRDBLogin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [HRDBUser]
GO
/****** Object:  Table [dbo].[Authentication]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authentication](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](80) NOT NULL,
	[CompAddress] [varchar](80) NOT NULL,
	[CompContactNo] [varchar](20) NOT NULL,
	[IsActive] [bit] NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](80) NOT NULL,
	[ContactNo] [varchar](20) NOT NULL,
	[Email] [varchar](80) NOT NULL,
	[CompID] [int] NULL,
	[AddressID] [int] NULL,
	[TitleID] [int] NULL,
	[GenderID] [int] NULL,
	[IsActive] [bit] NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Authentication] ([Username], [Password], [Email], [Role]) VALUES (N'admin', N'root', N'admin@gmail.com', N'Admin')
INSERT [dbo].[Authentication] ([Username], [Password], [Email], [Role]) VALUES (N'farid', N'5115', N'farid7j@gmail.com', N'Head HR Manager')
INSERT [dbo].[Authentication] ([Username], [Password], [Email], [Role]) VALUES (N'jia', N'qian0327', N'jiaqian@gmail.com', N'Head HR Manager')
INSERT [dbo].[Authentication] ([Username], [Password], [Email], [Role]) VALUES (N'jimmy', N'nawan', N'nawan@gmail.com', N'Branch Manager')
INSERT [dbo].[Authentication] ([Username], [Password], [Email], [Role]) VALUES (N'symaa', N'syameer', N'syma02@gmail.com', N'Branch Manager')
GO
SET IDENTITY_INSERT [dbo].[Companies] ON 

INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (1, N'Elit Pharetra Ut LLP', N'576-5379 Eu St., Gwadar, 6269 UM', N'(582) 593-5311', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (2, N'Eu Ligula Aenean Incorporated', N'Ap #434-4279 Adipiscing, Rd., Murdochville, 68727-245', N'(462) 465-8259', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (3, N'Odio Nam PC', N'Ap #672-2415 Mauris Av., Puntarenas, 216678', N'(104) 263-3671', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (4, N'Luctus Et Inc.', N'Ap #540-6232 Leo. Road, Ratlam, 557662', N'1-408-566-8546', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (5, N'Ipsum Leo Incorporated', N'Ap #838-9516 Ut Street, Guarapuava, 545721', N'1-800-772-9022', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (6, N'Donec Dignissim Magna Company', N'Ap #679-3154 Sapien. St., Nova Kakhovka, 7845', N'(348) 984-4306', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (7, N'Turpis In Condimentum LLC', N'Ap #795-1817 Vitae, St., Stargard Szczecinski, 431748', N'1-478-294-8631', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (8, N'Mauris Aliquam Eu Incorporated', N'946-6131 Magna, Avenue, Hospet, 45062', N'(860) 335-3458', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (9, N'Ac Consulting', N'168-8242 Massa. Av., Harstad, 88-37', N'(984) 737-1838', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
INSERT [dbo].[Companies] ([id], [CompanyName], [CompAddress], [CompContactNo], [IsActive], [CreateDate]) VALUES (10, N'Justo Proin Non Corporation', N'P.O. Box 394, 1843 Fusce Street, Christchurch, 58836', N'1-513-215-1519', 1, CAST(N'2024-05-07T00:24:46.583' AS DateTime))
SET IDENTITY_INSERT [dbo].[Companies] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (1, N'Brendan Hewitt', N'1-338-325-7289', N'et.pede@protonmail.ca', 5, 1, 1, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (2, N'Bethany Joseph', N'(449) 751-1256', N'gravida.mauris@icloud.edu', 10, 2, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (3, N'Hadley Coleman', N'(562) 813-8455', N'euismod@icloud.com', 5, 5, 3, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (4, N'Darryl Dominguez', N'1-172-884-1864', N'nam.nulla.magna@protonmail.couk', 7, 4, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (5, N'Brock Dickerson', N'1-788-654-4950', N'mattis.velit.justo@google.org', 3, 3, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (6, N'George Kramer', N'1-366-279-8756', N'proin@hotmail.com', 2, 1, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (7, N'Zeph Doyle', N'(587) 403-0422', N'cras.eget.nisi@google.edu', 4, 1, 1, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (8, N'Gabriel Graham', N'(245) 566-2219', N'fusce.aliquam.enim@yahoo.ca', 8, 2, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (9, N'Arden Graves', N'(976) 914-7081', N'phasellus@aol.edu', 5, 2, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (10, N'Veronica Charles', N'1-897-642-6386', N'vel@icloud.com', 6, 3, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (11, N'Amy Steele', N'(564) 838-1446', N'sed.nulla@google.couk', 8, 2, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (12, N'Hashim Howe', N'(581) 251-0163', N'nisl@aol.couk', 2, 1, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (13, N'Kevin Ortega', N'(725) 555-3112', N'arcu.ac@google.ca', 2, 5, 1, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (14, N'Cassidy Harrington', N'(362) 736-5531', N'a.auctor@outlook.org', 2, 5, 1, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (15, N'Allen Burt', N'(488) 803-2938', N'fusce.aliquet@aol.net', 3, 4, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (16, N'Timon Pittman', N'(814) 548-6153', N'ornare.in@yahoo.org', 6, 2, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (17, N'Boris Johnston', N'(316) 238-1536', N'diam.duis@icloud.ca', 1, 2, 3, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (18, N'Cody Armstrong', N'1-715-426-2236', N'eu.tellus@hotmail.couk', 5, 3, 3, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (19, N'Melvin Rollins', N'(174) 765-6692', N'luctus@outlook.couk', 5, 4, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (20, N'Kimberley Franco', N'(857) 790-8431', N'sociis.natoque@google.org', 1, 4, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (21, N'Ebony Lynch', N'(251) 422-4617', N'sociis@aol.net', 9, 5, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (22, N'Ruth Kennedy', N'1-864-614-9383', N'tempus.non@hotmail.com', 8, 4, 3, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (23, N'Naomi Estrada', N'(710) 773-5770', N'curabitur.dictum.phasellus@protonmail.org', 8, 5, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (24, N'Carter Collins', N'(895) 986-5031', N'ornare.sagittis.felis@outlook.ca', 9, 2, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (25, N'Deirdre Marshall', N'1-122-878-6037', N'sem@outlook.ca', 3, 2, 1, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (26, N'Kuame Fisher', N'(676) 284-7739', N'urna.nunc@hotmail.net', 4, 3, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (27, N'Amos Roberson', N'1-438-982-8576', N'erat.volutpat@protonmail.couk', 2, 3, 1, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (28, N'Lunea Holcomb', N'(458) 256-6612', N'enim.consequat.purus@icloud.couk', 6, 4, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (29, N'Tana Collins', N'1-671-785-2811', N'aliquet@google.ca', 1, 5, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (30, N'Hyatt Kent', N'(276) 632-3793', N'aenean.eget.metus@outlook.edu', 10, 5, 3, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (31, N'Steel Workman', N'(340) 289-9467', N'enim.gravida.sit@protonmail.couk', 4, 4, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (32, N'Beau Reid', N'1-877-841-9224', N'sit.amet.orci@outlook.org', 3, 2, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (33, N'Kay Cote', N'(120) 363-5564', N'orci.luctus@outlook.couk', 1, 3, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (34, N'Cassidy Rollins', N'(364) 215-2577', N'molestie.arcu.sed@hotmail.net', 1, 3, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (35, N'Victor Wilson', N'(911) 265-6452', N'sapien.aenean.massa@google.couk', 7, 2, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (36, N'Quentin Avila', N'(234) 663-6124', N'metus@protonmail.org', 9, 5, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (37, N'Duncan Shaffer', N'(526) 467-3246', N'faucibus.orci@outlook.couk', 6, 4, 1, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (38, N'Cole Wong', N'1-367-551-2113', N'nec@protonmail.net', 9, 3, 1, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (39, N'Jane Donaldson', N'1-766-358-7463', N'nisi.mauris@hotmail.com', 2, 4, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (40, N'Rose Wiley', N'(556) 526-2245', N'lorem@google.edu', 6, 5, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (41, N'Belle Flowers', N'(709) 725-8764', N'duis.at.lacus@aol.edu', 7, 5, 3, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (42, N'Sonya Peters', N'(235) 519-1685', N'vel.venenatis@hotmail.org', 2, 4, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (43, N'Felicia Mcguire', N'1-286-924-2782', N'ac.tellus.suspendisse@outlook.net', 6, 3, 1, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (44, N'Fletcher Franks', N'1-228-839-1992', N'a.neque@protonmail.ca', 2, 2, 1, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (45, N'Ora Holt', N'(845) 359-1513', N'lectus.ante@google.edu', 2, 2, 2, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (46, N'Quyn Fuentes', N'1-313-848-8659', N'eu.placerat@protonmail.org', 1, 3, 3, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (47, N'Lilah Mcintosh', N'(497) 371-6569', N'ac.facilisis.facilisis@icloud.edu', 6, 4, 2, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (48, N'Harrison Patterson', N'1-950-861-1181', N'lacinia@outlook.net', 3, 5, 3, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (49, N'Gloria Mays', N'1-346-451-6267', N'lorem@hotmail.org', 6, 2, 1, 2, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
INSERT [dbo].[Employees] ([id], [EmployeeName], [ContactNo], [Email], [CompID], [AddressID], [TitleID], [GenderID], [IsActive], [CreateDate]) VALUES (50, N'Anika David', N'1-567-170-7856', N'odio.phasellus@google.edu', 3, 1, 1, 1, 1, CAST(N'2024-05-07T00:24:46.597' AS DateTime))
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF_IsActive_Companies]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF__Companies__Creat__38996AB5]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_IsActive_Employees]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Companies] FOREIGN KEY([CompID])
REFERENCES [dbo].[Companies] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Companies]
GO
/****** Object:  StoredProcedure [dbo].[usp_DelAuthentication]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* To run the Stored Procedure you would execute the following:
EXEC dbo.usp_DelAuthentication @Username = 'existing_username';
*/

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_UpdAuthentication
	@Username	= 'farid',
	@Password	= 'Password',
	@Email	    = 'farid7j@gmail.com',
	@Role       = 'Admin',

select * from dbo.Authentication;
go
*/

----------------------------------------------------------------------------
-- Stored Procedure to Delete a single Authentication record based on its Username
CREATE PROCEDURE [dbo].[usp_DelAuthentication]
    @Username varchar(50)
AS
BEGIN
    DELETE FROM dbo.Authentication
    WHERE Username = @Username
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_DelCompany]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_UpdCompany
	@ID				= 6,
	@CompanyName	= 'Zulu-Yanke Company',
	@CompAddress	= null,
	@CompContactNo	= '(777) 852 7401'

select * from dbo.Companies;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to Delete a single Company based on its ID

CREATE   PROCEDURE [dbo].[usp_DelCompany]
	@ID		int
AS
BEGIN
	DELETE	FROM dbo.Companies
	WHERE	ID = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_DelEmployee]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_UpdEmployee
	@ID				= 6,
	@EmployeeName	= null,
	@ContactNo		= '(777) 852 7401',
	@Email			= 'kj@gmail.com',
	@CompID			= 2

SELECT * FROM dbo.Employees;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to Delete a single Employee based on its ID
CREATE   PROCEDURE [dbo].[usp_DelEmployee]
	@ID		int
AS
BEGIN
	DELETE	FROM [dbo].[Employees]
	WHERE	ID = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAuthentication]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Stored Procedure to return a single Authentication record based on a Username
CREATE PROCEDURE [dbo].[usp_GetAuthentication]
    @Username varchar(50)
AS
BEGIN
    SELECT [Username], [Password], [Email], [Role]
    FROM [dbo].[Authentication]
    WHERE [Username] = @Username
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAuthentications]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Stored Procedure to return a list of all the authentications
CREATE PROCEDURE [dbo].[usp_GetAuthentications]
AS
BEGIN
    SELECT [Username], [Password], [Email], [Role]
    FROM [dbo].[Authentication]
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCompanies]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************
	Create Stored Procedures for Companies table
*/
----------------------------------------------------------------------------
--	Stored Procedure to return a list of all the companies
CREATE   PROCEDURE [dbo].[usp_GetCompanies]
AS
BEGIN
	SELECT	ID
			,CompanyName
			,CompAddress
			,CompContactNo
			,CreateDate
	FROM	dbo.Companies
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCompany]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_GetCompanies;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to return a single Company based on an ID

CREATE   PROCEDURE [dbo].[usp_GetCompany]
	@ID		int
AS
BEGIN
	SELECT	ID
			,CompanyName
			,CompAddress
			,CompContactNo
			,CreateDate
	FROM	dbo.Companies
	WHERE	ID = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmployee]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_GetEmployees;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to return a single Employee based on an ID
CREATE   PROCEDURE [dbo].[usp_GetEmployee]
	@ID		int
AS
BEGIN
	SELECT	[ID]
			,[EmployeeName]
			,[ContactNo]
			,[Email]
			,[CompID]
			,[CreateDate]
	FROM	[dbo].[Employees]
	WHERE	ID = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmployees]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_DelCompany
	@ID = 3;
go

select * from dbo.Companies;
go
*/

/**************************************************************************************
	Create Stored Procedures for Employees table
*/
----------------------------------------------------------------------------
--	Stored Procedure to return a list of all the employees
CREATE   PROCEDURE [dbo].[usp_GetEmployees]
AS
BEGIN
	SELECT	e.[ID]
			,e.[EmployeeName]
			,e.[ContactNo]
			,e.[Email]
			,e.[CompID]
			,e.[CreateDate]
			,c.[CompanyName]
	FROM	[dbo].[Employees] e
	LEFT JOIN [dbo].[Companies] c on c.ID = e.CompID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_InsAuthentication]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* To run the Stored Procedure you would execute the following:
EXEC dbo.usp_InsAuthentication 
    @Username = 'username',
    @Password = 'password',
    @Email = 'email@example.com',
	@Role = 'Admin';
*/

----------------------------------------------------------------------------
-- Stored Procedure to Insert a single record into the Authentication table
CREATE PROCEDURE [dbo].[usp_InsAuthentication]
    @Username varchar(50),
    @Password varchar(50),
    @Email varchar(255),
	@Role varchar(50)
AS
BEGIN
    INSERT INTO [dbo].[Authentication]
        ([Username], [Password], [Email], [Role])
    VALUES
        (@Username, @Password, @Email, @Role);
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_InsCompany]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_GetCompany @ID = 4;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to Insert a single Company

CREATE   PROCEDURE [dbo].[usp_InsCompany]
	@CompanyName	varchar(80),
	@CompAddress	varchar(80),
	@CompContactNo	varchar(20)
AS
BEGIN
	INSERT INTO dbo.Companies
			   (CompanyName
			   ,CompAddress
			   ,CompContactNo
			   ,CreateDate)
		 VALUES
			   (@CompanyName
			   ,@CompAddress
			   ,@CompContactNo
			   ,getdate())
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_InsEmployee]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_GetEmployee @ID = 4;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to Insert a single Employee
CREATE   PROCEDURE [dbo].[usp_InsEmployee]
	@EmployeeName	varchar(80),
	@ContactNo		varchar(80),
	@Email			varchar(20),
	@CompID			int
AS
BEGIN
	INSERT INTO [dbo].[Employees]
				([EmployeeName]
				,[ContactNo]
				,[Email]
				,[CompID])
		 VALUES
				(@EmployeeName
				,@ContactNo
				,@Email
				,@CompID)
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdAuthentication]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* To run the Stored Procedure you would execute the following:
EXEC dbo.usp_UpdAuthentication 
    @Username = 'existing_username',
    @Password = 'new_password',
    @Email = 'new_email@example.com',
	@Role = 'Admin';
*/

----------------------------------------------------------------------------
-- Stored Procedure to Update a single record in the Authentication table
CREATE PROCEDURE [dbo].[usp_UpdAuthentication]
    @Username varchar(50),
    @Password varchar(50) = null,
    @Email varchar(255) = null,
	@Role varchar(50) = null
AS
BEGIN
    UPDATE [dbo].[Authentication]
    SET
        [Password] = ISNULL(@Password, [Password]),
        [Email] = ISNULL(@Email, [Email]),
		[Role] = ISNULL(@Role, [Role])
    WHERE
        [Username] = @Username;
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdCompany]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_InsCompany
	@CompanyName	= 'Zulu-Yankee Company',
	@CompAddress	= '123 Some street, Somewhere Far away, Europe ext 10',
	@CompContactNo	= '(999) 852 7401';
go

SELECT * FROM dbo.Companies;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to Update a single Company

CREATE   PROCEDURE [dbo].[usp_UpdCompany]
	@ID				int			= null,
	@CompanyName	varchar(80)	= null,
	@CompAddress	varchar(80) = null,
	@CompContactNo	varchar(20) = null
AS
BEGIN
	UPDATE	dbo.Companies
	SET		CompanyName			= ISNULL(@CompanyName	, CompanyName	)
			,CompAddress		= ISNULL(@CompAddress	, CompAddress	)
			,CompContactNo		= ISNULL(@CompContactNo	, CompContactNo	)
	WHERE	ID = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdEmployee]    Script Date: 5/11/2024 3:14:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC [dbo].[usp_InsEmployee]
	@EmployeeName	= 'James Brown',
	@ContactNo		= '(999) 852 7401',
	@Email			= 'jamesbrown@gmail.com',
	@CompID			= 1;
go

SELECT * FROM dbo.Employees;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to Update a single Employee
CREATE   PROCEDURE [dbo].[usp_UpdEmployee]
	@ID				int			= null,
	@EmployeeName	varchar(80)	= null,
	@ContactNo		varchar(80) = null,
	@Email			varchar(20) = null,
	@CompID			int = null
AS
BEGIN
	UPDATE	[dbo].[Employees]
	SET		EmployeeName		= ISNULL(@EmployeeName	, EmployeeName	)
			,ContactNo			= ISNULL(@ContactNo		, ContactNo		)
			,Email				= ISNULL(@Email			, Email			)
			,CompID				= ISNULL(@CompID		, CompID		)
	WHERE	ID = @ID
END;
GO
USE [master]
GO
ALTER DATABASE [HRDatabase] SET  READ_WRITE 
GO
