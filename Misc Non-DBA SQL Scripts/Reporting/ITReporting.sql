USE [master]
GO
/****** Object:  Database [ITReporting]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE DATABASE [ITReporting]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ITReporting', FILENAME = N'M:\MSSQL.MSSQLSERVER.DATA\UserDBs\ITReporting.mdf' , SIZE = 15728640KB , MAXSIZE = UNLIMITED, FILEGROWTH = 131072KB )
 LOG ON 
( NAME = N'ITReporting_log', FILENAME = N'L:\MSSQL.MSSQLSERVER.LOG\UserDBs\ITReporting_log.ldf' , SIZE = 1245184KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ITReporting] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ITReporting].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ITReporting] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ITReporting] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ITReporting] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ITReporting] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ITReporting] SET ARITHABORT OFF 
GO
ALTER DATABASE [ITReporting] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ITReporting] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ITReporting] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ITReporting] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ITReporting] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ITReporting] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ITReporting] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ITReporting] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ITReporting] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ITReporting] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ITReporting] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ITReporting] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ITReporting] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ITReporting] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ITReporting] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ITReporting] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ITReporting] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ITReporting] SET RECOVERY FULL 
GO
ALTER DATABASE [ITReporting] SET  MULTI_USER 
GO
ALTER DATABASE [ITReporting] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ITReporting] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ITReporting] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ITReporting] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ITReporting] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ITReporting] SET QUERY_STORE = OFF
GO
USE [ITReporting]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ITReporting]
GO
/****** Object:  User [ReportServer]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [ReportServer] FOR LOGIN [ReportServer] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [portal]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [portal] FOR LOGIN [portal] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PHARMACA\SQL DataReader]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [PHARMACA\SQL DataReader] FOR LOGIN [PHARMACA\SQL DataReader]
GO
/****** Object:  User [PHARMACA\DEV_RPTAGENT]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [PHARMACA\DEV_RPTAGENT] FOR LOGIN [PHARMACA\DEV_RPTAGENT] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PHARMACA\DEV_PHARMRPT]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [PHARMACA\DEV_PHARMRPT] FOR LOGIN [PHARMACA\DEV_PHARMRPT] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PHARMACA\DEV_ODBCUSER]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [PHARMACA\DEV_ODBCUSER] FOR LOGIN [PHARMACA\DEV_ODBCUSER] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PHARMACA\DEV_DATAREADER]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [PHARMACA\DEV_DATAREADER] FOR LOGIN [PHARMACA\DEV_DATAREADER] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PHARMACA\DEV_BIUSER]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [PHARMACA\DEV_BIUSER] FOR LOGIN [PHARMACA\DEV_BIUSER] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [MedlySanJad]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [MedlySanJad] FOR LOGIN [MedlySanJad] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [LinkedServer]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [LinkedServer] FOR LOGIN [LinkedServer] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dataedo]    Script Date: 10/8/2021 10:17:03 AM ******/
CREATE USER [dataedo] FOR LOGIN [dataedo] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [ReportServer]
GO
ALTER ROLE [db_datareader] ADD MEMBER [portal]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PHARMACA\SQL DataReader]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [PHARMACA\DEV_RPTAGENT]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PHARMACA\DEV_RPTAGENT]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PHARMACA\DEV_RPTAGENT]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PHARMACA\DEV_ODBCUSER]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PHARMACA\DEV_DATAREADER]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PHARMACA\DEV_BIUSER]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PHARMACA\DEV_BIUSER]
GO
ALTER ROLE [db_datareader] ADD MEMBER [MedlySanJad]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LinkedServer]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LinkedServer]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [dataedo]
GO
/****** Object:  Schema [blitz]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE SCHEMA [blitz]
GO
/****** Object:  Schema [info]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE SCHEMA [info]
GO
/****** Object:  Schema [temp]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE SCHEMA [temp]
GO
/****** Object:  UserDefinedTableType [dbo].[tvp_ClientDatabaseLookup]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [dbo].[tvp_ClientDatabaseLookup] AS TABLE(
	[ClientInstanceLookup] [int] NULL,
	[ClientID] [int] NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[InstanceID] [int] NULL,
	[Notes] [nvarchar](250) NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tvp_Clients]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [dbo].[tvp_Clients] AS TABLE(
	[ClientID] [int] NULL,
	[ClientName] [nvarchar](50) NOT NULL,
	[External] [bit] NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tvp_InstanceList]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [dbo].[tvp_InstanceList] AS TABLE(
	[InstanceID] [int] NULL,
	[ServerID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ComputerName] [nvarchar](50) NOT NULL,
	[ServerName] [nvarchar](50) NOT NULL,
	[InstanceName] [nvarchar](50) NOT NULL,
	[isClustered] [bit] NOT NULL,
	[Port] [int] NOT NULL,
	[Inactive] [bit] NULL,
	[Environment] [nvarchar](25) NULL,
	[Location] [nvarchar](30) NULL,
	[NotContactable] [bit] NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_AgentJobDetail]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_AgentJobDetail] AS TABLE(
	[AgentJobDetailID] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
	[InstanceID] [int] NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[JobName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](750) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[LastRunTime] [datetime] NULL,
	[Outcome] [nvarchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_AgentJobServer]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_AgentJobServer] AS TABLE(
	[AgentJobServerID] [int] NULL,
	[Date] [datetime] NOT NULL,
	[InstanceID] [int] NOT NULL,
	[NumberOfJobs] [int] NOT NULL,
	[SuccessfulJobs] [int] NOT NULL,
	[FailedJobs] [int] NOT NULL,
	[DisabledJobs] [int] NOT NULL,
	[UnknownJobs] [int] NOT NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_Alerts]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_Alerts] AS TABLE(
	[AlertsID] [int] NULL,
	[CheckDate] [datetime] NULL,
	[InstanceID] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Category] [nvarchar](128) NULL,
	[DatabaseID] [int] NULL,
	[DelayBetweenResponses] [int] NOT NULL,
	[EventDescriptionKeyword] [nvarchar](100) NULL,
	[EventSource] [nvarchar](100) NULL,
	[HasNotification] [int] NOT NULL,
	[IncludeEventDescription] [nvarchar](128) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[AgentJobDetailID] [int] NULL,
	[LastOccurrenceDate] [datetime] NULL,
	[LastResponseDate] [datetime] NULL,
	[MessageID] [int] NOT NULL,
	[NotificationMessage] [nvarchar](512) NULL,
	[OccurrenceCount] [int] NOT NULL,
	[PerformanceCondition] [nvarchar](512) NULL,
	[Severity] [int] NOT NULL,
	[WmiEventNamespace] [nvarchar](512) NULL,
	[WmiEventQuery] [nvarchar](512) NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_Databases]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_Databases] AS TABLE(
	[DatabaseID] [int] NULL,
	[InstanceID] [int] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateChecked] [datetime2](7) NULL,
	[AutoClose] [bit] NULL,
	[AutoCreateStatisticsEnabled] [bit] NULL,
	[AutoShrink] [bit] NULL,
	[AutoUpdateStatisticsEnabled] [bit] NULL,
	[AvailabilityDatabaseSynchronizationState] [nvarchar](16) NULL,
	[AvailabilityGroupName] [nvarchar](128) NULL,
	[CaseSensitive] [bit] NULL,
	[Collation] [nvarchar](40) NULL,
	[CompatibilityLevel] [nvarchar](15) NULL,
	[CreateDate] [datetime2](7) NULL,
	[DataSpaceUsageKB] [float] NULL,
	[EncryptionEnabled] [bit] NULL,
	[IndexSpaceUsageKB] [float] NULL,
	[IsAccessible] [bit] NULL,
	[IsFullTextEnabled] [bit] NULL,
	[IsMirroringEnabled] [bit] NULL,
	[IsParameterizationForced] [bit] NULL,
	[IsReadCommittedSnapshotOn] [bit] NULL,
	[IsSystemObject] [bit] NULL,
	[IsUpdateable] [bit] NULL,
	[LastBackupDate] [datetime2](7) NULL,
	[LastDifferentialBackupDate] [datetime2](7) NULL,
	[LastLogBackupDate] [datetime2](7) NULL,
	[Owner] [nvarchar](30) NULL,
	[PageVerify] [nvarchar](17) NULL,
	[ReadOnly] [bit] NULL,
	[RecoveryModel] [nvarchar](10) NULL,
	[ReplicationOptions] [nvarchar](40) NULL,
	[SizeMB] [float] NULL,
	[SnapshotIsolationState] [nvarchar](10) NULL,
	[SpaceAvailableKB] [float] NULL,
	[Status] [nvarchar](35) NULL,
	[TargetRecoveryTime] [int] NULL,
	[InActive] [bit] NULL,
	[LastRead] [datetime2](7) NULL,
	[LastWrite] [datetime2](7) NULL,
	[LastReboot] [datetime2](7) NULL,
	[LastDBCCDate] [datetime] NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_DiskSpace]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_DiskSpace] AS TABLE(
	[DiskSpaceID] [int] NULL,
	[Date] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[DiskName] [nvarchar](50) NULL,
	[Label] [nvarchar](50) NULL,
	[Capacity] [decimal](7, 2) NULL,
	[FreeSpace] [decimal](7, 2) NULL,
	[Percentage] [int] NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_HistoricalDBSize]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_HistoricalDBSize] AS TABLE(
	[DatabaseSizeHistoryID] [int] NULL,
	[DatabaseID] [int] NOT NULL,
	[InstanceID] [int] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[DateChecked] [date] NULL,
	[SizeMB] [float] NULL,
	[SpaceAvailableKB] [float] NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_LogFileErrorMessages]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_LogFileErrorMessages] AS TABLE(
	[LogFileErrorMessagesID] [int] NULL,
	[Date] [date] NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[ErrorMsg] [nvarchar](500) NOT NULL,
	[Line] [int] NOT NULL,
	[Matches] [nvarchar](12) NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_ServerInfo]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_ServerInfo] AS TABLE(
	[ServerID] [int] NULL,
	[DateChecked] [datetime] NULL,
	[ServerName] [nvarchar](50) NULL,
	[DNSHostName] [nvarchar](50) NULL,
	[Domain] [nvarchar](30) NULL,
	[OperatingSystem] [nvarchar](100) NULL,
	[NoProcessors] [tinyint] NULL,
	[IPAddress] [nvarchar](15) NULL,
	[RAM] [int] NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_SQLInfo]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_SQLInfo] AS TABLE(
	[SQLInfoID] [int] NULL,
	[DateChecked] [datetime] NULL,
	[DateAdded] [datetime] NULL,
	[ServerName] [nvarchar](50) NULL,
	[InstanceName] [nvarchar](50) NULL,
	[SQLVersionString] [nvarchar](100) NULL,
	[SQLVersion] [nvarchar](100) NULL,
	[ServicePack] [nvarchar](3) NULL,
	[Edition] [nvarchar](50) NULL,
	[ServerType] [nvarchar](30) NULL,
	[Collation] [nvarchar](30) NULL,
	[IsHADREnabled] [bit] NULL,
	[SQLServiceAccount] [nvarchar](35) NULL,
	[SQLService] [nvarchar](30) NULL,
	[SQLServiceStartMode] [nvarchar](30) NULL,
	[BAckupDirectory] [nvarchar](256) NULL,
	[BrowserAccount] [nvarchar](50) NULL,
	[BrowserStartMode] [nvarchar](25) NULL,
	[IsSQLClustered] [bit] NULL,
	[ClusterName] [nvarchar](25) NULL,
	[ClusterQuorumstate] [nvarchar](20) NULL,
	[ClusterQuorumType] [nvarchar](30) NULL,
	[C2AuditMode] [nvarchar](30) NULL,
	[CostThresholdForParallelism] [tinyint] NULL,
	[MaxDegreeOfParallelism] [tinyint] NULL,
	[DBMailEnabled] [bit] NULL,
	[DefaultBackupCComp] [bit] NULL,
	[FillFactor] [tinyint] NULL,
	[MaxMem] [int] NULL,
	[MinMem] [int] NULL,
	[RemoteDacEnabled] [bit] NULL,
	[XPCmdShellEnabled] [bit] NULL,
	[CommonCriteriaComplianceEnabled] [bit] NULL,
	[DefaultFile] [nvarchar](100) NULL,
	[DefaultLog] [nvarchar](100) NULL,
	[HADREndpointPort] [int] NULL,
	[ErrorLogPath] [nvarchar](100) NULL,
	[InstallDataDirectory] [nvarchar](100) NULL,
	[InstallSharedDirectory] [nvarchar](100) NULL,
	[IsCaseSensitive] [bit] NULL,
	[IsFullTextInstalled] [bit] NULL,
	[LinkedServer] [nvarchar](max) NULL,
	[LoginMode] [nvarchar](20) NULL,
	[MasterDBLogPath] [nvarchar](100) NULL,
	[MasterDBPath] [nvarchar](100) NULL,
	[NamedPipesEnabled] [bit] NULL,
	[OptimizeAdhocWorkloads] [bit] NULL,
	[InstanceID] [int] NULL,
	[AGListener] [nvarchar](150) NULL,
	[AGs] [nvarchar](150) NULL,
	[AGListenerPort] [nvarchar](250) NULL,
	[AGListenerIPs] [nvarchar](150) NULL,
	[AgentServiceAccount] [nvarchar](50) NULL,
	[AgentServiceStartMode] [nvarchar](50) NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_SQLServerBuilds]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_SQLServerBuilds] AS TABLE(
	[SQLbuildID] [int] NULL,
	[Build] [nvarchar](15) NOT NULL,
	[SQLSERVERExeBuild] [nvarchar](15) NOT NULL,
	[Fileversion] [nvarchar](20) NULL,
	[Q] [nvarchar](10) NOT NULL,
	[KB] [nvarchar](10) NULL,
	[KBDescription] [nvarchar](300) NULL,
	[ReleaseDate] [date] NULL,
	[New] [bit] NOT NULL,
	[U] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [info].[tvp_SuspectPages]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE TYPE [info].[tvp_SuspectPages] AS TABLE(
	[SuspectPageID] [int] NULL,
	[DatabaseID] [int] NOT NULL,
	[DateChecked] [datetime] NOT NULL,
	[FileName] [varchar](2000) NOT NULL,
	[Page_id] [bigint] NOT NULL,
	[EventType] [nvarchar](24) NOT NULL,
	[Error_count] [int] NOT NULL,
	[last_update_date] [datetime] NOT NULL,
	[InstanceID] [int] NOT NULL,
	[U] [bit] NULL
)
GO
/****** Object:  Table [dbo].[BAKFiles]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAKFiles](
	[Server] [nvarchar](max) NULL,
	[QueryDate] [datetime2](7) NULL,
	[PSDrive] [nvarchar](max) NULL,
	[Directory] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[FullName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientDatabaseLookup]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientDatabaseLookup](
	[ClientInstanceLookup] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[InstanceID] [int] NULL,
	[Notes] [nvarchar](250) NULL,
 CONSTRAINT [PK_ClientInstanceLookup] PRIMARY KEY CLUSTERED 
(
	[ClientInstanceLookup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [nvarchar](50) NOT NULL,
	[External] [bit] NULL,
 CONSTRAINT [PK_dbo.Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatabaseCollation]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseCollation](
	[QueryDate] [datetime2](7) NULL,
	[ComputerName] [nvarchar](max) NULL,
	[InstanceName] [nvarchar](max) NULL,
	[SqlInstance] [nvarchar](max) NULL,
	[Database] [nvarchar](max) NULL,
	[ServerCollation] [nvarchar](max) NULL,
	[DatabaseCollation] [nvarchar](max) NULL,
	[IsEqual] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatabaseCompatibility]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseCompatibility](
	[QueryDate] [datetime2](7) NULL,
	[ComputerName] [nvarchar](max) NULL,
	[InstanceName] [nvarchar](max) NULL,
	[SqlInstance] [nvarchar](max) NULL,
	[Database] [nvarchar](max) NULL,
	[ServerLevel] [nvarchar](max) NULL,
	[DatabaseCompatibility] [nvarchar](max) NULL,
	[IsEqual] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatabaseOwnership]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseOwnership](
	[QueryDate] [datetime2](7) NULL,
	[ComputerName] [nvarchar](max) NULL,
	[CurrentOwner] [nvarchar](max) NULL,
	[Database] [nvarchar](max) NULL,
	[InstanceName] [nvarchar](max) NULL,
	[SqlInstance] [nvarchar](max) NULL,
	[TargetOwner] [nvarchar](max) NULL,
	[OwnerMatch] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DuplicateIndexes]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DuplicateIndexes](
	[Server] [nvarchar](max) NULL,
	[QueryDate] [datetime2](7) NULL,
	[DatabaseName] [nvarchar](max) NULL,
	[TableName] [nvarchar](max) NULL,
	[IndexName] [nvarchar](max) NULL,
	[KeyColumns] [nvarchar](max) NULL,
	[IndexSizeMB] [decimal](38, 5) NULL,
	[RowCount] [bigint] NULL,
	[IsDisabled] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstanceBuild]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstanceBuild](
	[QueryDate] [datetime2](7) NULL,
	[SqlInstance] [nvarchar](max) NULL,
	[NameLevel] [nvarchar](max) NULL,
	[SPLevel] [nvarchar](max) NULL,
	[CULevel] [nvarchar](max) NULL,
	[KBLevel] [nvarchar](max) NULL,
	[Build] [nvarchar](max) NULL,
	[BuildTarget] [nvarchar](max) NULL,
	[Compliant] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstanceList]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstanceList](
	[InstanceID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ComputerName] [nvarchar](50) NOT NULL,
	[ServerName] [nvarchar](50) NOT NULL,
	[InstanceName] [nvarchar](50) NOT NULL,
	[isClustered] [bit] NOT NULL,
	[Port] [int] NOT NULL,
	[Inactive] [bit] NULL,
	[Environment] [nvarchar](25) NULL,
	[Location] [nvarchar](30) NULL,
	[NotContactable] [bit] NULL,
 CONSTRAINT [PK_InstanceList_ID] PRIMARY KEY CLUSTERED 
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstanceTriggers]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstanceTriggers](
	[ServerName] [nvarchar](128) NOT NULL,
	[DatabaseName] [nvarchar](128) NOT NULL,
	[TableName] [nvarchar](128) NOT NULL,
	[TriggerName] [nvarchar](128) NOT NULL,
	[TriggerOwner] [nvarchar](128) NULL,
	[IsUpdate] [int] NULL,
	[IsDelete] [int] NULL,
	[IsInsert] [int] NULL,
	[IsAfter] [int] NULL,
	[IsInsteadOf] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[QueryDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoggedInServerUsers]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoggedInServerUsers](
	[ServerUserID] [int] IDENTITY(1,1) NOT NULL,
	[QueryDate] [datetime2](7) NULL,
	[ComputerName] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
 CONSTRAINT [PK_LoggedInServerUsers] PRIMARY KEY CLUSTERED 
(
	[ServerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogSpaceHistory]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogSpaceHistory](
	[LogSpaceID] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [varchar](100) NOT NULL,
	[DatabaseID] [smallint] NOT NULL,
	[DatabaseName] [varchar](50) NOT NULL,
	[TotalLogSizeInBytes] [bigint] NOT NULL,
	[UsedLogSpaceInBytes] [bigint] NOT NULL,
	[UsedLogSpaceInPercent] [real] NOT NULL,
	[LogSpaceInBytesSinceLastBackup] [bigint] NOT NULL,
	[QueryDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_LogSpaceHistory] PRIMARY KEY CLUSTERED 
(
	[LogSpaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotEntered]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotEntered](
	[date] [datetime] NOT NULL,
	[Notentered] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrphanedFiles]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrphanedFiles](
	[QueryDate] [datetime2](7) NULL,
	[ComputerName] [nvarchar](max) NULL,
	[InstanceName] [nvarchar](max) NULL,
	[SqlInstance] [nvarchar](max) NULL,
	[Filename] [nvarchar](max) NULL,
	[RemoteFilename] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RobocopyBackups]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RobocopyBackups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[Share] [varchar](50) NOT NULL,
	[Task] [varchar](50) NOT NULL,
	[ExitCode] [varchar](50) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerPendingUpdates]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerPendingUpdates](
	[QueryDate] [datetime2](7) NULL,
	[Computername] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[KB] [nvarchar](max) NULL,
	[Url] [nvarchar](max) NULL,
	[IsDownloaded] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StartupParameters]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StartupParameters](
	[QueryDate] [datetime2](7) NULL,
	[ComputerName] [nvarchar](max) NULL,
	[SqlInstance] [nvarchar](max) NULL,
	[MasterData] [nvarchar](max) NULL,
	[MasterLog] [nvarchar](max) NULL,
	[ErrorLog] [nvarchar](max) NULL,
	[TraceFlags] [nvarchar](max) NULL,
	[ParameterString] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StoredProcHistory]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoredProcHistory](
	[ServerName] [varchar](100) NOT NULL,
	[DatabaseName] [varchar](100) NOT NULL,
	[SchemaName] [varchar](50) NOT NULL,
	[ObjectName] [varchar](150) NOT NULL,
	[LastExecTime] [datetime] NULL,
	[CaptureDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysConfigChecksum]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysConfigChecksum](
	[Server] [varchar](150) NOT NULL,
	[QueryDate] [datetime] NOT NULL,
	[SysConfigSum] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysConfigHistory]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysConfigHistory](
	[ServerName] [varchar](150) NOT NULL,
	[CaptureDate] [datetime] NOT NULL,
	[ConfigID] [int] NOT NULL,
	[ConfigName] [nvarchar](35) NOT NULL,
	[ConfigValue] [sql_variant] NULL,
	[ConfigMin] [sql_variant] NULL,
	[ConfigMax] [sql_variant] NULL,
	[ConfigValueInUse] [sql_variant] NULL,
	[ConfigDesc] [nvarchar](255) NULL,
	[IsDynamics] [bit] NULL,
	[IsAdvanced] [bit] NULL,
	[ConfigSum] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tally]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tally](
	[N] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Tally_N] PRIMARY KEY CLUSTERED 
(
	[N] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnusedIndexes]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnusedIndexes](
	[Server] [nvarchar](max) NULL,
	[QueryDate] [datetime2](7) NULL,
	[DatabaseName] [nvarchar](max) NULL,
	[SchemaName] [nvarchar](max) NULL,
	[TableName] [nvarchar](max) NULL,
	[IndexName] [nvarchar](max) NULL,
	[UserSeeks] [bigint] NULL,
	[UserScans] [bigint] NULL,
	[UserLookups] [bigint] NULL,
	[UserUpdates] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [info].[AgentJobDetail]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[AgentJobDetail](
	[AgentJobDetailID] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[InstanceID] [int] NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[JobName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](750) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[LastRunTime] [datetime] NULL,
	[Outcome] [nvarchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_info.AgentJobDetail] PRIMARY KEY CLUSTERED 
(
	[AgentJobDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[AgentJobServer]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[AgentJobServer](
	[AgentJobServerID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[InstanceID] [int] NOT NULL,
	[NumberOfJobs] [int] NOT NULL,
	[SuccessfulJobs] [int] NOT NULL,
	[FailedJobs] [int] NOT NULL,
	[DisabledJobs] [int] NOT NULL,
	[UnknownJobs] [int] NOT NULL,
 CONSTRAINT [PK_Info.AgentJobServer] PRIMARY KEY CLUSTERED 
(
	[AgentJobServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[Alerts]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[Alerts](
	[AlertsID] [int] IDENTITY(1,1) NOT NULL,
	[CheckDate] [datetime] NULL,
	[InstanceID] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Category] [nvarchar](128) NULL,
	[DatabaseID] [int] NULL,
	[DelayBetweenResponses] [int] NOT NULL,
	[EventDescriptionKeyword] [nvarchar](100) NULL,
	[EventSource] [nvarchar](100) NULL,
	[HasNotification] [int] NOT NULL,
	[IncludeEventDescription] [nvarchar](128) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[AgentJobDetailID] [int] NULL,
	[LastOccurrenceDate] [datetime] NULL,
	[LastResponseDate] [datetime] NULL,
	[MessageID] [int] NOT NULL,
	[NotificationMessage] [nvarchar](512) NULL,
	[OccurrenceCount] [int] NOT NULL,
	[PerformanceCondition] [nvarchar](512) NULL,
	[Severity] [int] NOT NULL,
	[WmiEventNamespace] [nvarchar](512) NULL,
	[WmiEventQuery] [nvarchar](512) NULL,
 CONSTRAINT [PK_Alerts] PRIMARY KEY CLUSTERED 
(
	[AlertsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[Databases]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[Databases](
	[DatabaseID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateChecked] [datetime2](7) NULL,
	[AutoClose] [bit] NULL,
	[AutoCreateStatisticsEnabled] [bit] NULL,
	[AutoShrink] [bit] NULL,
	[AutoUpdateStatisticsEnabled] [bit] NULL,
	[AvailabilityDatabaseSynchronizationState] [nvarchar](16) NULL,
	[AvailabilityGroupName] [nvarchar](128) NULL,
	[CaseSensitive] [bit] NULL,
	[Collation] [nvarchar](40) NULL,
	[CompatibilityLevel] [nvarchar](15) NULL,
	[CreateDate] [datetime2](7) NULL,
	[DataSpaceUsageKB] [float] NULL,
	[EncryptionEnabled] [bit] NULL,
	[IndexSpaceUsageKB] [float] NULL,
	[IsAccessible] [bit] NULL,
	[IsFullTextEnabled] [bit] NULL,
	[IsMirroringEnabled] [bit] NULL,
	[IsParameterizationForced] [bit] NULL,
	[IsReadCommittedSnapshotOn] [bit] NULL,
	[IsSystemObject] [bit] NULL,
	[IsUpdateable] [bit] NULL,
	[LastBackupDate] [datetime2](7) NULL,
	[LastDifferentialBackupDate] [datetime2](7) NULL,
	[LastLogBackupDate] [datetime2](7) NULL,
	[Owner] [nvarchar](30) NULL,
	[PageVerify] [nvarchar](17) NULL,
	[ReadOnly] [bit] NULL,
	[RecoveryModel] [nvarchar](10) NULL,
	[ReplicationOptions] [nvarchar](40) NULL,
	[SizeMB] [float] NULL,
	[SnapshotIsolationState] [nvarchar](10) NULL,
	[SpaceAvailableKB] [float] NULL,
	[Status] [nvarchar](35) NULL,
	[TargetRecoveryTime] [int] NULL,
	[InActive] [bit] NULL,
	[LastRead] [datetime2](7) NULL,
	[LastWrite] [datetime2](7) NULL,
	[LastReboot] [datetime2](7) NULL,
	[LastDBCCDate] [datetime] NULL,
 CONSTRAINT [PK_Databases] PRIMARY KEY CLUSTERED 
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[DiskSpace]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[DiskSpace](
	[DiskSpaceID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[DiskName] [nvarchar](50) NULL,
	[Label] [nvarchar](50) NULL,
	[Capacity] [decimal](7, 2) NULL,
	[FreeSpace] [decimal](7, 2) NULL,
	[Percentage] [int] NULL,
 CONSTRAINT [PK_DiskSpace_1] PRIMARY KEY CLUSTERED 
(
	[DiskSpaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[HistoricalDBSize]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[HistoricalDBSize](
	[DatabaseSizeHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[InstanceID] [int] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[DateChecked] [date] NULL,
	[SizeMB] [float] NULL,
	[SpaceAvailableKB] [float] NULL,
 CONSTRAINT [PK_HistoricalDBSizeNew] PRIMARY KEY CLUSTERED 
(
	[DatabaseSizeHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[LogFileErrorMessages]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[LogFileErrorMessages](
	[LogFileErrorMessagesID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[ErrorMsg] [nvarchar](500) NOT NULL,
	[Line] [int] NOT NULL,
	[Matches] [nvarchar](12) NULL,
 CONSTRAINT [PK_LogFileErrorMessages] PRIMARY KEY CLUSTERED 
(
	[LogFileErrorMessagesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[ServerInfo]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[ServerInfo](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[DateChecked] [datetime] NULL,
	[ServerName] [nvarchar](50) NULL,
	[DNSHostName] [nvarchar](50) NULL,
	[Domain] [nvarchar](30) NULL,
	[OperatingSystem] [nvarchar](100) NULL,
	[NoProcessors] [tinyint] NULL,
	[IPAddress] [nvarchar](15) NULL,
	[RAM] [int] NULL,
 CONSTRAINT [PK__ServerOS__50A5926BC7005F29] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[SQLInfo]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[SQLInfo](
	[SQLInfoID] [int] IDENTITY(1,1) NOT NULL,
	[DateChecked] [datetime] NULL,
	[DateAdded] [datetime] NULL,
	[ServerName] [nvarchar](50) NULL,
	[InstanceName] [nvarchar](50) NULL,
	[SQLVersionString] [nvarchar](100) NULL,
	[SQLVersion] [nvarchar](100) NULL,
	[ServicePack] [nvarchar](3) NULL,
	[Edition] [nvarchar](50) NULL,
	[ServerType] [nvarchar](30) NULL,
	[Collation] [nvarchar](30) NULL,
	[IsHADREnabled] [bit] NULL,
	[SQLServiceAccount] [nvarchar](35) NULL,
	[SQLService] [nvarchar](30) NULL,
	[SQLServiceStartMode] [nvarchar](30) NULL,
	[BAckupDirectory] [nvarchar](256) NULL,
	[BrowserAccount] [nvarchar](50) NULL,
	[BrowserStartMode] [nvarchar](25) NULL,
	[IsSQLClustered] [bit] NULL,
	[ClusterName] [nvarchar](25) NULL,
	[ClusterQuorumstate] [nvarchar](20) NULL,
	[ClusterQuorumType] [nvarchar](30) NULL,
	[C2AuditMode] [nvarchar](30) NULL,
	[CostThresholdForParallelism] [tinyint] NULL,
	[MaxDegreeOfParallelism] [tinyint] NULL,
	[DBMailEnabled] [bit] NULL,
	[DefaultBackupCComp] [bit] NULL,
	[FillFactor] [tinyint] NULL,
	[MaxMem] [int] NULL,
	[MinMem] [int] NULL,
	[RemoteDacEnabled] [bit] NULL,
	[XPCmdShellEnabled] [bit] NULL,
	[CommonCriteriaComplianceEnabled] [bit] NULL,
	[DefaultFile] [nvarchar](100) NULL,
	[DefaultLog] [nvarchar](100) NULL,
	[HADREndpointPort] [int] NULL,
	[ErrorLogPath] [nvarchar](100) NULL,
	[InstallDataDirectory] [nvarchar](100) NULL,
	[InstallSharedDirectory] [nvarchar](100) NULL,
	[IsCaseSensitive] [bit] NULL,
	[IsFullTextInstalled] [bit] NULL,
	[LinkedServer] [nvarchar](max) NULL,
	[LoginMode] [nvarchar](20) NULL,
	[MasterDBLogPath] [nvarchar](100) NULL,
	[MasterDBPath] [nvarchar](100) NULL,
	[NamedPipesEnabled] [bit] NULL,
	[OptimizeAdhocWorkloads] [bit] NULL,
	[InstanceID] [int] NULL,
	[AGListener] [nvarchar](150) NULL,
	[AGs] [nvarchar](150) NULL,
	[AGListenerPort] [nvarchar](250) NULL,
	[AGListenerIPs] [nvarchar](150) NULL,
	[AgentServiceAccount] [nvarchar](50) NULL,
	[AgentServiceStartMode] [nvarchar](50) NULL,
 CONSTRAINT [PK__SQL__50A5926BC7005F29] PRIMARY KEY CLUSTERED 
(
	[SQLInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [info].[SQLServerBuilds]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[SQLServerBuilds](
	[SQLbuildID] [int] IDENTITY(1,1) NOT NULL,
	[Build] [nvarchar](15) NOT NULL,
	[SQLSERVERExeBuild] [nvarchar](15) NOT NULL,
	[Fileversion] [nvarchar](20) NULL,
	[Q] [nvarchar](10) NOT NULL,
	[KB] [nvarchar](10) NULL,
	[KBDescription] [nvarchar](300) NULL,
	[ReleaseDate] [date] NULL,
	[New] [bit] NOT NULL,
 CONSTRAINT [PK_SQLServerBuilds] PRIMARY KEY CLUSTERED 
(
	[SQLbuildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [info].[SuspectPages]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [info].[SuspectPages](
	[SuspectPageID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[DateChecked] [datetime] NOT NULL,
	[FileName] [varchar](2000) NOT NULL,
	[Page_id] [bigint] NOT NULL,
	[EventType] [nvarchar](24) NOT NULL,
	[Error_count] [int] NOT NULL,
	[last_update_date] [datetime] NOT NULL,
	[InstanceID] [int] NOT NULL,
 CONSTRAINT [PK_SuspectPages] PRIMARY KEY CLUSTERED 
(
	[SuspectPageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_DuplicateIndexes]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_DuplicateIndexes] ON [dbo].[DuplicateIndexes]
(
	[QueryDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_DiskSpace_ServerID_DiskName]    Script Date: 10/8/2021 10:17:04 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DiskSpace_ServerID_DiskName] ON [info].[DiskSpace]
(
	[ServerID] ASC,
	[DiskName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InstanceList] ADD  CONSTRAINT [DF_InstanceList_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[InstanceList] ADD  CONSTRAINT [DF_InstanceList_NotContactable]  DEFAULT ((0)) FOR [NotContactable]
GO
ALTER TABLE [dbo].[ClientDatabaseLookup]  WITH CHECK ADD  CONSTRAINT [FK_ClientDatabaseLookup_Clients] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[ClientDatabaseLookup] CHECK CONSTRAINT [FK_ClientDatabaseLookup_Clients]
GO
ALTER TABLE [dbo].[ClientDatabaseLookup]  WITH CHECK ADD  CONSTRAINT [FK_ClientDatabaseLookup_Databases] FOREIGN KEY([DatabaseID])
REFERENCES [info].[Databases] ([DatabaseID])
GO
ALTER TABLE [dbo].[ClientDatabaseLookup] CHECK CONSTRAINT [FK_ClientDatabaseLookup_Databases]
GO
ALTER TABLE [dbo].[ClientDatabaseLookup]  WITH CHECK ADD  CONSTRAINT [FK_ClientDatabaseLookup_InstanceList] FOREIGN KEY([InstanceID])
REFERENCES [dbo].[InstanceList] ([InstanceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientDatabaseLookup] CHECK CONSTRAINT [FK_ClientDatabaseLookup_InstanceList]
GO
ALTER TABLE [dbo].[InstanceList]  WITH CHECK ADD  CONSTRAINT [FK_InstanceList_ServerInfo] FOREIGN KEY([ServerID])
REFERENCES [info].[ServerInfo] ([ServerID])
GO
ALTER TABLE [dbo].[InstanceList] CHECK CONSTRAINT [FK_InstanceList_ServerInfo]
GO
ALTER TABLE [info].[AgentJobDetail]  WITH CHECK ADD  CONSTRAINT [FK_info.AgentJobDetail_InstanceList] FOREIGN KEY([InstanceID])
REFERENCES [dbo].[InstanceList] ([InstanceID])
ON DELETE CASCADE
GO
ALTER TABLE [info].[AgentJobDetail] CHECK CONSTRAINT [FK_info.AgentJobDetail_InstanceList]
GO
ALTER TABLE [info].[AgentJobServer]  WITH CHECK ADD  CONSTRAINT [FK_Info.AgentJobServer_InstanceList] FOREIGN KEY([InstanceID])
REFERENCES [dbo].[InstanceList] ([InstanceID])
ON DELETE CASCADE
GO
ALTER TABLE [info].[AgentJobServer] CHECK CONSTRAINT [FK_Info.AgentJobServer_InstanceList]
GO
ALTER TABLE [info].[Databases]  WITH CHECK ADD  CONSTRAINT [FK_Databases_InstanceList] FOREIGN KEY([InstanceID])
REFERENCES [dbo].[InstanceList] ([InstanceID])
ON DELETE CASCADE
GO
ALTER TABLE [info].[Databases] CHECK CONSTRAINT [FK_Databases_InstanceList]
GO
ALTER TABLE [info].[DiskSpace]  WITH CHECK ADD  CONSTRAINT [FK_DiskSpace_ServerInfo] FOREIGN KEY([ServerID])
REFERENCES [info].[ServerInfo] ([ServerID])
GO
ALTER TABLE [info].[DiskSpace] CHECK CONSTRAINT [FK_DiskSpace_ServerInfo]
GO
ALTER TABLE [info].[HistoricalDBSize]  WITH CHECK ADD  CONSTRAINT [FK_HistoricalDBSize_Databases] FOREIGN KEY([DatabaseID])
REFERENCES [info].[Databases] ([DatabaseID])
GO
ALTER TABLE [info].[HistoricalDBSize] CHECK CONSTRAINT [FK_HistoricalDBSize_Databases]
GO
ALTER TABLE [info].[SQLInfo]  WITH CHECK ADD  CONSTRAINT [FK_SQLInfo_InstanceList] FOREIGN KEY([InstanceID])
REFERENCES [dbo].[InstanceList] ([InstanceID])
ON DELETE CASCADE
GO
ALTER TABLE [info].[SQLInfo] CHECK CONSTRAINT [FK_SQLInfo_InstanceList]
GO
ALTER TABLE [info].[SuspectPages]  WITH CHECK ADD  CONSTRAINT [FK_SuspectPages_Databases] FOREIGN KEY([DatabaseID])
REFERENCES [info].[Databases] ([DatabaseID])
GO
ALTER TABLE [info].[SuspectPages] CHECK CONSTRAINT [FK_SuspectPages_Databases]
GO
ALTER TABLE [info].[SuspectPages]  WITH CHECK ADD  CONSTRAINT [FK_SuspectPages_InstanceList] FOREIGN KEY([InstanceID])
REFERENCES [dbo].[InstanceList] ([InstanceID])
ON DELETE CASCADE
GO
ALTER TABLE [info].[SuspectPages] CHECK CONSTRAINT [FK_SuspectPages_InstanceList]
GO
/****** Object:  StoredProcedure [dbo].[BAKFileQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-05
-- Description:	Job Queries BAKFiles table for 
--				any apparent BAK files on each
--				database server
-- =============================================
CREATE PROCEDURE [dbo].[BAKFileQuery] 
	
@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

IF @EndDate IS NULL
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF @StartDate IS NULL 
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

SELECT	DISTINCT
		BF.Server
		, CAST(BF.QueryDate AS Date) QueryDate
		, BF.Directory
		, BF.Name
FROM	dbo.BAKFiles BF
WHERE	BF.QueryDate BETWEEN @StartDate AND @EndDate
		AND 
		(
		BF.Directory LIKE '%000-SRV-GP%'
		OR BF.Directory LIKE '%000-SRV-DB1%'
		OR BF.Directory LIKE '%000-WINSRV-RPT%'
		OR BF.Directory LIKE '%000-WINSRV-INT%'
		OR BF.Directory LIKE '%000-WINSRV-SWNT%'
		)

END
GO
/****** Object:  StoredProcedure [dbo].[DBCollationQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-05
-- Description:	Checks for any database that 
--				has a different collation than
--				the SQL Server instance
-- =============================================
CREATE PROCEDURE [dbo].[DBCollationQuery] 
	
@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

IF @EndDate IS NULL
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF @StartDate IS NULL
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

SELECT	CAST(DC.QueryDate AS Date) QueryDate
		, DC.ComputerName Server
		, DC.InstanceName SQLInstance
		, DC.[Database] 
		, DC.ServerCollation
		, DC.DatabaseCollation
		, DC.IsEqual
FROM	dbo.DatabaseCollation DC
WHERE	DC.QueryDate BETWEEN @StartDate AND @EndDate
		AND DC.IsEqual <> 1
		AND DC.[Database] NOT IN ('ReportServer','ReportServerTempDB')

END
GO
/****** Object:  StoredProcedure [dbo].[DBCompatibilityQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-05
-- Description:	Returns List of Databases on 
--				different compatibility levels
--				than the instance.
-- =============================================
CREATE PROCEDURE [dbo].[DBCompatibilityQuery] 
	
@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

IF @EndDate IS NULL
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF @StartDate IS NULL
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

SELECT	CAST(QueryDate AS Date) QueryDate
		, ComputerName ServerName
		, SqlInstance InstanceName
		, [Database] DatabaseName
		, ServerLevel ServerLevel
		, DatabaseCompatibility DatabaseLevel
		, IsEqual 
FROM	[ITReporting].[dbo].[DatabaseCompatibility]
WHERE	IsEqual <> 1
		AND QueryDate BETWEEN @StartDate AND @EndDate

END
GO
/****** Object:  StoredProcedure [dbo].[DBGrowthAndSize]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-08
-- Description:	Returns Information on DB Growth
--				& Current Size
-- =============================================
CREATE PROCEDURE [dbo].[DBGrowthAndSize] 
	
@StartDate DateTime NULL
, @EndDate DateTime NULL
	
AS
BEGIN
SET NOCOUNT ON;

IF ISNULL(@EndDate,'1900-01-01') = '1900-01-01'
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF ISNULL(@StartDate,'1900-01-01') = '1900-01-01'
SET @StartDate = DATEADD(DAY,-1,GETDATE())
ELSE SET @StartDate = @StartDate

SELECT	SI.ServerName
		, HDS.Name
		, HDS.DateChecked
		, HDS.SizeMB
		, CAST(HDS.SpaceAvailableKB AS Numeric(18,2)) / 1024 SpaceAvailableMB
		, (CAST(HDS.SizeMB AS Numeric(18,2)) - (CAST(HDS.SpaceAvailableKB AS Numeric(18,2)) / 1024)) / (CAST(HDS.SizeMB AS Numeric(18,2))) PercentAvailable
		, CASE
			WHEN (CAST(HDS.SizeMB AS Numeric(18,2)) - (CAST(HDS.SpaceAvailableKB AS Numeric(18,2)) / 1024)) / (CAST(HDS.SizeMB AS Numeric(18,2))) <= 0.2
			THEN 1
			ELSE 0
			END AS NeedsGrowth
FROM	info.HistoricalDBSize HDS
INNER JOIN
		info.ServerInfo SI
			ON HDS.InstanceID = SI.ServerID
WHERE	HDS.DateChecked BETWEEN @StartDate AND @EndDate
		AND CASE
					WHEN (CAST(HDS.SizeMB AS Numeric(18,2)) - (CAST(HDS.SpaceAvailableKB AS Numeric(18,2)) / 1024)) / (CAST(HDS.SizeMB AS Numeric(18,2))) <= 0.2
					THEN 1
					ELSE 0
					END = 1
		AND HDS.Name NOT IN ('ReportServerTempDB','TempDB')
ORDER BY
		HDS.DateChecked DESC	
		, SI.ServerName ASC	
		, HDS.Name ASC	

END
GO
/****** Object:  StoredProcedure [dbo].[DBOwnershipQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-05
-- Description:	Returns list of databases whose
--				owners don't match specified 
--				accounts of SA or DYNSA
-- =============================================
CREATE PROCEDURE [dbo].[DBOwnershipQuery]
	
@StartDate DateTime
, @EndDate DateTime

AS
BEGIN
SET NOCOUNT ON;

IF @EndDate IS NULL
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF @StartDate IS NULL
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

SELECT	CAST(DO.QueryDate AS Date) QueryDate
		, DO.CurrentOwner 
		, DO.[Database]
		, DO.SqlInstance
		, DO.TargetOwner
		, DO.OwnerMatch
FROM	dbo.DatabaseOwnership DO
WHERE	DO.OwnerMatch <> 1
		AND DO.QueryDate BETWEEN @StartDate AND @EndDate

END
GO
/****** Object:  StoredProcedure [dbo].[DiskSpaceQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-08
-- Description:	Returns information on disk
--				space for each SQL Instance
-- =============================================
CREATE PROCEDURE [dbo].[DiskSpaceQuery] 

@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

IF ISNULL(@EndDate,'1900-01-01') = '1900-01-01'
SET @EndDate = GETDATE()

IF ISNULL(@StartDate,'1900-01-01') = '1900-01-01'
SET @StartDate = DATEADD(DAY,-1,@EndDate)

SELECT	SI.ServerName
		, DS.DiskName
		, CASE
			WHEN DS.DiskName = 'C:\'
			THEN 'Operating System'
			ELSE DS.Label
			END AS Label
		, DS.Capacity
		, DS.FreeSpace
		, DS.Percentage PercentFree
		, CASE
			WHEN DS.Label = 'TempDB' AND DS.Percentage < 5
			THEN 1
			WHEN DS.Label <> 'TempDB' AND DS.Percentage < 20
			THEN 1
			ELSE 0
			END AS DiskWarning
FROM	info.DiskSpace DS
INNER JOIN	
		info.ServerInfo SI
			ON DS.ServerID = SI.ServerID
WHERE	DS.Date BETWEEN @StartDate AND @EndDate

END
GO
/****** Object:  StoredProcedure [dbo].[FailedJobHistory]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-05
-- Description:	Queries all servers for failed 
--				jobs within specified timeframe
-- =============================================
CREATE PROCEDURE [dbo].[FailedJobHistory] 

@FinalDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

DECLARE	@PreviousDate DateTime

-- Initialize Variables 
IF		ISNULL(@FinalDate,'1900-01-01') = '1900-01-01'
SET		@FinalDate = GETDATE()
ELSE	SET @FinalDate = @FinalDate

IF		ISNULL(@PreviousDate,'1900-01-01') = '1900-01-01'
SET		@PreviousDate = DATEADD(dd, -1, @FinalDate) -- Last 7 days  
ELSE	SET @PreviousDate = @PreviousDate 

-- Final Logic 
-- 000-WINSRV-RPT
SELECT   j.[name], 
         s.step_name, 
         h.step_id, 
		 CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) RunDateTime,
         h.sql_severity, 
         h.message, 
         h.server,
		 CASE
			WHEN h.run_status = 0 THEN 'Failed'
			WHEN h.run_status = 1 THEN 'Succeeded'
			WHEN h.run_status = 2 THEN 'Retry'
			WHEN h.run_status = 3 THEN 'Cancelled'
			WHEN h.run_status = 4 THEN 'In Progress'
			END AS RunStatus
FROM     msdb.dbo.sysjobhistory h 
         INNER JOIN msdb.dbo.sysjobs j 
           ON h.job_id = j.job_id 
         INNER JOIN msdb.dbo.sysjobsteps s 
           ON j.job_id = s.job_id
           AND h.step_id = s.step_id
WHERE    h.run_status <> 1 --Succeeded
		AND h.run_status <> 4 --In Progress
         AND CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) BETWEEN @PreviousDate AND @FinalDate 

UNION
--000-SRV-DB1
SELECT   j.[name], 
         s.step_name, 
         h.step_id, 
		 CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) RunDateTime,
         h.sql_severity, 
         h.message, 
         h.server,
		 CASE
			WHEN h.run_status = 0 THEN 'Failed'
			WHEN h.run_status = 1 THEN 'Succeeded'
			WHEN h.run_status = 2 THEN 'Retry'
			WHEN h.run_status = 3 THEN 'Cancelled'
			WHEN h.run_status = 4 THEN 'In Progress'
			END AS RunStatus
FROM     [000-SRV-DB1].msdb.dbo.sysjobhistory h 
         INNER JOIN [000-SRV-DB1].msdb.dbo.sysjobs j 
           ON h.job_id = j.job_id 
         INNER JOIN [000-SRV-DB1].msdb.dbo.sysjobsteps s 
           ON j.job_id = s.job_id
           AND h.step_id = s.step_id
WHERE    h.run_status <> 1 --Succeeded
		AND h.run_status <> 4 --In Progress
         AND CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) BETWEEN @PreviousDate AND @FinalDate 

UNION
--000-SRV-GP
SELECT   j.[name], 
         s.step_name, 
         h.step_id, 
		 CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) RunDateTime,
         h.sql_severity, 
         h.message, 
         h.server,
		 CASE
			WHEN h.run_status = 0 THEN 'Failed'
			WHEN h.run_status = 1 THEN 'Succeeded'
			WHEN h.run_status = 2 THEN 'Retry'
			WHEN h.run_status = 3 THEN 'Cancelled'
			WHEN h.run_status = 4 THEN 'In Progress'
			END AS RunStatus
FROM     [000-SRV-GP].msdb.dbo.sysjobhistory h 
         INNER JOIN [000-SRV-GP].msdb.dbo.sysjobs j 
           ON h.job_id = j.job_id 
         INNER JOIN [000-SRV-GP].msdb.dbo.sysjobsteps s 
           ON j.job_id = s.job_id
           AND h.step_id = s.step_id
WHERE    h.run_status <> 1 --Succeeded
		AND h.run_status <> 4 --In Progress
         AND CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) BETWEEN @PreviousDate AND @FinalDate 

UNION
--000-WINSRV-INT
SELECT   j.[name], 
         s.step_name, 
         h.step_id, 
		 CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) RunDateTime,
         h.sql_severity, 
         h.message, 
         h.server,
		 CASE
			WHEN h.run_status = 0 THEN 'Failed'
			WHEN h.run_status = 1 THEN 'Succeeded'
			WHEN h.run_status = 2 THEN 'Retry'
			WHEN h.run_status = 3 THEN 'Cancelled'
			WHEN h.run_status = 4 THEN 'In Progress'
			END AS RunStatus
FROM     [000-WINSRV-INT].msdb.dbo.sysjobhistory h 
         INNER JOIN [000-WINSRV-INT].msdb.dbo.sysjobs j 
           ON h.job_id = j.job_id 
         INNER JOIN [000-WINSRV-INT].msdb.dbo.sysjobsteps s 
           ON j.job_id = s.job_id
           AND h.step_id = s.step_id
WHERE    h.run_status <> 1 --Succeeded
		AND h.run_status <> 4 --In Progress
         AND CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) BETWEEN @PreviousDate AND @FinalDate 

UNION
--000-WINSRV-SWNT
SELECT   j.[name], 
         s.step_name, 
         h.step_id, 
		 CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) RunDateTime,
         h.sql_severity, 
         h.message, 
         h.server,
		 CASE
			WHEN h.run_status = 0 THEN 'Failed'
			WHEN h.run_status = 1 THEN 'Succeeded'
			WHEN h.run_status = 2 THEN 'Retry'
			WHEN h.run_status = 3 THEN 'Cancelled'
			WHEN h.run_status = 4 THEN 'In Progress'
			END AS RunStatus
FROM     [000-WINSRV-SWNT].msdb.dbo.sysjobhistory h 
         INNER JOIN [000-WINSRV-SWNT].msdb.dbo.sysjobs j 
           ON h.job_id = j.job_id 
         INNER JOIN [000-WINSRV-SWNT].msdb.dbo.sysjobsteps s 
           ON j.job_id = s.job_id
           AND h.step_id = s.step_id
WHERE    h.run_status <> 1 --Succeeded
		AND h.run_status <> 4 --In Progress
         AND CAST(msdb.dbo.agent_Datetime(h.run_date,h.run_time) AS DateTime2(0)) BETWEEN @PreviousDate AND @FinalDate

END
GO
/****** Object:  StoredProcedure [dbo].[FailedMaintenanceTasks]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-05
-- Description:	Returns Information on Failed
--				Maintenance Tasks on All Servers
-- =============================================
CREATE PROCEDURE [dbo].[FailedMaintenanceTasks] 
	
@FinalDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

DECLARE @PreviousDate DateTime

-- Initialize Variables 
IF		@FinalDate IS NULL
SET		@FinalDate = GETDATE()
ELSE	SET @FinalDate = @FinalDate

IF		@PreviousDate IS NULL
SET		@PreviousDate = DATEADD(dd, -1, @FinalDate) -- Last 7 days  
ELSE	SET @PreviousDate = @PreviousDate 

--000-WINSRV-RPT
SELECT	CL.ID
		, @@SERVERNAME ServerName
		, CL.DatabaseName
		, CL.CommandType
		, CL.Command
		, CL.StartTime
		, CL.ErrorNumber
		, CL.ErrorMessage
FROM	master.dbo.CommandLog CL
WHERE	CL.StartTime BETWEEN @PreviousDate AND @FinalDate
		AND CL.ErrorNumber <> 0

UNION

--000-SRV-GP
SELECT	CL.ID
		, CL.ServerName
		, CL.DatabaseName
		, CL.CommandType
		, CL.Command
		, CL.StartTime
		, CL.ErrorNumber
		, CL.ErrorMessage
FROM	(
		SELECT	*
		FROM	OPENQUERY([000-SRV-GP],
							'SELECT CL.ID
									, @@SERVERNAME ServerName
									, CL.DatabaseName
									, CL.CommandType
									, CL.Command
									, CL.StartTime
									, CL.ErrorNumber
									, CL.ErrorMessage
							FROM	master.dbo.CommandLog CL
							WHERE	CL.ErrorNumber <> 0'
				) 
		) AS CL
WHERE	CL.StartTime BETWEEN @PreviousDate AND @FinalDate

UNION

--000-SRV-DB1
SELECT	CL.ID
		, CL.ServerName
		, CL.DatabaseName
		, CL.CommandType
		, CL.Command
		, CL.StartTime
		, CL.ErrorNumber
		, CL.ErrorMessage
FROM	(
		SELECT	*
		FROM	OPENQUERY([000-SRV-DB1],
				'SELECT	CL.ID
						, @@SERVERNAME ServerName
						, CL.DatabaseName
						, CL.CommandType
						, CL.Command
						, CL.StartTime
						, CL.ErrorNumber
						, CL.ErrorMessage
				FROM	master.dbo.CommandLog CL
				WHERE	CL.ErrorNumber <> 0')
		) AS CL
WHERE	CL.StartTime BETWEEN @PreviousDate AND @FinalDate

UNION

--000-WINSRV-INT
SELECT	CL.ID
		, CL.ServerName
		, CL.DatabaseName
		, CL.CommandType
		, CL.Command
		, CL.StartTime
		, CL.ErrorNumber
		, CL.ErrorMessage
FROM	(
		SELECT	*
		FROM	OPENQUERY([000-WINSRV-INT],
				'SELECT	CL.ID
						, @@SERVERNAME ServerName
						, CL.DatabaseName
						, CL.CommandType
						, CL.Command
						, CL.StartTime
						, CL.ErrorNumber
						, CL.ErrorMessage
				FROM	master.dbo.CommandLog CL
				WHERE	CL.ErrorNumber <> 0')
		) AS CL
WHERE	CL.StartTime BETWEEN @PreviousDate AND @FinalDate

UNION

--000-WINSRV-SWNT
SELECT	CL.ID
		, CL.ServerName
		, CL.DatabaseName
		, CL.CommandType
		, CL.Command
		, CL.StartTime
		, CL.ErrorNumber
		, CL.ErrorMessage
FROM	(
		SELECT	*
		FROM	OPENQUERY([000-WINSRV-SWNT],
				'SELECT	CL.ID
						, @@SERVERNAME ServerName
						, CL.DatabaseName
						, CL.CommandType
						, CL.Command
						, CL.StartTime
						, CL.ErrorNumber
						, CL.ErrorMessage
				FROM	master.dbo.CommandLog CL
				WHERE	CL.ErrorNumber <> 0')
		) AS CL
WHERE	CL.StartTime BETWEEN @PreviousDate AND @FinalDate

END
GO
/****** Object:  StoredProcedure [dbo].[Get_FastestGrowingDisks]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:          Rob Sewell
-- Create date: 31/12/2015
-- Description:     Get the 5 fastest growing disks
-- =============================================
CREATE PROCEDURE [dbo].[Get_FastestGrowingDisks]
AS
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;

    -- Insert statements for procedure here
       WITH Percentage_cte AS (
    SELECT
        ROW_NUMBER() OVER(PARTITION BY ServerId,DiskName ORDER BY ServerId,[DiskName],Date) rn
             ,Date
       ,ServerID
      ,[DiskName]
      ,[Percentage]
      ,[Label]
      ,[Capacity]
      ,[FreeSpace]
    FROM  [Info].[DiskSpace]
       wHERE Date > DATEADD(Day, -2, GETDATE()) 
)

select top 5
c1.date
,(SELECT ServerName FROM info.ServerInfo WHERE ServerID = c1.ServerID) as Server
,c1.DiskName
,c1.[Label]
,c1.[Capacity]
,c1.[FreeSpace]
,c1.[Percentage]
,c2.FreeSpace - c1.FreeSpace as Growth
from Percentage_cte c1
join Percentage_cte c2
ON
c1.rn = c2.rn + 1 
AND c1.ServerId= c2.ServerId
AND c1.diskname = c2.diskname
ORDER BY Growth desc,c1.Percentage asc
END


GO
/****** Object:  StoredProcedure [dbo].[HistoryRemoval]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================
-- Author:		Jon Godwin
-- Create date: 2018-11-14
-- Description:	Job Deletes Old Data from ITReporting
-- ===================================================
CREATE PROCEDURE [dbo].[HistoryRemoval] 
AS
BEGIN
SET NOCOUNT ON;

DELETE	dbo.BAKFiles
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.DatabaseCollation
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.DatabaseCompatibility
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.DatabaseOwnership
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.DuplicateIndexes
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.InstanceBuild
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.InstanceTriggers
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.LoggedInServerUsers
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())

DELETE	dbo.LogSpaceHistory
WHERE	QueryDateTime <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.OrphanedFiles
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.ServerPendingUpdates
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.StartupParameters
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.SysConfigChecksum
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.SysConfigHistory
WHERE	CaptureDate <= DATEADD(DAY,-90,GETDATE())
;

DELETE	dbo.UnusedIndexes
WHERE	QueryDate <= DATEADD(DAY,-90,GETDATE())
;

END
GO
/****** Object:  StoredProcedure [dbo].[InstanceBuildQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-08
-- Description:	Returns info on the build number
--				for each SQL instance and if it's
--				in compliance or not.
-- =============================================
CREATE PROCEDURE [dbo].[InstanceBuildQuery] 

@StartDate DateTime NULL
, @EndDate DateTime NULL	

AS
BEGIN
SET NOCOUNT ON;

IF ISNULL(@EndDate,'1900-01-01') = '1900-01-01'
SET	@EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF ISNULL(@StartDate,'1900-01-01') = '1900-01-01'
SET @StartDate = DATEADD(dd,-1,@EndDate) 
ELSE SET @StartDate = @StartDate

SELECT	CAST(IB.QueryDate AS Date) QueryDate
		, IB.SqlInstance
		, IB.NameLevel
		, IB.SPLevel
		, IB.CULevel
		, IB.KBLevel
		, IB.Build
		, IB.BuildTarget
		, IB.Compliant
FROM	dbo.InstanceBuild IB
WHERE	IB.QueryDate BETWEEN @StartDate AND @EndDate

END
GO
/****** Object:  StoredProcedure [dbo].[LogSpaceQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-08
-- Description:	Returns information on log space
--				used per hours, instance and
--				database
-- =============================================
CREATE PROCEDURE [dbo].[LogSpaceQuery] 

@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

IF ISNULL(@EndDate,'1900-01-01') = '1900-01-01'
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF ISNULL(@StartDate,'1900-01-01') = '1900-01-01'
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

SELECT	CAST(LSH.QueryDateTime AS Date) QueryDate
		, LSH.Instance
		, LSH.DatabaseName
		, AVG(CAST(LSH.TotalLogSizeInBytes AS Float) / 1024000) AvgTotalLogSizeMB
		, MIN(CAST(LSH.TotalLogSizeInBytes AS Float) / 1024000) MinTotalLogSizeMB
		, MAX(CAST(LSH.TotalLogSizeInBytes AS Float) / 1024000) MaxTotalLogSizeMB
		, AVG(CAST(LSH.UsedLogSpaceInBytes AS Float) / 1024000) AvgUsedLogSpaceMB
		, MIN(CAST(LSH.UsedLogSpaceInBytes AS Float) / 1024000) MinUsedLogSpaceMB
		, MAX(CAST(LSH.UsedLogSpaceInBytes AS Float) / 1024000) MaxUsedLogSpaceMB
		, AVG(LSH.UsedLogSpaceInPercent) AvgUsedLogSpacePercent
		, MIN(LSH.UsedLogSpaceInPercent) MinUsedLogSpacePercent
		, MAX(LSH.UsedLogSpaceInPercent) MaxUsedLogSpacePercent
		, AVG(CAST(LSH.LogSpaceInBytesSinceLastBackup AS Float) / 1024000) AvgLogSpaceSinceLastBackupMB
		, MIN(CAST(LSH.LogSpaceInBytesSinceLastBackup AS Float) / 1024000) MinLogSpaceSinceLastBackupMB
		, MAX(CAST(LSH.LogSpaceInBytesSinceLastBackup AS Float) / 1024000) MaxLogSpaceSinceLastBackupMB
FROM	dbo.LogSpaceHistory LSH
WHERE	LSH.QueryDateTime BETWEEN @StartDate AND @EndDate
GROUP BY
		CAST(LSH.QueryDateTime AS Date)
		, LSH.Instance
		, LSH.DatabaseName
ORDER BY
		QueryDate DESC	
		, LSH.Instance ASC
		, LSH.DatabaseName ASC

END
GO
/****** Object:  StoredProcedure [dbo].[OrphanedFilesQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-08
-- Description:	Returns information on Orphaned
--				SQL Files on SQL Instances
-- =============================================
CREATE PROCEDURE [dbo].[OrphanedFilesQuery] 

@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

IF ISNULL(@EndDate,'1900-01-01') = '1900-01-01'
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF ISNULL(@StartDate,'1900-01-01') = '1900-01-01'
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

SELECT	OFI.QueryDate
		, OFI.ComputerName
		, OFI.InstanceName
		, OFI.SqlInstance
		, OFI.Filename
		, OFI.RemoteFilename
FROM	dbo.OrphanedFiles OFI
WHERE	OFI.QueryDate BETWEEN @StartDate AND @EndDate

END
GO
/****** Object:  StoredProcedure [dbo].[ServerLoginCount]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================
-- Author:		Jon Godwin
-- Create date: 2019-02-25
-- Description:	Stored Procedure Returns Information
--				on Server Logins by Hour of Day and
--				Day of Week Along with User Details
-- ==================================================
CREATE PROCEDURE [dbo].[ServerLoginCount]
	@StartDate Date
	, @EndDate Date

AS
BEGIN
SET NOCOUNT ON;

SELECT	DISTINCT
		LISU.ComputerName
		, CAST(LISU.QueryDate AS Date) QueryDate
		, CASE
			WHEN DATEPART(HOUR,LISU.QueryDate) < 10 
			THEN '0' + CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00'
			ELSE CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00' 
			END AS QueryHour
		, COUNT(DISTINCT LISU.UserName) DistinctUserCount
FROM	dbo.LoggedInServerUsers LISU
WHERE	CAST(LISU.QueryDate AS Date) BETWEEN @StartDate AND @EndDate
GROUP BY
		LISU.ComputerName
		, CAST(LISU.QueryDate AS Date)
		, CASE
			WHEN DATEPART(HOUR,LISU.QueryDate) < 10 
			THEN '0' + CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00'
			ELSE CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00' 
			END

END
GO
/****** Object:  StoredProcedure [dbo].[ServerLoginDetail]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Jon Godwin
-- Create date: 2019-02-25
-- Description:	Procedure returns details on users
--				on servers at specified times
-- ================================================
CREATE PROCEDURE [dbo].[ServerLoginDetail] 

@StartDate Date = NULL	
, @EndDate Date = NULL	
, @ComputerName Varchar(150) = NULL
, @UserName Varchar(150) = NULL

AS
BEGIN
SET NOCOUNT ON;

SELECT	LISU.ComputerName
		, LISU.UserName
		, CAST(LISU.QueryDate AS Date) QueryDate
		, CASE
			WHEN DATEPART(HOUR,LISU.QueryDate) < 10 
			THEN '0' + CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00'
			ELSE CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00' 
			END AS QueryHour
FROM	dbo.LoggedInServerUsers LISU
WHERE	CAST(LISU.QueryDate AS Date) BETWEEN @StartDate AND @EndDate
		AND (ISNULL(@ComputerName,'') = '' OR LISU.ComputerName = @ComputerName)
		AND (ISNULL(@UserName,'') = '' OR LISU.UserName = @UserName)
GROUP BY
		LISU.ComputerName
		, LISU.UserName
		, CAST(LISU.QueryDate AS Date)
		, CASE
			WHEN DATEPART(HOUR,LISU.QueryDate) < 10 
			THEN '0' + CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00'
			ELSE CAST(DATEPART(HOUR,LISU.QueryDate) AS Varchar(20)) + ':00' 
			END
			
END
GO
/****** Object:  StoredProcedure [dbo].[ServerUpdatesQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-08
-- Description:	Returns information regarding 
--				server updates
-- =============================================
CREATE PROCEDURE [dbo].[ServerUpdatesQuery]

@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

IF ISNULL(@EndDate,'1900-01-01') = '1900-01-01'
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF ISNULL(@StartDate,'1900-01-01') = '1900-01-01'
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

SELECT	CAST(SPU.QueryDate AS Date) QueryDate
		, UPPER(SPU.Computername) ComputerName
		, SPU.Title
		, SPU.KB
		, SPU.Url URL
		, SPU.IsDownloaded
FROM	dbo.ServerPendingUpdates SPU
WHERE	SPU.QueryDate BETWEEN @StartDate AND @EndDate

END
GO
/****** Object:  StoredProcedure [dbo].[StartupParametersQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-08
-- Description:	Returns information on any changes
--				to startup parameters for SQL
--				instances
-- ===============================================
CREATE PROCEDURE [dbo].[StartupParametersQuery]
	
@StartDate DateTime NULL
, @EndDate DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

DECLARE	@ComparisonDate DateTime

IF ISNULL(@EndDate,'1900-01-01') = '1900-01-01'
SET @EndDate = GETDATE()
ELSE SET @EndDate = @EndDate

IF ISNULL(@StartDate,'1900-01-01') = '1900-01-01'
SET @StartDate = DATEADD(DAY,-1,@EndDate)
ELSE SET @StartDate = @StartDate

IF ISNULL(@ComparisonDate,'1900-01-01') = '1900-01-01'
SET @ComparisonDate = DATEADD(DAY,-2,@EndDate)
ELSE SET @ComparisonDate = @ComparisonDate
;

WITH SUPQuery AS
	(
	SELECT	SP.ComputerName
		, SP.SqlInstance
		, SP.MasterData
		, SP.MasterLog
		, SP.ErrorLog
		, SP.TraceFlags
		, SP.ParameterString
FROM	dbo.StartupParameters SP
WHERE	SP.QueryDate BETWEEN @StartDate AND @EndDate
EXCEPT
SELECT	SP.ComputerName
		, SP.SqlInstance
		, SP.MasterData
		, SP.MasterLog
		, SP.ErrorLog
		, SP.TraceFlags
		, SP.ParameterString
FROM	dbo.StartupParameters SP
WHERE	SP.QueryDate BETWEEN @ComparisonDate AND @StartDate
	)

SELECT	@EndDate QueryDate
		, SUPQuery.ComputerName
		, SUPQuery.SqlInstance
		, SUPQuery.MasterData
		, SUPQuery.MasterLog
		, SUPQuery.ErrorLog
		, SUPQuery.TraceFlags
		, SUPQuery.ParameterString
FROM	SUPQuery

END
GO
/****** Object:  StoredProcedure [dbo].[SysConfigChecksumQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-07-5
-- Description:	Returns information on SysConfig
--				Checksum and if there are any 
--				differences between specified day
--				and previous day
-- =============================================
CREATE PROCEDURE [dbo].[SysConfigChecksumQuery] 

@Date DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

DECLARE	@PreviousDate DateTime

IF	@Date IS NULL
SET	@Date = GETDATE()

SET @PreviousDate = DATEADD(DAY,-2,@Date)
;

WITH cte_PivotTable AS
(
SELECT	PVT.QueryDate
		, PVT.[000-SRV-GP]
		, PVT.[000-SRV-DB1]		
		, PVT.[000-WINSRV-RPT]
		, PVT.[000-WINSRV-INT]
		, PVT.[000-WINSRV-SWNT]
FROM	(
		SELECT	CAST(SCC.QueryDate AS Date) AS QueryDate
				, SCC.Server
				, SCC.SysConfigSum
		FROM	dbo.SysConfigChecksum SCC
		WHERE	SCC.QueryDate BETWEEN @PreviousDate AND @Date
		) AS SCC
PIVOT
		(
		AVG(SysConfigSum)
		FOR	Server IN ("000-SRV-DB1","000-SRV-GP","000-WINSRV-RPT","000-WINSRV-INT","000-WINSRV-SWNT")
		) AS PVT
)

SELECT	cte_PivotTable.QueryDate
		, cte_PivotTable.[000-SRV-GP]
		, ISNULL((cte_PivotTable.[000-SRV-GP] - LAG(cte_PivotTable.[000-SRV-GP],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) GP_Difference
		, CASE
			WHEN ISNULL((cte_PivotTable.[000-SRV-GP] - LAG(cte_PivotTable.[000-SRV-GP],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) <> 0 THEN 1 ELSE 0
			END AS GP_DiffFlag
		, cte_PivotTable.[000-SRV-DB1]
		, ISNULL((cte_PivotTable.[000-SRV-DB1] - LAG(cte_PivotTable.[000-SRV-DB1],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) DB1_Difference
		, CASE
			WHEN ISNULL((cte_PivotTable.[000-SRV-DB1] - LAG(cte_PivotTable.[000-SRV-DB1],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) <> 0 THEN 1 ELSE 0
			END AS DB1_DiffFlag
		, cte_PivotTable.[000-WINSRV-RPT]
		, ISNULL((cte_PivotTable.[000-WINSRV-RPT] - LAG(cte_PivotTable.[000-WINSRV-RPT],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) RPT_Difference
		, CASE
			WHEN ISNULL((cte_PivotTable.[000-WINSRV-RPT] - LAG(cte_PivotTable.[000-WINSRV-RPT],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) <> 0 THEN 1 ELSE 0
			END AS RPT_DiffFlag
		, cte_PivotTable.[000-WINSRV-INT]
		, ISNULL((cte_PivotTable.[000-WINSRV-INT] - LAG(cte_PivotTable.[000-WINSRV-INT],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) INT_Difference
		, CASE
			WHEN ISNULL((cte_PivotTable.[000-WINSRV-INT] - LAG(cte_PivotTable.[000-WINSRV-INT],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) <> 0 THEN 1 ELSE 0
			END AS INT_DiffFlag
		, cte_PivotTable.[000-WINSRV-SWNT]
		, ISNULL((cte_PivotTable.[000-WINSRV-SWNT] - LAG(cte_PivotTable.[000-WINSRV-SWNT],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) SWNT_Difference
		, CASE
			WHEN ISNULL((cte_PivotTable.[000-WINSRV-SWNT] - LAG(cte_PivotTable.[000-WINSRV-SWNT],1) OVER (ORDER BY cte_PivotTable.QueryDate)),0) <> 0 THEN 1 ELSE 0
			END AS SWNT_DiffFlag
FROM	cte_PivotTable


END
GO
/****** Object:  StoredProcedure [dbo].[SysConfigHistoryQuery]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2019-02-29
-- Description:	Returns detail information on 
--				sysconfig changes day over day
-- =============================================
CREATE PROCEDURE [dbo].[SysConfigHistoryQuery]	 

@Date DateTime NULL

AS
BEGIN
SET NOCOUNT ON;

DECLARE @PreviousDate DateTime	

IF ISNULL(@Date,'1900-01-01') = '1900-01-01'
SET @Date = GETDATE()
ELSE SET @Date = @Date

IF ISNULL(@PreviousDate,'1900-01-01') = '1900-01-01'
SET @PreviousDate = DATEADD(DAY,-2,@Date)
;

WITH cte_PivotTable AS
(
SELECT	PVT.QueryDate
		, PVT.ConfigID
		, PVT.ConfigName
		, [PVT].[000-SRV-DB1]
		, PVT.[000-SRV-GP]
		, PVT.[000-WINSRV-RPT]
		, PVT.[000-WINSRV-INT]
		, PVT.[000-WINSRV-SWNT]
FROM	(
		SELECT	CAST(SCH.CaptureDate AS Date) AS QueryDate
				, SCH.ServerName
				, SCH.ConfigID
				, SCH.ConfigName
				, CAST(SCH.ConfigValue AS BigInt) ConfigValue
		FROM	dbo.SysConfigHistory SCH 
		WHERE	SCH.CaptureDate BETWEEN @PreviousDate AND @Date
		) AS SCC
PIVOT
		(
		AVG(ConfigValue)
		FOR	ServerName IN ("000-SRV-DB1","000-SRV-GP","000-WINSRV-RPT","000-WINSRV-INT","000-WINSRV-SWNT")
		) AS PVT
)

SELECT	CPT.QueryDate
		, CPT.ConfigID
		, CPT.ConfigName
		, CPT.[000-SRV-DB1]
		, CASE WHEN CPT.QueryDate = @Date
			THEN CPT.[000-SRV-DB1] - LAG(CPT.[000-SRV-DB1],1) OVER (ORDER BY CPT.QueryDate)
			ELSE 0
			END AS DB1_ConfigDiff 
		, CPT.[000-SRV-GP]
		, CASE WHEN CPT.QueryDate = @Date
			THEN CPT.[000-SRV-GP] - LAG(CPT.[000-SRV-GP],1) OVER (ORDER BY CPT.QueryDate)
			ELSE 0
			END AS GP_ConfigDiff 
		, CPT.[000-WINSRV-RPT]
		, CASE WHEN CPT.QueryDate = @Date
			THEN CPT.[000-WINSRV-RPT] - LAG(CPT.[000-WINSRV-RPT],1) OVER (ORDER BY CPT.QueryDate)
			ELSE 0
			END AS RPT_ConfigDiff 
		, CPT.[000-WINSRV-INT]
		, CASE WHEN CPT.QueryDate = @Date
			THEN CPT.[000-WINSRV-INT] - LAG(CPT.[000-WINSRV-INT],1) OVER (ORDER BY CPT.QueryDate)
			ELSE 0
			END AS INT_ConfigDiff 
		, CPT.[000-WINSRV-SWNT]
		, CASE WHEN CPT.QueryDate = @Date
			THEN CPT.[000-WINSRV-SWNT] - LAG(CPT.[000-WINSRV-SWNT],1) OVER (ORDER BY CPT.QueryDate)
			ELSE 0
			END AS SWNT_ConfigDiff FROM	cte_PivotTable CPT
ORDER BY
		CPT.ConfigID ASC	
		, CPT.QueryDate DESC	

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSpinsReportParameters]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================
-- Author:		Ed Wax
-- Create date: 2020-02-17
-- Description:	Update the SPINS report parameters for the next run
-- =================================================================
CREATE PROCEDURE [dbo].[UpdateSpinsReportParameters]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SET DATEFIRST 1
declare  @OldStartDate varchar(30),
@OldEndDate varchar(30),
@StartDate datetime,
@EndDate datetime,
@StartIndex int,
@EndIndex INT,
@allStoresSpinsSubscriptionId UNIQUEIDENTIFIER,
@nielsonSpinsSubscriptionId UNIQUEIDENTIFIER;

SET @allStoresSpinsSubscriptionId = ( SELECT TOP(1) s.SubscriptionID FROM ReportServer.dbo.Subscriptions s WHERE s.Description LIKE 'spins all%' )
SET @nielsonSpinsSubscriptionId = ( SELECT TOP(1) s.SubscriptionID FROM ReportServer.dbo.Subscriptions s WHERE s.Description LIKE 'Nielson spins%' )


BEGIN TRANSACTION
	SELECT * FROM ReportServer.dbo.Subscriptions WHERE SubscriptionID = @allStoresSpinsSubscriptionId;  -- Debug
	-- StartDate is Monday
	-- EndDate is Sunday (due to the timestamping and the query logic, this results in Sunday's sales capturing)
	SELECT @StartDate = CONVERT(VARCHAR(10), DATEADD(DAY, 1-DATEPART(WEEKDAY, cast(getDate() as datetime)-7), cast(getDate() as datetime)-7), 101)
	SELECT @EndDate = convert(varchar(10), dateadd(dd, 6, @StartDate), 101)

	select @StartIndex = charindex('StartDate</Name><Value>', [Parameters]) + len('StartDate</Name><Value>'),
	@EndIndex = CHARINDEX('</Value>', [Parameters], charindex('StartDate</Name><Value>', [Parameters]) + len('StartDate</Name><Value>'))
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @allStoresSpinsSubscriptionId

	select @OldStartDate = substring([Parameters], @StartIndex, @EndIndex-@StartIndex)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @allStoresSpinsSubscriptionId

	select @StartIndex = charindex('EndDate</Name><Value>', [Parameters]) + len('EndDate</Name><Value>'),
	@EndIndex = CHARINDEX('</Value>', [Parameters], charindex('EndDate</Name><Value>', [Parameters]) + len('EndDate</Name><Value>'))
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @allStoresSpinsSubscriptionId

	select @OldEndDate = substring([Parameters], @StartIndex, @EndIndex-@StartIndex)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @allStoresSpinsSubscriptionId

	update ReportServer.dbo.Subscriptions set [Parameters] =  cast(REPLACE(cast([Parameters] as nvarchar(max)), @OldStartDate, convert(varchar(90), @StartDate, 101) + ' ' + convert(varchar(90), @StartDate, 108)) as ntext)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @allStoresSpinsSubscriptionId

	update ReportServer.dbo.Subscriptions set [Parameters] =  cast(REPLACE(cast([Parameters] as nvarchar(max)), @OldEndDate, convert(varchar(90), @EndDate, 101) + ' ' + convert(varchar(90), @EndDate, 108)) as ntext)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @allStoresSpinsSubscriptionId

	SELECT * FROM ReportServer.dbo.Subscriptions WHERE SubscriptionID = @allStoresSpinsSubscriptionId; -- Debug

	SELECT * FROM ReportServer.dbo.Subscriptions WHERE SubscriptionID = @nielsonSpinsSubscriptionId  -- Debug

	select @StartIndex = charindex('StartDate</Name><Value>', [Parameters]) + len('StartDate</Name><Value>'),
	@EndIndex = CHARINDEX('</Value>', [Parameters], charindex('StartDate</Name><Value>', [Parameters]) + len('StartDate</Name><Value>'))
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @nielsonSpinsSubscriptionId

	select @OldStartDate = substring([Parameters], @StartIndex, @EndIndex-@StartIndex)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @nielsonSpinsSubscriptionId

	select @StartIndex = charindex('EndDate</Name><Value>', [Parameters]) + len('EndDate</Name><Value>'),
	@EndIndex = CHARINDEX('</Value>', [Parameters], charindex('EndDate</Name><Value>', [Parameters]) + len('EndDate</Name><Value>'))
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @nielsonSpinsSubscriptionId

	select @OldEndDate = substring([Parameters], @StartIndex, @EndIndex-@StartIndex)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @nielsonSpinsSubscriptionId

	update ReportServer.dbo.Subscriptions set [Parameters] =  cast(REPLACE(cast([Parameters] as nvarchar(max)), @OldStartDate, convert(varchar(90), @StartDate, 101) + ' ' + convert(varchar(90), @StartDate, 108)) as ntext)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @nielsonSpinsSubscriptionId

	update ReportServer.dbo.Subscriptions set [Parameters] =  cast(REPLACE(cast([Parameters] as nvarchar(max)), @OldEndDate, convert(varchar(90), @EndDate, 101) + ' ' + convert(varchar(90), @EndDate, 108)) as ntext)
	from ReportServer.dbo.Subscriptions
	where SubscriptionID = @nielsonSpinsSubscriptionId

	SELECT 'after update (nielson)', * FROM ReportServer.dbo.Subscriptions WHERE SubscriptionID = @nielsonSpinsSubscriptionId  -- Debug

ROLLBACK
--COMMIT

SELECT 'after rollback', * FROM ReportServer.dbo.Subscriptions WHERE SubscriptionID = @allStoresSpinsSubscriptionId;  -- Debug
SELECT 'after rollback  (nielson)', * FROM ReportServer.dbo.Subscriptions WHERE SubscriptionID = @nielsonSpinsSubscriptionId  -- Debug
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ClientDatabaseLookup]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ClientDatabaseLookup]
          @TVP dbo.tvp_ClientDatabaseLookup READONLY
          AS
          BEGIN
          INSERT INTO dbo.ClientDatabaseLookup ([ClientID],[DatabaseID],[InstanceID],[Notes])
          SELECT [ClientID],[DatabaseID],[InstanceID],[Notes] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[ClientID] = [b].[ClientID],[a].[DatabaseID] = [b].[DatabaseID],[a].[InstanceID] = [b].[InstanceID],[a].[Notes] = [b].[Notes]
          FROM @tvp b JOIN dbo.ClientDatabaseLookup a on a.ClientInstanceLookup = b.ClientInstanceLookup
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [dbo].[usp_Clients]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Clients]
          @TVP dbo.tvp_Clients READONLY
          AS
          BEGIN
          INSERT INTO dbo.Clients ([ClientName],[External])
          SELECT [ClientName],[External] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[ClientName] = [b].[ClientName],[a].[External] = [b].[External]
          FROM @tvp b JOIN dbo.Clients a on a.ClientID = b.ClientID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [dbo].[usp_InstanceList]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InstanceList]
          @TVP dbo.tvp_InstanceList READONLY
          AS
          BEGIN
          INSERT INTO dbo.InstanceList ([ServerID],[Name],[ComputerName],[ServerName],[InstanceName],[isClustered],[Port],[Inactive],[Environment],[Location],[NotContactable])
          SELECT [ServerID],[Name],[ComputerName],[ServerName],[InstanceName],[isClustered],[Port],[Inactive],[Environment],[Location],[NotContactable] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[ServerID] = [b].[ServerID],[a].[Name] = [b].[Name],[a].[ComputerName] = [b].[ComputerName],[a].[ServerName] = [b].[ServerName],[a].[InstanceName] = [b].[InstanceName],[a].[isClustered] = [b].[isClustered],[a].[Port] = [b].[Port],[a].[Inactive] = [b].[Inactive],[a].[Environment] = [b].[Environment],[a].[Location] = [b].[Location],[a].[NotContactable] = [b].[NotContactable]
          FROM @tvp b JOIN dbo.InstanceList a on a.InstanceID = b.InstanceID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_AgentJobDetail]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_AgentJobDetail]
          @TVP info.tvp_AgentJobDetail READONLY
          AS
          BEGIN
          INSERT INTO info.AgentJobDetail ([DateCreated],[InstanceID],[Category],[JobName],[Description],[IsEnabled],[Status],[LastRunTime],[Outcome],[Date])
          SELECT [DateCreated],[InstanceID],[Category],[JobName],[Description],[IsEnabled],[Status],[LastRunTime],[Outcome],[Date] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[DateCreated] = [b].[DateCreated],[a].[InstanceID] = [b].[InstanceID],[a].[Category] = [b].[Category],[a].[JobName] = [b].[JobName],[a].[Description] = [b].[Description],[a].[IsEnabled] = [b].[IsEnabled],[a].[Status] = [b].[Status],[a].[LastRunTime] = [b].[LastRunTime],[a].[Outcome] = [b].[Outcome],[a].[Date] = [b].[Date]
          FROM @tvp b JOIN info.AgentJobDetail a on a.AgentJobDetailID = b.AgentJobDetailID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_AgentJobServer]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_AgentJobServer]
          @TVP info.tvp_AgentJobServer READONLY
          AS
          BEGIN
          INSERT INTO info.AgentJobServer ([Date],[InstanceID],[NumberOfJobs],[SuccessfulJobs],[FailedJobs],[DisabledJobs],[UnknownJobs])
          SELECT [Date],[InstanceID],[NumberOfJobs],[SuccessfulJobs],[FailedJobs],[DisabledJobs],[UnknownJobs] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[Date] = [b].[Date],[a].[InstanceID] = [b].[InstanceID],[a].[NumberOfJobs] = [b].[NumberOfJobs],[a].[SuccessfulJobs] = [b].[SuccessfulJobs],[a].[FailedJobs] = [b].[FailedJobs],[a].[DisabledJobs] = [b].[DisabledJobs],[a].[UnknownJobs] = [b].[UnknownJobs]
          FROM @tvp b JOIN info.AgentJobServer a on a.AgentJobServerID = b.AgentJobServerID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_Alerts]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_Alerts]
          @TVP info.tvp_Alerts READONLY
          AS
          BEGIN
          INSERT INTO info.Alerts ([CheckDate],[InstanceID],[Name],[Category],[DatabaseID],[DelayBetweenResponses],[EventDescriptionKeyword],[EventSource],[HasNotification],[IncludeEventDescription],[IsEnabled],[AgentJobDetailID],[LastOccurrenceDate],[LastResponseDate],[MessageID],[NotificationMessage],[OccurrenceCount],[PerformanceCondition],[Severity],[WmiEventNamespace],[WmiEventQuery])
          SELECT [CheckDate],[InstanceID],[Name],[Category],[DatabaseID],[DelayBetweenResponses],[EventDescriptionKeyword],[EventSource],[HasNotification],[IncludeEventDescription],[IsEnabled],[AgentJobDetailID],[LastOccurrenceDate],[LastResponseDate],[MessageID],[NotificationMessage],[OccurrenceCount],[PerformanceCondition],[Severity],[WmiEventNamespace],[WmiEventQuery] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[CheckDate] = [b].[CheckDate],[a].[InstanceID] = [b].[InstanceID],[a].[Name] = [b].[Name],[a].[Category] = [b].[Category],[a].[DatabaseID] = [b].[DatabaseID],[a].[DelayBetweenResponses] = [b].[DelayBetweenResponses],[a].[EventDescriptionKeyword] = [b].[EventDescriptionKeyword],[a].[EventSource] = [b].[EventSource],[a].[HasNotification] = [b].[HasNotification],[a].[IncludeEventDescription] = [b].[IncludeEventDescription],[a].[IsEnabled] = [b].[IsEnabled],[a].[AgentJobDetailID] = [b].[AgentJobDetailID],[a].[LastOccurrenceDate] = [b].[LastOccurrenceDate],[a].[LastResponseDate] = [b].[LastResponseDate],[a].[MessageID] = [b].[MessageID],[a].[NotificationMessage] = [b].[NotificationMessage],[a].[OccurrenceCount] = [b].[OccurrenceCount],[a].[PerformanceCondition] = [b].[PerformanceCondition],[a].[Severity] = [b].[Severity],[a].[WmiEventNamespace] = [b].[WmiEventNamespace],[a].[WmiEventQuery] = [b].[WmiEventQuery]
          FROM @tvp b JOIN info.Alerts a on a.AlertsID = b.AlertsID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_Databases]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_Databases]
          @TVP info.tvp_Databases READONLY
          AS
          BEGIN
          INSERT INTO info.Databases ([InstanceID],[Name],[DateAdded],[DateChecked],[AutoClose],[AutoCreateStatisticsEnabled],[AutoShrink],[AutoUpdateStatisticsEnabled],[AvailabilityDatabaseSynchronizationState],[AvailabilityGroupName],[CaseSensitive],[Collation],[CompatibilityLevel],[CreateDate],[DataSpaceUsageKB],[EncryptionEnabled],[IndexSpaceUsageKB],[IsAccessible],[IsFullTextEnabled],[IsMirroringEnabled],[IsParameterizationForced],[IsReadCommittedSnapshotOn],[IsSystemObject],[IsUpdateable],[LastBackupDate],[LastDifferentialBackupDate],[LastLogBackupDate],[Owner],[PageVerify],[ReadOnly],[RecoveryModel],[ReplicationOptions],[SizeMB],[SnapshotIsolationState],[SpaceAvailableKB],[Status],[TargetRecoveryTime],[InActive],[LastRead],[LastWrite],[LastReboot],[LastDBCCDate])
          SELECT [InstanceID],[Name],[DateAdded],[DateChecked],[AutoClose],[AutoCreateStatisticsEnabled],[AutoShrink],[AutoUpdateStatisticsEnabled],[AvailabilityDatabaseSynchronizationState],[AvailabilityGroupName],[CaseSensitive],[Collation],[CompatibilityLevel],[CreateDate],[DataSpaceUsageKB],[EncryptionEnabled],[IndexSpaceUsageKB],[IsAccessible],[IsFullTextEnabled],[IsMirroringEnabled],[IsParameterizationForced],[IsReadCommittedSnapshotOn],[IsSystemObject],[IsUpdateable],[LastBackupDate],[LastDifferentialBackupDate],[LastLogBackupDate],[Owner],[PageVerify],[ReadOnly],[RecoveryModel],[ReplicationOptions],[SizeMB],[SnapshotIsolationState],[SpaceAvailableKB],[Status],[TargetRecoveryTime],[InActive],[LastRead],[LastWrite],[LastReboot],[LastDBCCDate] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[InstanceID] = [b].[InstanceID],[a].[Name] = [b].[Name],[a].[DateAdded] = [b].[DateAdded],[a].[DateChecked] = [b].[DateChecked],[a].[AutoClose] = [b].[AutoClose],[a].[AutoCreateStatisticsEnabled] = [b].[AutoCreateStatisticsEnabled],[a].[AutoShrink] = [b].[AutoShrink],[a].[AutoUpdateStatisticsEnabled] = [b].[AutoUpdateStatisticsEnabled],[a].[AvailabilityDatabaseSynchronizationState] = [b].[AvailabilityDatabaseSynchronizationState],[a].[AvailabilityGroupName] = [b].[AvailabilityGroupName],[a].[CaseSensitive] = [b].[CaseSensitive],[a].[Collation] = [b].[Collation],[a].[CompatibilityLevel] = [b].[CompatibilityLevel],[a].[CreateDate] = [b].[CreateDate],[a].[DataSpaceUsageKB] = [b].[DataSpaceUsageKB],[a].[EncryptionEnabled] = [b].[EncryptionEnabled],[a].[IndexSpaceUsageKB] = [b].[IndexSpaceUsageKB],[a].[IsAccessible] = [b].[IsAccessible],[a].[IsFullTextEnabled] = [b].[IsFullTextEnabled],[a].[IsMirroringEnabled] = [b].[IsMirroringEnabled],[a].[IsParameterizationForced] = [b].[IsParameterizationForced],[a].[IsReadCommittedSnapshotOn] = [b].[IsReadCommittedSnapshotOn],[a].[IsSystemObject] = [b].[IsSystemObject],[a].[IsUpdateable] = [b].[IsUpdateable],[a].[LastBackupDate] = [b].[LastBackupDate],[a].[LastDifferentialBackupDate] = [b].[LastDifferentialBackupDate],[a].[LastLogBackupDate] = [b].[LastLogBackupDate],[a].[Owner] = [b].[Owner],[a].[PageVerify] = [b].[PageVerify],[a].[ReadOnly] = [b].[ReadOnly],[a].[RecoveryModel] = [b].[RecoveryModel],[a].[ReplicationOptions] = [b].[ReplicationOptions],[a].[SizeMB] = [b].[SizeMB],[a].[SnapshotIsolationState] = [b].[SnapshotIsolationState],[a].[SpaceAvailableKB] = [b].[SpaceAvailableKB],[a].[Status] = [b].[Status],[a].[TargetRecoveryTime] = [b].[TargetRecoveryTime],[a].[InActive] = [b].[InActive],[a].[LastRead] = [b].[LastRead],[a].[LastWrite] = [b].[LastWrite],[a].[LastReboot] = [b].[LastReboot],[a].[LastDBCCDate] = [b].[LastDBCCDate]
          FROM @tvp b JOIN info.Databases a on a.DatabaseID = b.DatabaseID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_DiskSpace]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_DiskSpace]
          @TVP info.tvp_DiskSpace READONLY
          AS
          BEGIN
          INSERT INTO info.DiskSpace ([Date],[ServerID],[DiskName],[Label],[Capacity],[FreeSpace],[Percentage])
          SELECT [Date],[ServerID],[DiskName],[Label],[Capacity],[FreeSpace],[Percentage] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[Date] = [b].[Date],[a].[ServerID] = [b].[ServerID],[a].[DiskName] = [b].[DiskName],[a].[Label] = [b].[Label],[a].[Capacity] = [b].[Capacity],[a].[FreeSpace] = [b].[FreeSpace],[a].[Percentage] = [b].[Percentage]
          FROM @tvp b JOIN info.DiskSpace a on a.DiskSpaceID = b.DiskSpaceID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_HistoricalDBSize]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_HistoricalDBSize]
          @TVP info.tvp_HistoricalDBSize READONLY
          AS
          BEGIN
          INSERT INTO info.HistoricalDBSize ([DatabaseID],[InstanceID],[Name],[DateChecked],[SizeMB],[SpaceAvailableKB])
          SELECT [DatabaseID],[InstanceID],[Name],[DateChecked],[SizeMB],[SpaceAvailableKB] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[DatabaseID] = [b].[DatabaseID],[a].[InstanceID] = [b].[InstanceID],[a].[Name] = [b].[Name],[a].[DateChecked] = [b].[DateChecked],[a].[SizeMB] = [b].[SizeMB],[a].[SpaceAvailableKB] = [b].[SpaceAvailableKB]
          FROM @tvp b JOIN info.HistoricalDBSize a on a.DatabaseSizeHistoryID = b.DatabaseSizeHistoryID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_LogFileErrorMessages]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_LogFileErrorMessages]
          @TVP info.tvp_LogFileErrorMessages READONLY
          AS
          BEGIN
          INSERT INTO info.LogFileErrorMessages ([Date],[FileName],[ErrorMsg],[Line],[Matches])
          SELECT [Date],[FileName],[ErrorMsg],[Line],[Matches] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[Date] = [b].[Date],[a].[FileName] = [b].[FileName],[a].[ErrorMsg] = [b].[ErrorMsg],[a].[Line] = [b].[Line],[a].[Matches] = [b].[Matches]
          FROM @tvp b JOIN info.LogFileErrorMessages a on a.LogFileErrorMessagesID = b.LogFileErrorMessagesID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_ServerInfo]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_ServerInfo]
          @TVP info.tvp_ServerInfo READONLY
          AS
          BEGIN
          INSERT INTO info.ServerInfo ([DateChecked],[ServerName],[DNSHostName],[Domain],[OperatingSystem],[NoProcessors],[IPAddress],[RAM])
          SELECT [DateChecked],[ServerName],[DNSHostName],[Domain],[OperatingSystem],[NoProcessors],[IPAddress],[RAM] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[DateChecked] = [b].[DateChecked],[a].[ServerName] = [b].[ServerName],[a].[DNSHostName] = [b].[DNSHostName],[a].[Domain] = [b].[Domain],[a].[OperatingSystem] = [b].[OperatingSystem],[a].[NoProcessors] = [b].[NoProcessors],[a].[IPAddress] = [b].[IPAddress],[a].[RAM] = [b].[RAM]
          FROM @tvp b JOIN info.ServerInfo a on a.ServerID = b.ServerID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_SQLInfo]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_SQLInfo]
          @TVP info.tvp_SQLInfo READONLY
          AS
          BEGIN
          INSERT INTO info.SQLInfo ([DateChecked],[DateAdded],[ServerName],[InstanceName],[SQLVersionString],[SQLVersion],[ServicePack],[Edition],[ServerType],[Collation],[IsHADREnabled],[SQLServiceAccount],[SQLService],[SQLServiceStartMode],[BAckupDirectory],[BrowserAccount],[BrowserStartMode],[IsSQLClustered],[ClusterName],[ClusterQuorumstate],[ClusterQuorumType],[C2AuditMode],[CostThresholdForParallelism],[MaxDegreeOfParallelism],[DBMailEnabled],[DefaultBackupCComp],[FillFactor],[MaxMem],[MinMem],[RemoteDacEnabled],[XPCmdShellEnabled],[CommonCriteriaComplianceEnabled],[DefaultFile],[DefaultLog],[HADREndpointPort],[ErrorLogPath],[InstallDataDirectory],[InstallSharedDirectory],[IsCaseSensitive],[IsFullTextInstalled],[LinkedServer],[LoginMode],[MasterDBLogPath],[MasterDBPath],[NamedPipesEnabled],[OptimizeAdhocWorkloads],[InstanceID],[AGListener],[AGs],[AGListenerPort],[AGListenerIPs],[AgentServiceAccount],[AgentServiceStartMode])
          SELECT [DateChecked],[DateAdded],[ServerName],[InstanceName],[SQLVersionString],[SQLVersion],[ServicePack],[Edition],[ServerType],[Collation],[IsHADREnabled],[SQLServiceAccount],[SQLService],[SQLServiceStartMode],[BAckupDirectory],[BrowserAccount],[BrowserStartMode],[IsSQLClustered],[ClusterName],[ClusterQuorumstate],[ClusterQuorumType],[C2AuditMode],[CostThresholdForParallelism],[MaxDegreeOfParallelism],[DBMailEnabled],[DefaultBackupCComp],[FillFactor],[MaxMem],[MinMem],[RemoteDacEnabled],[XPCmdShellEnabled],[CommonCriteriaComplianceEnabled],[DefaultFile],[DefaultLog],[HADREndpointPort],[ErrorLogPath],[InstallDataDirectory],[InstallSharedDirectory],[IsCaseSensitive],[IsFullTextInstalled],[LinkedServer],[LoginMode],[MasterDBLogPath],[MasterDBPath],[NamedPipesEnabled],[OptimizeAdhocWorkloads],[InstanceID],[AGListener],[AGs],[AGListenerPort],[AGListenerIPs],[AgentServiceAccount],[AgentServiceStartMode] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[DateChecked] = [b].[DateChecked],[a].[DateAdded] = [b].[DateAdded],[a].[ServerName] = [b].[ServerName],[a].[InstanceName] = [b].[InstanceName],[a].[SQLVersionString] = [b].[SQLVersionString],[a].[SQLVersion] = [b].[SQLVersion],[a].[ServicePack] = [b].[ServicePack],[a].[Edition] = [b].[Edition],[a].[ServerType] = [b].[ServerType],[a].[Collation] = [b].[Collation],[a].[IsHADREnabled] = [b].[IsHADREnabled],[a].[SQLServiceAccount] = [b].[SQLServiceAccount],[a].[SQLService] = [b].[SQLService],[a].[SQLServiceStartMode] = [b].[SQLServiceStartMode],[a].[BAckupDirectory] = [b].[BAckupDirectory],[a].[BrowserAccount] = [b].[BrowserAccount],[a].[BrowserStartMode] = [b].[BrowserStartMode],[a].[IsSQLClustered] = [b].[IsSQLClustered],[a].[ClusterName] = [b].[ClusterName],[a].[ClusterQuorumstate] = [b].[ClusterQuorumstate],[a].[ClusterQuorumType] = [b].[ClusterQuorumType],[a].[C2AuditMode] = [b].[C2AuditMode],[a].[CostThresholdForParallelism] = [b].[CostThresholdForParallelism],[a].[MaxDegreeOfParallelism] = [b].[MaxDegreeOfParallelism],[a].[DBMailEnabled] = [b].[DBMailEnabled],[a].[DefaultBackupCComp] = [b].[DefaultBackupCComp],[a].[FillFactor] = [b].[FillFactor],[a].[MaxMem] = [b].[MaxMem],[a].[MinMem] = [b].[MinMem],[a].[RemoteDacEnabled] = [b].[RemoteDacEnabled],[a].[XPCmdShellEnabled] = [b].[XPCmdShellEnabled],[a].[CommonCriteriaComplianceEnabled] = [b].[CommonCriteriaComplianceEnabled],[a].[DefaultFile] = [b].[DefaultFile],[a].[DefaultLog] = [b].[DefaultLog],[a].[HADREndpointPort] = [b].[HADREndpointPort],[a].[ErrorLogPath] = [b].[ErrorLogPath],[a].[InstallDataDirectory] = [b].[InstallDataDirectory],[a].[InstallSharedDirectory] = [b].[InstallSharedDirectory],[a].[IsCaseSensitive] = [b].[IsCaseSensitive],[a].[IsFullTextInstalled] = [b].[IsFullTextInstalled],[a].[LinkedServer] = [b].[LinkedServer],[a].[LoginMode] = [b].[LoginMode],[a].[MasterDBLogPath] = [b].[MasterDBLogPath],[a].[MasterDBPath] = [b].[MasterDBPath],[a].[NamedPipesEnabled] = [b].[NamedPipesEnabled],[a].[OptimizeAdhocWorkloads] = [b].[OptimizeAdhocWorkloads],[a].[InstanceID] = [b].[InstanceID],[a].[AGListener] = [b].[AGListener],[a].[AGs] = [b].[AGs],[a].[AGListenerPort] = [b].[AGListenerPort],[a].[AGListenerIPs] = [b].[AGListenerIPs],[a].[AgentServiceAccount] = [b].[AgentServiceAccount],[a].[AgentServiceStartMode] = [b].[AgentServiceStartMode]
          FROM @tvp b JOIN info.SQLInfo a on a.SQLInfoID = b.SQLInfoID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_SQLServerBuilds]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_SQLServerBuilds]
          @TVP info.tvp_SQLServerBuilds READONLY
          AS
          BEGIN
          INSERT INTO info.SQLServerBuilds ([Build],[SQLSERVERExeBuild],[Fileversion],[Q],[KB],[KBDescription],[ReleaseDate],[New])
          SELECT [Build],[SQLSERVERExeBuild],[Fileversion],[Q],[KB],[KBDescription],[ReleaseDate],[New] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[Build] = [b].[Build],[a].[SQLSERVERExeBuild] = [b].[SQLSERVERExeBuild],[a].[Fileversion] = [b].[Fileversion],[a].[Q] = [b].[Q],[a].[KB] = [b].[KB],[a].[KBDescription] = [b].[KBDescription],[a].[ReleaseDate] = [b].[ReleaseDate],[a].[New] = [b].[New]
          FROM @tvp b JOIN info.SQLServerBuilds a on a.SQLbuildID = b.SQLbuildID
          WHERE [U] = 1
        END
GO
/****** Object:  StoredProcedure [info].[usp_SuspectPages]    Script Date: 10/8/2021 10:17:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [info].[usp_SuspectPages]
          @TVP info.tvp_SuspectPages READONLY
          AS
          BEGIN
          INSERT INTO info.SuspectPages ([DatabaseID],[DateChecked],[FileName],[Page_id],[EventType],[Error_count],[last_update_date],[InstanceID])
          SELECT [DatabaseID],[DateChecked],[FileName],[Page_id],[EventType],[Error_count],[last_update_date],[InstanceID] FROM @TVP WHERE [U] = 0
								
          UPDATE a SET
          [a].[DatabaseID] = [b].[DatabaseID],[a].[DateChecked] = [b].[DateChecked],[a].[FileName] = [b].[FileName],[a].[Page_id] = [b].[Page_id],[a].[EventType] = [b].[EventType],[a].[Error_count] = [b].[Error_count],[a].[last_update_date] = [b].[last_update_date],[a].[InstanceID] = [b].[InstanceID]
          FROM @tvp b JOIN info.SuspectPages a on a.SuspectPageID = b.SuspectPageID
          WHERE [U] = 1
        END
GO
EXEC [ITReporting].sys.sp_addextendedproperty @name=N'dbareports version', @value=N'0.0.4' 
GO
EXEC [ITReporting].sys.sp_addextendedproperty @name=N'dbareports logfilefolder', @value=N'M:\MSSQL.MSSQLSERVER.BAK\dbareports\logs' 
GO
EXEC [ITReporting].sys.sp_addextendedproperty @name=N'dbareports installpath', @value=N'M:\MSSQL.MSSQLSERVER.BAK\dbareports' 
GO
USE [master]
GO
ALTER DATABASE [ITReporting] SET  READ_WRITE 
GO
