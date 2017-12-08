SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE view [dbo].[FilterKamarier]

as
select 
id as Id,
Description as Emri,
'Logi POS' as Klienti 
from
LogiPOS.dbo.users where [profile]=14

--union all
--select 
--id as Id,
--Description as Emri,
--'Market Place' as Klienti 
--from
--MarketPlace.dbo.users where [profile]=14

--union all

--select 
--id as Id,
--Description as Emri,
--'NuNuNa' as Klienti 
--from
--NuNuNa.dbo.users where [profile]=14

--union all

--select 
--id as Id,
--Description as Emri,
--'Souvenir' as Klienti 
--from
--Souvenir.dbo.users where [profile]=14


--union all

--select 
--id as Id,
--Description as Emri,
--'Pascucci' as Klienti 
--from
--Pascucci.dbo.users where [profile]=24

--union all

--select 
--id as Id,
--Description as Emri,
--'Segafredo' as Klienti 
--from
--Segafredo.dbo.users where [profile]=24








GO
