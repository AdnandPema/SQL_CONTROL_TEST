SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [dbo].[FilterKlient]
as

select 
'1' as Id,
'M01' as Kodi,
'Market Place' as Emri

union all

select 
'2' as Id,
'M02' as Kodi,
'NuNuNa' as Emri

union all

select 
'3' as Id,
'M03' as Kodi,
'Souvenier' as Emri

union all

select 
'4' as Id,
'B01' as Kodi,
'Pascucci' as Emri

union all

select 
'5' as Id,
'B02' as Kodi,
'Segafredo' as Emri
GO
