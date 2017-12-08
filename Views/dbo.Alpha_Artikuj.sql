SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE view
[dbo].[Alpha_Artikuj]
as

SELECT artnr AS [No]
,artpershk AS [Description]
,CMI AS [Unit Price]
,tvsh AS [VAT]
,njesia as [UoM]
,artaktiv AS [Aktiv]
,artref
,grupid
,gruppershk
,CMII
,CMIII
,CMIV
,CMV
,CMVI
,CMVII
,CMVIII
,CMIX
,CMX
,CMXI
,CMXII
,CMXIII
,CMXIV
,CMXV
,CMXVI
,CMXVII
,CMXVIII
,CMXIX
,CMXX
,CMXXI
,CMXXII
,Monedha
 FROM srv.mcalpha.dbo.artikujalfa  
 WHERE [CMI] IS NOT NULL
 AND grupid<>5






GO
