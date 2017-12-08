SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[XHIRO_ANALITIKE] 
(@DateFillim AS DATETIME
,@DateMbarim AS DATETIME
,@Cashier AS nvarchar(50) 
,@DokFillim AS NVARCHAR(20) = '00'
,@DokMbarim AS NVARCHAR(20) = 'ZZ'
,@ArtFillim AS NVARCHAR(20)=''
,@Client as nvarchar(100))
AS

DECLARE @CNga varchar(30)
DECLARE @CDeri varchar(30)

DECLARE @WNga  varchar(50)
DECLARE @WDeri  varchar(50)

SET @WNga = @Cashier
SET @WDeri = @Cashier

IF @Cashier = 'Të gjithë' or @Cashier ='All'
BEGIN
SET @WNga = '00'
SET @WDeri =  'ZZ'
END

IF @Client = 'Të gjithë' or @Client = 'All'
BEGIN
SET @CNga = '00'
SET @CDeri = 'ZZ'
END

select
*
from(
SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
(CASE WHEN SL.[Quantity]<0 THEN
(-1)*SL.[DiscountValue]
ELSE
SL.[DiscountValue]
END) ZbritjeArtikull,

SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
SH.[DocumentDate] AS Koha, --SH.WaiterDesc AS Kasiere,
SH.Amount as VlereTotale, '' AS Supervisor,
SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
,'' as Agjenti
,sh.CustomerNo + ' | MCWilson' as Klienti
FROM LogiPOS.dbo.HSalesLines as SL
LEFT JOIN LogiPOS.dbo.HSalesHeader  AS SH ON SH.ID = SL.HeaderID
WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri

and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri
) a

ORDER BY koha ASC

----MC11Janari
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,
--SL.[Quantity] AS Sasia
--,SL.Amount AS VlereArtikulli
--,SL.[Discount%] AS ZbritjeArtikullPerqindje
--,SH.[DocumentDate] AS Koha
--,SH.WaiterDesc AS Kasiere
--,SH.Amount as VlereTotale
--,'' AS Supervisor
--,SH.[DiscountValue] AS ZbritjeFature
--,SH.DateDoc AS Data
--,SL.[ItemUnitPrice] AS CmimKartele
--, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC11Janari' as Klienti

--FROM LogicalInterface.dbo.MC11Janari_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MC11Janari_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

----MCAmbasada_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Ambasada' as Klienti
--FROM LogicalInterface.dbo.MCAmbasada_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCAmbasada_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

----MCAmbasadaPolake_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Ambasada Polake' as Klienti
--FROM LogicalInterface.dbo.MCAmbasadaPolake_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCAmbasadaPolake_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

----MCBlloku_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Blloku' as Klienti
--FROM LogicalInterface.dbo.MCBlloku_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCBlloku_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

----MCBulevardi_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Bulevardi' as Klienti
--FROM LogicalInterface.dbo.MCBulevardi_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCBulevardi_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

----MCCondor_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Condor' as Klienti
--FROM LogicalInterface.dbo.MCCondor_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCCondor_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

----MCJuridiku_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Juridiku' as Klienti
--FROM LogicalInterface.dbo.MCJuridiku_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCJuridiku_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

--MCLibri_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Libri' as Klienti
--FROM LogicalInterface.dbo.MCLibri_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCLibri_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri



--UNION ALL

----MCMeduza_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Meduza' as Klienti
--FROM LogicalInterface.dbo.MCMeduza_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCMeduza_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri

--UNION ALL

----MCRrDurresit_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Rr.Durresit' as Klienti
--FROM LogicalInterface.dbo.MCRrDurresit_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCRrDurresit_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri
--UNION ALL

----MCRrKavajes_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Rr. Kavajes' as Klienti
--FROM LogicalInterface.dbo.MCRrKavajes_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCRrKavajes_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri

--UNION ALL

----MCRuin_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, SH.WaiterDesc AS Kasiere,SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MC Ruin' as Klienti
--FROM LogicalInterface.dbo.MCRuin_HSalesLines AS SL
--LEFT JOIN LogicalInterface.dbo.MCRuin_HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
--AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri
--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri
--union all

--MCWilson_HSalesHeader
--SELECT SH.ID,SH.[DocumentNo],SL.ItemNo AS Kodi,SL.[Description] AS Pershkrimi,
--(CASE WHEN SL.[Quantity]<0 THEN
--(-1)*SL.[DiscountValue]
--ELSE
--SL.[DiscountValue]
--END) ZbritjeArtikull,

--SL.[Quantity] AS Sasia,SL.Amount AS VlereArtikulli,SL.[Discount%] AS ZbritjeArtikullPerqindje,
--SH.[DocumentDate] AS Koha, --SH.WaiterDesc AS Kasiere,
--SH.Amount as VlereTotale, '' AS Supervisor,
--SH.[DiscountValue] AS ZbritjeFature,SH.DateDoc AS Data,SL.[ItemUnitPrice] AS CmimKartele, SH.AmountNoDiscount as NenTotal
--,'' as Agjenti
--,sh.CustomerNo + ' | MCWilson' as Klienti
--FROM LogiPOS.dbo.HSalesLines as SL
--LEFT JOIN LogiPOS.dbo.HSalesHeader  AS SH ON SH.ID = SL.HeaderID
--WHERE SH.[DocumentDate] >= @DateFillim AND SH.[DocumentDate] <= @DateMbarim
--AND SH.[DocumentNo] >= ISNULL(@DokFillim,'00') AND SH.[DocumentNo] <= ISNULL(@DokMbarim,'ZZ')
--AND(SL.[ItemNo] like @ArtFillim + '%'OR SL.[Description]like '%'+@ArtFillim+'%')
----AND SH.WaiterDesc >= @WNga and  SH.WaiterDesc <= @WDeri

--and sh.CustomerNo >=@CNga and sh.CustomerNo <=@CDeri
--) a
--ORDER BY koha ASC




GO
