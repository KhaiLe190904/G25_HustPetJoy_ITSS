USE [master]
GO
/****** Object:  Database [hust_pet_joy]    Script Date: 14/06/2025 1:23:10 AM ******/
CREATE DATABASE [hust_pet_joy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'hust_pet_joy', FILENAME = N'/var/opt/mssql/data/hust_pet_joy.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'hust_pet_joy_log', FILENAME = N'/var/opt/mssql/data/hust_pet_joy_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [hust_pet_joy] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [hust_pet_joy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [hust_pet_joy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [hust_pet_joy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [hust_pet_joy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [hust_pet_joy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [hust_pet_joy] SET ARITHABORT OFF 
GO
ALTER DATABASE [hust_pet_joy] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [hust_pet_joy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [hust_pet_joy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [hust_pet_joy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [hust_pet_joy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [hust_pet_joy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [hust_pet_joy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [hust_pet_joy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [hust_pet_joy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [hust_pet_joy] SET  ENABLE_BROKER 
GO
ALTER DATABASE [hust_pet_joy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [hust_pet_joy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [hust_pet_joy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [hust_pet_joy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [hust_pet_joy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [hust_pet_joy] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [hust_pet_joy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [hust_pet_joy] SET RECOVERY FULL 
GO
ALTER DATABASE [hust_pet_joy] SET  MULTI_USER 
GO
ALTER DATABASE [hust_pet_joy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [hust_pet_joy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [hust_pet_joy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [hust_pet_joy] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [hust_pet_joy] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [hust_pet_joy] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'hust_pet_joy', N'ON'
GO
ALTER DATABASE [hust_pet_joy] SET QUERY_STORE = OFF
GO
USE [hust_pet_joy]
GO
/****** Object:  Table [dbo].[appointments]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[appointments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pet_id] [int] NULL,
	[appointment_time] [time](7) NULL,
	[notes] [nvarchar](255) NULL,
	[cancelled] [bit] NOT NULL,
	[is_completed] [bit] NOT NULL,
	[appointment_date] [datetime2](6) NULL,
	[is_paid] [bit] NULL,
	[service] [varchar](255) NULL,
	[follow_up_date] [datetime2](6) NULL,
	[follow_up_notification] [nvarchar](255) NULL,
	[note_notification] [nvarchar](255) NULL,
 CONSTRAINT [PK__appointm__3213E83FD35D817B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bills]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bills](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[treatment_id] [int] NULL,
	[total_amount] [float] NULL,
	[date] [datetime2](6) NULL,
	[room_id] [int] NULL,
	[spa_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](255) NULL,
	[dob] [datetime2](6) NULL,
	[phone] [varchar](255) NULL,
	[sex] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[password] [varchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[image] [varchar](255) NULL,
 CONSTRAINT [PK__customer__3213E83F8DC1E00E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[manager_role]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[manager_role](
	[manager_id] [int] NULL,
	[role_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[managers]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[managers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[password] [varchar](255) NULL,
	[position] [varchar](255) NULL,
	[phone] [nvarchar](15) NULL,
	[email] [varchar](255) NULL,
	[status] [int] NULL,
	[is_working] [int] NULL,
	[fees] [varchar](255) NULL,
	[img_url] [varchar](255) NULL,
	[name] [varchar](255) NULL,
	[speciality] [varchar](255) NULL,
	[about] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[medicines]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[medicines](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](255) NULL,
	[medicine_name] [varchar](255) NULL,
	[price] [float] NULL,
	[days] [int] NULL,
	[total_price]  AS ([price]*[days]),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pet_room]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pet_room](
	[pet_room_id] [int] IDENTITY(1,1) NOT NULL,
	[pet_id] [int] NOT NULL,
	[room_id] [int] NOT NULL,
	[is_available] [bit] NULL,
	[time_in] [datetime] NULL,
	[time_out] [datetime] NULL,
	[notes] [nchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[pet_room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pets]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[name] [nvarchar](255) NULL,
	[weight] [float] NULL,
	[species] [varchar](255) NULL,
	[health] [varchar](255) NULL,
	[notes] [nvarchar](255) NULL,
	[image] [varchar](255) NULL,
 CONSTRAINT [PK__pets__3213E83FA1AE28D8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prescription_medicine]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prescription_medicine](
	[prescription_id] [int] NOT NULL,
	[medicine_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[prescription_id] ASC,
	[medicine_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prescriptions]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prescriptions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[total_price_prescription] [float] NULL,
	[treatment_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rooms]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rooms](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[room_name] [varchar](255) NULL,
	[total_price] [float] NULL,
	[description] [nvarchar](255) NULL,
	[image] [varchar](255) NULL,
 CONSTRAINT [PK__rooms__3213E83F967DA296] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[spa]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[spa](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[appointment_id] [int] NOT NULL,
	[pet_id] [int] NOT NULL,
	[manager_id] [int] NOT NULL,
	[fees] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[treatments]    Script Date: 14/06/2025 1:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[treatments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pet_id] [int] NULL,
	[manager_id] [int] NULL,
	[fees] [float] NULL,
	[notes] [varchar](255) NULL,
	[appointment_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[appointments] ON 

INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (1, 1, CAST(N'12:00:00' AS Time), N'1', 0, 1, CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (2, 1, CAST(N'09:30:00' AS Time), NULL, 0, 1, CAST(N'2025-05-07T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (3, 1, CAST(N'09:30:00' AS Time), NULL, 1, 0, CAST(N'2025-05-07T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (4, 1, CAST(N'10:00:00' AS Time), NULL, 1, 0, CAST(N'2025-05-09T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (5, 1, CAST(N'10:30:00' AS Time), NULL, 1, 0, CAST(N'2025-05-10T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (6, 1, CAST(N'10:30:00' AS Time), NULL, 1, 0, CAST(N'2025-05-08T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (7, 2, CAST(N'10:00:00' AS Time), NULL, 1, 0, CAST(N'2025-05-10T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (8, 2, CAST(N'11:00:00' AS Time), NULL, 1, 0, CAST(N'2025-05-11T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (9, 2, CAST(N'11:00:00' AS Time), NULL, 1, 0, CAST(N'2025-05-12T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (10, 2, CAST(N'09:30:00' AS Time), NULL, 0, 1, CAST(N'2025-05-10T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (11, 2, CAST(N'10:30:00' AS Time), NULL, 0, 1, CAST(N'2025-05-12T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (12, 1, CAST(N'11:00:00' AS Time), NULL, 0, 1, CAST(N'2025-05-07T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (13, 1, CAST(N'10:30:00' AS Time), NULL, 0, 1, CAST(N'2025-05-07T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (14, 1, CAST(N'10:00:00' AS Time), NULL, 1, 0, CAST(N'2025-05-10T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (15, 1, CAST(N'10:00:00' AS Time), NULL, 0, 1, CAST(N'2025-05-09T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (16, 1, CAST(N'10:30:00' AS Time), N'bị ngu quá nên không chữa được
', 0, 1, CAST(N'2025-05-11T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (17, 1, CAST(N'10:30:00' AS Time), NULL, 0, 0, CAST(N'2025-05-11T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (18, 2, CAST(N'11:30:00' AS Time), NULL, 0, 1, CAST(N'2025-05-13T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (19, 1, CAST(N'10:30:00' AS Time), NULL, 1, 0, CAST(N'2025-06-12T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (20, 2, CAST(N'10:30:00' AS Time), NULL, 1, 0, CAST(N'2025-06-15T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (21, 3, CAST(N'11:30:00' AS Time), N'Cn', 0, 0, CAST(N'2025-06-16T00:00:00.0000000' AS DateTime2), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[appointments] ([id], [pet_id], [appointment_time], [notes], [cancelled], [is_completed], [appointment_date], [is_paid], [service], [follow_up_date], [follow_up_notification], [note_notification]) VALUES (22, 1, CAST(N'11:00:00' AS Time), N'ngu quá không chữa được
', 0, 0, CAST(N'2025-06-18T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, N'Bác sĩ đã chẩn đoán tình trạng sức khỏe cho thú cưng của bạn của lịch khám ngày 2025-06-18 00:00:00.0, nhấn vào để xem')
SET IDENTITY_INSERT [dbo].[appointments] OFF
GO
SET IDENTITY_INSERT [dbo].[customers] ON 

INSERT [dbo].[customers] ([id], [full_name], [dob], [phone], [sex], [email], [password], [address], [image]) VALUES (1, N'Khải', CAST(N'2004-09-18T00:00:00.0000000' AS DateTime2), N'0866486109', N'nam', N'khai@gmail.com', N'khai', N'Dien Bien', N'https://dcmoop.s3.us-east-1.amazonaws.com/1734942768166_z5930426319579_9d9b5acff35180f90dfd0ec5d1d6ef6e.jpg')
SET IDENTITY_INSERT [dbo].[customers] OFF
GO
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (1, 1)
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (2, 2)
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (3, 3)
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (4, 3)
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (5, 2)
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (6, 2)
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (7, 2)
INSERT [dbo].[manager_role] ([manager_id], [role_id]) VALUES (8, 2)
GO
SET IDENTITY_INSERT [dbo].[managers] ON 

INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (1, N'admin', N'admin', N'012345', N'admin@gmail.com', 1, 1, N'100', N'https://dcmoop.s3.us-east-1.amazonaws.com/1734938422262_doc1.png', N'admin', N'admin', N'admin')
INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (2, N'quang', N'Manager', NULL, N'quang@gmail.com', 1, 1, N'100', N'https://dcmoop.s3.us-east-1.amazonaws.com/1744909266091_doc7.png', N'Bac si Quang ', N'treatment', N'Toi bi ngu')
INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (3, N'minh', N'Employee', NULL, N'minh@gmail.com', 1, 1, N'10', N'https://dcmoop.s3.us-east-1.amazonaws.com/1744910452811_minh.png', N'Minh', N'spa', N'Tao bi gay')
INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (4, N'dong', N'Employee', NULL, N'dong@gmail.com', 1, 1, N'10', N'https://dcmoop.s3.us-east-1.amazonaws.com/1744910651382_doc14.png', N'Nhan vien Dong', N'spa', N'Tao bi gau gau')
INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (5, N'huy', N'Doctor', NULL, N'huy@gmail.com', 1, 1, N'1000', N'https://dcmoop.s3.us-east-1.amazonaws.com/1746612491923_doc4.png', N'Bac si Huy', N'treatment', N'tao la Huy
')
INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (6, N'tuan', N'Doctor', NULL, N'tuan@gmail.com', 1, 1, N'1000', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749406538358_doctorTuan.png', N'Bac si Tuan', N'treatment', N'null')
INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (7, N'hau', N'Doctor', NULL, N'hau@gmail.com', 1, 1, N'100', N'https://dcmoop.s3.us-east-1.amazonaws.com/1734938852979_doctorHau.png', N'Bac si Hau', N'treatment', N'Hau')
INSERT [dbo].[managers] ([id], [password], [position], [phone], [email], [status], [is_working], [fees], [img_url], [name], [speciality], [about]) VALUES (8, N'an', N'Doctor', NULL, N'an@gmail.com', 1, 1, N'10000', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749838373573_doc10.png', N'Bac si An', N'treatment', N'Null')
SET IDENTITY_INSERT [dbo].[managers] OFF
GO
SET IDENTITY_INSERT [dbo].[medicines] ON 

INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (1, N'Antibiotic', N'Amoxicillin (Vet)', 10, 7)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (2, N'Antibiotic', N'Cefpodoxime', 12.5, 7)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (3, N'Antibiotic', N'Clindamycin', 15, 7)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (4, N'Antibiotic', N'Doxycycline', 8, 7)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (5, N'Painkiller', N'Carprofen', 20, 5)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (6, N'Painkiller', N'Meloxicam', 18, 5)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (7, N'Painkiller', N'Firocoxib', 22, 5)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (8, N'Painkiller', N'Tramadol', 25, 5)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (9, N'Vitamin', N'Vitamin B Complex', 5, 10)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (10, N'Vitamin', N'Vitamin E', 6, 10)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (11, N'Vitamin', N'Vitamin C (Vet)', 4.5, 10)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (12, N'Vitamin', N'Multivitamin for Pets', 7, 10)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (13, N'Dewormer', N'Fenbendazole', 15, 3)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (14, N'Dewormer', N'Praziquantel', 18, 3)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (15, N'Dewormer', N'Pyrantel Pamoate', 12, 3)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (16, N'Dewormer', N'Ivermectin', 20, 3)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (17, N'Other', N'Probiotic for Pets', 10, 14)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (18, N'Other', N'Antihistamine (Vet)', 8, 7)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (19, N'Other', N'Cough Suppressant', 12, 7)
INSERT [dbo].[medicines] ([id], [type], [medicine_name], [price], [days]) VALUES (20, N'Other', N'Antacid (Vet)', 6, 7)
SET IDENTITY_INSERT [dbo].[medicines] OFF
GO
SET IDENTITY_INSERT [dbo].[pets] ON 

INSERT [dbo].[pets] ([id], [customer_id], [name], [weight], [species], [health], [notes], [image]) VALUES (1, 1, N'Neko Hiểu', 36, N'Chó', N'Excellent', N'thích ăn cá', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749744367669_Cho-hieu.png')
INSERT [dbo].[pets] ([id], [customer_id], [name], [weight], [species], [health], [notes], [image]) VALUES (2, 1, N'Inu', 5, N'mèo', N'Excellent', N'', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749744500160_meo-con-01.jpg')
INSERT [dbo].[pets] ([id], [customer_id], [name], [weight], [species], [health], [notes], [image]) VALUES (3, 1, N'Mèo ', 5, N'Mèo', N'Excellent', N'thích ăn rau', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749837454839_meo-ollie.jpg')
SET IDENTITY_INSERT [dbo].[pets] OFF
GO
INSERT [dbo].[prescription_medicine] ([prescription_id], [medicine_id]) VALUES (2, 1)
INSERT [dbo].[prescription_medicine] ([prescription_id], [medicine_id]) VALUES (2, 5)
INSERT [dbo].[prescription_medicine] ([prescription_id], [medicine_id]) VALUES (2, 9)
INSERT [dbo].[prescription_medicine] ([prescription_id], [medicine_id]) VALUES (4, 1)
INSERT [dbo].[prescription_medicine] ([prescription_id], [medicine_id]) VALUES (4, 5)
INSERT [dbo].[prescription_medicine] ([prescription_id], [medicine_id]) VALUES (4, 6)
INSERT [dbo].[prescription_medicine] ([prescription_id], [medicine_id]) VALUES (5, 5)
GO
SET IDENTITY_INSERT [dbo].[prescriptions] ON 

INSERT [dbo].[prescriptions] ([id], [total_price_prescription], [treatment_id]) VALUES (2, 220, 12)
INSERT [dbo].[prescriptions] ([id], [total_price_prescription], [treatment_id]) VALUES (4, 260, 14)
INSERT [dbo].[prescriptions] ([id], [total_price_prescription], [treatment_id]) VALUES (5, 100, 15)
SET IDENTITY_INSERT [dbo].[prescriptions] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [role_name]) VALUES (1, N'ROLE_ADMIN')
INSERT [dbo].[roles] ([id], [role_name]) VALUES (2, N'ROLE_DOCTOR')
INSERT [dbo].[roles] ([id], [role_name]) VALUES (3, N'ROLE_EMPLOYEE')
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[rooms] ON 

INSERT [dbo].[rooms] ([id], [room_name], [total_price], [description], [image]) VALUES (1, N'1', 100, N'Phòng siêu cấp vip vũ trụ', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749740509597_4ac16b6b58b0415e9be73e4b9c436be7.png')
INSERT [dbo].[rooms] ([id], [room_name], [total_price], [description], [image]) VALUES (2, N'2', 100, N'Phòng siêu cấp vip vũ trụ', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749740509597_4ac16b6b58b0415e9be73e4b9c436be7.png')
INSERT [dbo].[rooms] ([id], [room_name], [total_price], [description], [image]) VALUES (3, N'3', 100, N'Phòng siêu cấp vip vũ trụ', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749740509597_4ac16b6b58b0415e9be73e4b9c436be7.png')
INSERT [dbo].[rooms] ([id], [room_name], [total_price], [description], [image]) VALUES (4, N'4', 100, N'Phòng siêu cấp vip vũ trụ nhưng phèn hơn tý', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749740509597_4ac16b6b58b0415e9be73e4b9c436be7.png')
INSERT [dbo].[rooms] ([id], [room_name], [total_price], [description], [image]) VALUES (5, N'5', 100, N'Phòng siêu cấp vip vũ trụ nhưng phèn hơn tý', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749740509597_4ac16b6b58b0415e9be73e4b9c436be7.png')
INSERT [dbo].[rooms] ([id], [room_name], [total_price], [description], [image]) VALUES (6, N'6', 100, N'Phòng siêu cấp vip vũ trụ nhưng phèn hơn tý', N'https://dcmoop.s3.us-east-1.amazonaws.com/1749740509597_4ac16b6b58b0415e9be73e4b9c436be7.png')
SET IDENTITY_INSERT [dbo].[rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[spa] ON 

INSERT [dbo].[spa] ([id], [appointment_id], [pet_id], [manager_id], [fees]) VALUES (1, 18, 2, 3, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[spa] ([id], [appointment_id], [pet_id], [manager_id], [fees]) VALUES (2, 12, 1, 3, CAST(110.00 AS Decimal(10, 2)))
INSERT [dbo].[spa] ([id], [appointment_id], [pet_id], [manager_id], [fees]) VALUES (3, 14, 1, 3, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[spa] ([id], [appointment_id], [pet_id], [manager_id], [fees]) VALUES (4, 13, 1, 3, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[spa] ([id], [appointment_id], [pet_id], [manager_id], [fees]) VALUES (5, 15, 1, 3, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[spa] ([id], [appointment_id], [pet_id], [manager_id], [fees]) VALUES (9, 17, 1, 4, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[spa] ([id], [appointment_id], [pet_id], [manager_id], [fees]) VALUES (10, 20, 2, 3, CAST(100.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[spa] OFF
GO
SET IDENTITY_INSERT [dbo].[treatments] ON 

INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (1, 1, 2, 100, N'ngu', 1)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (2, 1, 2, 100, NULL, 2)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (3, 1, 3, 100, NULL, 3)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (4, 1, 2, 100, NULL, 4)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (5, 1, 2, 100, NULL, 5)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (6, 1, 2, 100, NULL, 6)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (7, 2, 2, 100, NULL, 7)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (8, 2, 2, 100, NULL, 8)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (9, 2, 2, 100, NULL, 9)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (10, 2, 2, 100, NULL, 10)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (11, 2, 2, 100, NULL, 11)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (12, 2, 2, 100, NULL, 16)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (13, 1, 6, 100, NULL, 19)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (14, 3, 2, 100, NULL, 21)
INSERT [dbo].[treatments] ([id], [pet_id], [manager_id], [fees], [notes], [appointment_id]) VALUES (15, 1, 6, 100, NULL, 22)
SET IDENTITY_INSERT [dbo].[treatments] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__rooms__1B7D99CD6077EF0A]    Script Date: 14/06/2025 1:23:10 AM ******/
ALTER TABLE [dbo].[rooms] ADD  CONSTRAINT [UQ__rooms__1B7D99CD6077EF0A] UNIQUE NONCLUSTERED 
(
	[room_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[appointments] ADD  CONSTRAINT [DF__appointme__cance__3D5E1FD2]  DEFAULT ((0)) FOR [cancelled]
GO
ALTER TABLE [dbo].[appointments] ADD  CONSTRAINT [DF__appointme__is_co__3E52440B]  DEFAULT ((0)) FOR [is_completed]
GO
ALTER TABLE [dbo].[appointments] ADD  CONSTRAINT [DF_appointments_is_paid]  DEFAULT ((0)) FOR [is_paid]
GO
ALTER TABLE [dbo].[spa] ADD  DEFAULT ((100)) FOR [fees]
GO
ALTER TABLE [dbo].[appointments]  WITH CHECK ADD  CONSTRAINT [FK__appointme__pet_i__4222D4EF] FOREIGN KEY([pet_id])
REFERENCES [dbo].[pets] ([id])
GO
ALTER TABLE [dbo].[appointments] CHECK CONSTRAINT [FK__appointme__pet_i__4222D4EF]
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FK__bills__customer___4316F928] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([id])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FK__bills__customer___4316F928]
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD FOREIGN KEY([treatment_id])
REFERENCES [dbo].[treatments] ([id])
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FK_bills_rooms] FOREIGN KEY([room_id])
REFERENCES [dbo].[rooms] ([id])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FK_bills_rooms]
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FK_bills_spa] FOREIGN KEY([spa_id])
REFERENCES [dbo].[spa] ([id])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FK_bills_spa]
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FK40bnml17o1j948sgxj5ijavbg] FOREIGN KEY([room_id])
REFERENCES [dbo].[treatments] ([id])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FK40bnml17o1j948sgxj5ijavbg]
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FKex0i7j2ntyajr2m0u9lb8u2fk] FOREIGN KEY([spa_id])
REFERENCES [dbo].[treatments] ([id])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FKex0i7j2ntyajr2m0u9lb8u2fk]
GO
ALTER TABLE [dbo].[manager_role]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[managers] ([id])
GO
ALTER TABLE [dbo].[manager_role]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[pet_room]  WITH CHECK ADD  CONSTRAINT [FK__pet_room__pet_id__02FC7413] FOREIGN KEY([pet_id])
REFERENCES [dbo].[pets] ([id])
GO
ALTER TABLE [dbo].[pet_room] CHECK CONSTRAINT [FK__pet_room__pet_id__02FC7413]
GO
ALTER TABLE [dbo].[pet_room]  WITH CHECK ADD  CONSTRAINT [FK__pet_room__room_i__03F0984C] FOREIGN KEY([room_id])
REFERENCES [dbo].[rooms] ([id])
GO
ALTER TABLE [dbo].[pet_room] CHECK CONSTRAINT [FK__pet_room__room_i__03F0984C]
GO
ALTER TABLE [dbo].[pets]  WITH CHECK ADD  CONSTRAINT [FK__pets__customer_i__4CA06362] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([id])
GO
ALTER TABLE [dbo].[pets] CHECK CONSTRAINT [FK__pets__customer_i__4CA06362]
GO
ALTER TABLE [dbo].[prescription_medicine]  WITH CHECK ADD FOREIGN KEY([medicine_id])
REFERENCES [dbo].[medicines] ([id])
GO
ALTER TABLE [dbo].[prescription_medicine]  WITH CHECK ADD FOREIGN KEY([prescription_id])
REFERENCES [dbo].[prescriptions] ([id])
GO
ALTER TABLE [dbo].[prescriptions]  WITH CHECK ADD  CONSTRAINT [FKct31kf0gdy2r844xaor9ilapm] FOREIGN KEY([treatment_id])
REFERENCES [dbo].[treatments] ([id])
GO
ALTER TABLE [dbo].[prescriptions] CHECK CONSTRAINT [FKct31kf0gdy2r844xaor9ilapm]
GO
ALTER TABLE [dbo].[spa]  WITH CHECK ADD  CONSTRAINT [FK__spa__appointment__5070F446] FOREIGN KEY([appointment_id])
REFERENCES [dbo].[appointments] ([id])
GO
ALTER TABLE [dbo].[spa] CHECK CONSTRAINT [FK__spa__appointment__5070F446]
GO
ALTER TABLE [dbo].[spa]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[managers] ([id])
GO
ALTER TABLE [dbo].[spa]  WITH CHECK ADD  CONSTRAINT [FK__spa__pet_id__52593CB8] FOREIGN KEY([pet_id])
REFERENCES [dbo].[pets] ([id])
GO
ALTER TABLE [dbo].[spa] CHECK CONSTRAINT [FK__spa__pet_id__52593CB8]
GO
ALTER TABLE [dbo].[treatments]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[managers] ([id])
GO
ALTER TABLE [dbo].[treatments]  WITH CHECK ADD  CONSTRAINT [FK__treatment__pet_i__5441852A] FOREIGN KEY([pet_id])
REFERENCES [dbo].[pets] ([id])
GO
ALTER TABLE [dbo].[treatments] CHECK CONSTRAINT [FK__treatment__pet_i__5441852A]
GO
ALTER TABLE [dbo].[treatments]  WITH CHECK ADD  CONSTRAINT [fk_treatment_appointment] FOREIGN KEY([appointment_id])
REFERENCES [dbo].[appointments] ([id])
GO
ALTER TABLE [dbo].[treatments] CHECK CONSTRAINT [fk_treatment_appointment]
GO
USE [master]
GO
ALTER DATABASE [hust_pet_joy] SET  READ_WRITE 
GO
