USE [BookShopDb]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 5/4/2018 11:42:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](128) NULL,
	[BookName] [nvarchar](max) NOT NULL,
	[Author] [nvarchar](max) NOT NULL,
	[Describe] [nvarchar](max) NOT NULL,
	[Price] [bigint] NOT NULL,
	[InventoryNumber] [int] NOT NULL,
	[Category] [nvarchar](max) NOT NULL,
	[Publisher] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.Books] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 5/4/2018 11:42:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 5/4/2018 11:42:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[Quanlity] [int] NOT NULL,
 CONSTRAINT [PK_dbo.OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderHistories]    Script Date: 5/4/2018 11:42:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHistories](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](128) NULL,
	[OrderDate] [datetime] NOT NULL,
	[DeliveryDate] [datetime] NULL,
	[CheckOut] [bit] NOT NULL,
	[IsCart] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.OrderHistories] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Publishers]    Script Date: 5/4/2018 11:42:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishers](
	[PublisherID] [int] IDENTITY(1,1) NOT NULL,
	[PublisherName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.Publishers] PRIMARY KEY CLUSTERED 
(
	[PublisherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/4/2018 11:42:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Username] [nvarchar](128) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Role] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([BookID], [Username], [BookName], [Author], [Describe], [Price], [InventoryNumber], [Category], [Publisher], [Image]) VALUES (1, N'uit2608', N'Đời thay đổi khi chúng ta thay đổi - Tập 1', N'Matthews Andrew', N'Chúng ta không thể thay đổi người khác và hoàn cảnh nhưng chúng ta có thể thay đổi cách nhìn của mình về chúng :)', 39000, 100, N'Sách bán chạy', N'NXB Trẻ', N'/Images/BookCovers/doi-thay-doi-khi-chung-ta-thay-doi-tap-1.jpg')
INSERT [dbo].[Books] ([BookID], [Username], [BookName], [Author], [Describe], [Price], [InventoryNumber], [Category], [Publisher], [Image]) VALUES (2, N'uit2608', N'Nhà giả kim', N'Paulo Cohen', N'Sự thật về nhà giả kim', 69000, 109, N'Sách bán chạy', N'NXB Trẻ', N'/Images/BookCovers/nha-gia-kim.jpg')
INSERT [dbo].[Books] ([BookID], [Username], [BookName], [Author], [Describe], [Price], [InventoryNumber], [Category], [Publisher], [Image]) VALUES (3, N'uit2608', N'Đắc nhân tâm', N'Dale Carnegie', N'Cách ảnh hưởng đến người khác', 100000, 300, N'Sách bán chạy', N'NXB Trẻ', N'/Images/BookCovers/dac-nhan-tam.jpg')
SET IDENTITY_INSERT [dbo].[Books] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (1, N'Sách bán chạy')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (2, N'Sách mới phát hành')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (3, N'Sách kỹ năng sống')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (4, N'Sách học ngoại ngữ')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (5, N'Truyện tranh, Manga, Comic')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (6, N'Kiến thức tổng hợp')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (7, N'Truyện ngôn tình')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (8, N'Tiểu thuyết')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (9, N'Sách giáo khoa')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (10, N'Sách tham khảo')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (11, N'Sách thiếu nhi')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (12, N'Sách lịch sử')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (13, N'Sách y học')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (14, N'Sách tâm lý-giới tính')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (15, N'Từ điển')
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[OrderDetails] ([OrderID], [BookID], [Quanlity]) VALUES (4, 1, 30)
INSERT [dbo].[OrderDetails] ([OrderID], [BookID], [Quanlity]) VALUES (4, 2, 30)
SET IDENTITY_INSERT [dbo].[OrderHistories] ON 

INSERT [dbo].[OrderHistories] ([OrderID], [Username], [OrderDate], [DeliveryDate], [CheckOut], [IsCart]) VALUES (4, N'uit2712', CAST(N'2018-04-24 00:00:00.000' AS DateTime), NULL, 0, 1)
INSERT [dbo].[OrderHistories] ([OrderID], [Username], [OrderDate], [DeliveryDate], [CheckOut], [IsCart]) VALUES (5, N'uit2712', CAST(N'2018-04-24 00:00:00.000' AS DateTime), NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[OrderHistories] OFF
SET IDENTITY_INSERT [dbo].[Publishers] ON 

INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (1, N'Không rõ NXB')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (2, N'NXB Kim Đồng')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (3, N'NXB Trẻ')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (4, N'NXB Tổng hợp thành phố Hồ Chí Minh')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (5, N'NXB Chính trị quốc gia')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (6, N'NXB Giáo dục')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (7, N'NXB Hội Nhà văn')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (8, N'NXB Tư pháp')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (9, N'NXB Thông tin và truyền thông')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (10, N'NXB Lao động')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (11, N'NXB Giao thông vận tải')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (12, N'NXB Văn Học')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (13, N'NXB Y Học')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (14, N'NXB Thống Kê')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (15, N'NXB Phụ Nữ')
INSERT [dbo].[Publishers] ([PublisherID], [PublisherName]) VALUES (16, N'NXB Quân Đội Nhân Dân')
SET IDENTITY_INSERT [dbo].[Publishers] OFF
INSERT [dbo].[Users] ([Username], [Password], [Name], [Email], [Role], [Address], [Phone], [Active]) VALUES (N'uit2608', N'e10adc3949ba59abbe56e057f20f883e', N'Phạm Vĩ', N'phamquangvi456@gmail.com', N'Admin', N'526/1B', N'968928511', 1)
INSERT [dbo].[Users] ([Username], [Password], [Name], [Email], [Role], [Address], [Phone], [Active]) VALUES (N'uit2712', N'adb3df2d34daace35eac7c2805d0fb0f', N'Phạm Vĩ', N'phamquangvi456@gmail.com', N'User', N'526/1B', N'123456', 1)
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Books_dbo.Users_Username] FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([Username])
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_dbo.Books_dbo.Users_Username]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderDetails_dbo.Books_BookID] FOREIGN KEY([BookID])
REFERENCES [dbo].[Books] ([BookID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_dbo.OrderDetails_dbo.Books_BookID]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderDetails_dbo.OrderHistories_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[OrderHistories] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_dbo.OrderDetails_dbo.OrderHistories_OrderID]
GO
ALTER TABLE [dbo].[OrderHistories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderHistories_dbo.Users_Username] FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([Username])
GO
ALTER TABLE [dbo].[OrderHistories] CHECK CONSTRAINT [FK_dbo.OrderHistories_dbo.Users_Username]
GO
