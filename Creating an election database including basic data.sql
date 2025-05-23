CREATE DATABASE votingCheck
GO
USE votingCheck
GO
/****** Object:  Table [dbo].[ballotBoxes]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ballotBoxes](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[city] [smallint] NOT NULL,
	[location] [varchar](30) NULL,
	[address] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidates]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidates](
	[id] [varchar](9) NOT NULL,
	[LastName] [varchar](20) NULL,
	[FirsrtName] [varchar](20) NULL,
	[address] [varchar](30) NULL,
	[party] [varchar](3) NOT NULL,
	[placeInList] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[changeAgreement]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[changeAgreement](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[party1] [varchar](3) NOT NULL,
	[party2] [varchar](3) NOT NULL,
	[sumSeatsForShare] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cities]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cities](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[envelope]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[envelope](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[ballotBox] [smallint] NULL,
	[party] [varchar](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[necessaryInformation]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[necessaryInformation](
	[assembly] [smallint] NOT NULL,
	[votingDate] [datetime] NULL,
	[BarringPercent] [int] NULL,
	[sumVodesForSeat] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[assembly] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parties]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parties](
	[letters] [varchar](3) NOT NULL,
	[name] [varchar](20) NULL,
	[sumOfPointer] [int] NULL,
	[sumOfSeats] [int] NULL,
	[underBarringPercent] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[letters] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[people]    Script Date: 17/03/2024 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[people](
	[id] [varchar](9) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[FirsrtName] [varchar](20) NOT NULL,
	[ballotBox] [smallint] NOT NULL,
	[doubleEnvelope] [smallint] NULL,
	[ballotTime] [datetime] NULL,
	[address] [varchar](30) NULL,
	[city] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ballotBoxes] ON 

INSERT [dbo].[ballotBoxes] ([id], [city], [location], [address]) VALUES (1, 1, N'בית הספר נאות רחל', N'פחד יצחק 30')
INSERT [dbo].[ballotBoxes] ([id], [city], [location], [address]) VALUES (2, 2, N'סמינר גור', N'חזון איש 30')
SET IDENTITY_INSERT [dbo].[ballotBoxes] OFF
GO
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'000090555', N'נתניהו', N'בנימין', NULL, N'מחל', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'011503547', N'טסלר', N'יעקב', N'הרב סעדיה גאון 3', N'ג', 7)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'017528209', N'ליברמן', N'אביגדור', N'נוקדים 19 נוקדים', N'ל', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'023717259', N'סער', N'גדעון', N'אלכסונדרי 2 אשקלון', N'כן', 2)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'024573180', N'מקלב', N'אורי', N'הרב פנחס קהתי 15 ירו', N'ג', 4)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'029059185', N'אשר', N'יעקב', N'רמב"ם 15 בני ברק', N'ג', 6)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'029503802', N'גולדקנופף', N'יצחק', NULL, N'ג', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'033891797', N'שקד', N'אילת', N'הוז דב 43 רעננה', N'ב', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'050696947', N'איזנקוט', N'גד', N'כספי מרדכי 17 ירושלי', N'כן', 3)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'051218857', N'גפני', N'משה', N'הרב ניסים יצחק 19 בנ', N'ג', 2)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'055941108', N'גנץ', N'בנימין', N'טללים 9 ראש העין', N'כן', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'058407180', N'לפיד', N'יאיר', N'פיינשטיין 11 תל אביב', N'פה', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'069577674', N'דרעי', N'אריה מכלוף', N'הקבלן 28 ירושלים', N'שס', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'123456789', N'מיכאלי', N'מירב', NULL, N'אמת', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'999999998', N'מוכתר', N'הדר', NULL, N'צב', 1)
INSERT [dbo].[candidates] ([id], [LastName], [FirsrtName], [address], [party], [placeInList]) VALUES (N'999999999', N'לוין', N'יריב', NULL, N'מחל', 2)
GO
SET IDENTITY_INSERT [dbo].[changeAgreement] ON 

INSERT [dbo].[changeAgreement] ([id], [party1], [party2], [sumSeatsForShare]) VALUES (1, N'מחל', N'ט', 0)
INSERT [dbo].[changeAgreement] ([id], [party1], [party2], [sumSeatsForShare]) VALUES (2, N'שס', N'ג', 0)
INSERT [dbo].[changeAgreement] ([id], [party1], [party2], [sumSeatsForShare]) VALUES (3, N'פה', N'כן', 0)
INSERT [dbo].[changeAgreement] ([id], [party1], [party2], [sumSeatsForShare]) VALUES (4, N'אמת', N'מרצ', 0)
SET IDENTITY_INSERT [dbo].[changeAgreement] OFF
GO
SET IDENTITY_INSERT [dbo].[cities] ON 

INSERT [dbo].[cities] ([id], [name]) VALUES (1, N'ביתר עילית')
INSERT [dbo].[cities] ([id], [name]) VALUES (2, N'בני ברק')
SET IDENTITY_INSERT [dbo].[cities] OFF
GO
INSERT [dbo].[necessaryInformation] ([assembly], [votingDate], [BarringPercent], [sumVodesForSeat]) VALUES (26, CAST(N'2026-01-27T00:00:00.000' AS DateTime), 0, 0)
GO
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'x', N'פתק פסול', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'אמת', N'העבודה', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'ב', N'הבית היהודי', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'בלד', N'בל''ד', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'ג', N'יהדות התורה', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'ום', N'הרשימה המשותפת', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'ט', N'הציונות הדתית ועוצמה', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'כן', N'המחנה הממלכתי', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'ל', N'ישראל ביתנו', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'מחל', N'הליכוד', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'מרצ', N'מרץ', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'עם', N'רע''ם', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'פה', N'יש עתיד', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'צב', N'צעירים בוערים', 0, 0, 1)
INSERT [dbo].[parties] ([letters], [name], [sumOfPointer], [sumOfSeats], [underBarringPercent]) VALUES (N'שס', N'ש''ס', 0, 0, 1)
GO
INSERT [dbo].[people] ([id], [LastName], [FirsrtName], [ballotBox], [doubleEnvelope], [ballotTime], [address], [city]) VALUES (N'012590261', N'גינזבורג', N'שרה דינה', 2, 1, NULL, N'רשבם 22', 2)
INSERT [dbo].[people] ([id], [LastName], [FirsrtName], [ballotBox], [doubleEnvelope], [ballotTime], [address], [city]) VALUES (N'033495334', N'שציגל', N'משה', 1, 0, NULL, N'הרב שך 33', 1)
INSERT [dbo].[people] ([id], [LastName], [FirsrtName], [ballotBox], [doubleEnvelope], [ballotTime], [address], [city]) VALUES (N'214862575', N'שציגל', N'מרים', 1, 0, NULL, N'הרב שך 33', 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__changeAg__7FAA5D7682367F9D]    Script Date: 17/03/2024 15:36:34 ******/
ALTER TABLE [dbo].[changeAgreement] ADD UNIQUE NONCLUSTERED 
(
	[party1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__changeAg__7FAA5D7784F83F75]    Script Date: 17/03/2024 15:36:34 ******/
ALTER TABLE [dbo].[changeAgreement] ADD UNIQUE NONCLUSTERED 
(
	[party2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[changeAgreement] ADD  DEFAULT ((0)) FOR [sumSeatsForShare]
GO
ALTER TABLE [dbo].[parties] ADD  DEFAULT ((1)) FOR [underBarringPercent]
GO
ALTER TABLE [dbo].[people] ADD  DEFAULT (NULL) FOR [ballotTime]
GO
ALTER TABLE [dbo].[ballotBoxes]  WITH CHECK ADD FOREIGN KEY([city])
REFERENCES [dbo].[cities] ([id])
GO
ALTER TABLE [dbo].[candidates]  WITH CHECK ADD FOREIGN KEY([party])
REFERENCES [dbo].[parties] ([letters])
GO
ALTER TABLE [dbo].[changeAgreement]  WITH CHECK ADD FOREIGN KEY([party1])
REFERENCES [dbo].[parties] ([letters])
GO
ALTER TABLE [dbo].[changeAgreement]  WITH CHECK ADD FOREIGN KEY([party2])
REFERENCES [dbo].[parties] ([letters])
GO
ALTER TABLE [dbo].[envelope]  WITH CHECK ADD FOREIGN KEY([ballotBox])
REFERENCES [dbo].[ballotBoxes] ([id])
GO
ALTER TABLE [dbo].[envelope]  WITH CHECK ADD FOREIGN KEY([party])
REFERENCES [dbo].[parties] ([letters])
GO
ALTER TABLE [dbo].[people]  WITH CHECK ADD FOREIGN KEY([ballotBox])
REFERENCES [dbo].[ballotBoxes] ([id])
GO
ALTER TABLE [dbo].[people]  WITH CHECK ADD FOREIGN KEY([city])
REFERENCES [dbo].[cities] ([id])
GO
ALTER TABLE [dbo].[candidates]  WITH CHECK ADD CHECK  ((len([id])=(9)))
GO
ALTER TABLE [dbo].[changeAgreement]  WITH CHECK ADD  CONSTRAINT [checkParties] CHECK  (([party1]<>[party2]))
GO
ALTER TABLE [dbo].[changeAgreement] CHECK CONSTRAINT [checkParties]
GO
ALTER TABLE [dbo].[parties]  WITH CHECK ADD CHECK  (([underBarringPercent]=(0) OR [underBarringPercent]=(1)))
GO
ALTER TABLE [dbo].[people]  WITH CHECK ADD CHECK  (([doubleEnvelope]=(0) OR [doubleEnvelope]=(1)))
GO
ALTER TABLE [dbo].[people]  WITH CHECK ADD CHECK  ((len([id])=(9)))
GO
