SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[logical_Sys_ItemCategory]
AS
select 1 as  [Item Category Code],'pershkrim'description
--select distinct [Item Category Code],description 
--from (

--select distinct [Item Category Code],ISNULL(b.Description,' ') Description
--                                                            from LogiPOS.dbo.Item 
--                                                            left join 
--                                                            (
--                                                            select code,[description]
--                                                            from LogiPOS.dbo.ItemCategory)as b 
--                                                            on b.code = LogiPOS.dbo.Item.[Item Category Code]
--                                                            where LogiPOS.dbo.item.[Item Category Code] <> ' '

--)a

GO
