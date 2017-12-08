SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE view [dbo].[FilterKategori]

as

select 


[Item Category Code] as Kodi,
'(LP)' + ' '+[Item Category Code] as Kategoria
from LogiPOS.dbo.Item group by [Item Category Code]


--union all
--select 


--[Item Category Code] as Kodi,
--'(MP)' + ' '+[Item Category Code] as Kategoria
--from MarketPlace.dbo.Item group by [Item Category Code]


--union all

--select
--[Item Category Code] as Kodi,
--'(NNN)' + ' '+[Item Category Code] as Kategoria
--from NuNuNa.dbo.Item group by [Item Category Code]

--union all

--select
--[Item Category Code] as Kodi,
--'(SV)' + ' '+[Item Category Code] as Kategoria
--from Souvenir.dbo.Item group by [Item Category Code]

--union all

--select
--[Item Category Code] as Kodi,
--'(Psc)' + ' '+[Item Category Code] as Kategoria
--from Pascucci.dbo.Item group by [Item Category Code]

--union all

--select
--[Item Category Code] as Kodi,
--'(Sgf)' + ' '+[Item Category Code] as Kategoria
--from Segafredo.dbo.Item group by [Item Category Code]







GO
