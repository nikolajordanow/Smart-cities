USE [master]
GO
/****** Object:  Database [SMART_CITIES]    Script Date: 17.2.2019 г. 22:19:47 ч. ******/
CREATE DATABASE [SMART_CITIES]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SMART_CITIES', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SMART_CITIES.mdf' , SIZE = 183296KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SMART_CITIES_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SMART_CITIES_log.ldf' , SIZE = 1964480KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SMART_CITIES] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SMART_CITIES].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SMART_CITIES] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SMART_CITIES] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SMART_CITIES] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SMART_CITIES] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SMART_CITIES] SET ARITHABORT OFF 
GO
ALTER DATABASE [SMART_CITIES] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SMART_CITIES] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SMART_CITIES] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SMART_CITIES] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SMART_CITIES] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SMART_CITIES] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SMART_CITIES] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SMART_CITIES] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SMART_CITIES] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SMART_CITIES] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SMART_CITIES] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SMART_CITIES] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SMART_CITIES] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SMART_CITIES] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SMART_CITIES] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SMART_CITIES] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SMART_CITIES] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SMART_CITIES] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SMART_CITIES] SET  MULTI_USER 
GO
ALTER DATABASE [SMART_CITIES] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SMART_CITIES] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SMART_CITIES] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SMART_CITIES] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SMART_CITIES] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SMART_CITIES]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 17.2.2019 г. 22:19:48 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[number] [varchar](20) NULL,
	[gender] [varchar](1) NULL,
	[age] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Traffic]    Script Date: 17.2.2019 г. 22:19:48 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Traffic](
	[aNumber] [varchar](20) NULL,
	[direction] [varchar](3) NULL,
	[bNumber] [varchar](20) NULL,
	[startDateTime] [datetime] NULL,
	[cellLong] [numeric](19, 16) NULL,
	[cellLat] [numeric](19, 16) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GenerateCustomers]    Script Date: 17.2.2019 г. 22:19:48 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateCustomers]
AS

BEGIN
WITH 
    cte_n1 (n) AS (SELECT 1 FROM (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) n (n)), 
    cte_n2 (n) AS (SELECT 1 FROM cte_n1 a CROSS JOIN cte_n1 b),
    cte_n3 (n) AS (SELECT 1 FROM cte_n2 a CROSS JOIN cte_n2 b),
    cte_Tally (n) AS (
        SELECT TOP 2000000
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
        FROM
            cte_n3 a CROSS JOIN cte_n3 b
        )
INSERT INTO Customer (number, gender, age)
SELECT '+' + n.number, CASE WHEN g.gender = 1 THEN 'M' WHEN g.gender = 2 THEN 'F' ELSE '?' END, a.age
FROM
    cte_Tally
    CROSS APPLY ( VALUES (CAST(ABS(CHECKSUM(NEWID())) % 1000000001 + 421000000000 AS VARCHAR(20))) ) n (number)
	CROSS APPLY ( VALUES (CAST(ABS(CHECKSUM(NEWID())) % 3 AS VARCHAR(1))) ) g (gender)
	CROSS APPLY ( VALUES (CAST(ABS(CHECKSUM(NEWID())) % 101 AS VARCHAR(3))) ) a (age)
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllCustomers]    Script Date: 17.2.2019 г. 22:19:48 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllCustomers]
AS

BEGIN

SELECT [number]
      ,[gender]
      ,[age]
  FROM [dbo].[Customer]

END
GO
/****** Object:  StoredProcedure [dbo].[GetAllTraffic]    Script Date: 17.2.2019 г. 22:19:48 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllTraffic]
AS

BEGIN

SELECT [aNumber]
      ,[direction]
      ,[bNumber]
      ,[startDateTime]
      ,[cellLong]
      ,[cellLat]
  FROM [dbo].[Traffic]

END

GO
/****** Object:  StoredProcedure [dbo].[GetTrafficByCriteria]    Script Date: 17.2.2019 г. 22:19:48 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTrafficByCriteria]
(
@minAge int,
@maxAge int,
@gender as varchar (1),
@startDate datetime,
@endDate datetime
)
AS

BEGIN

SELECT t.aNumber,
	   t.direction,
	   t.bNumber,
	   t.startDateTime,
	   t.cellLong,
	   t.cellLat
FROM customer c
  inner join traffic t on c.number = t.aNumber
WHERE c.gender = @gender AND
	  c.age BETWEEN @minAge AND @maxAge AND
	  t.startDateTime BETWEEN @startDate AND @endDate
END
GO
/****** Object:  StoredProcedure [dbo].[InsertTraffic]    Script Date: 17.2.2019 г. 22:19:48 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTraffic]
(
@aNumber varchar (20),
@direction as varchar (3),
@bNumber varchar (20),
@startDateTime datetime,
@cellLong numeric(19, 16),
@cellLat numeric(19, 16)
)
AS

BEGIN

INSERT INTO [dbo].[Traffic]
           ([aNumber]
           ,[direction]
           ,[bNumber]
           ,[startDateTime]
           ,[cellLong]
           ,[cellLat])
     VALUES
           (@aNumber
           ,@direction
           ,@bNumber
           ,@startDateTime
           ,@cellLong
           ,@cellLat)

END
GO
USE [master]
GO
ALTER DATABASE [SMART_CITIES] SET  READ_WRITE 
GO
