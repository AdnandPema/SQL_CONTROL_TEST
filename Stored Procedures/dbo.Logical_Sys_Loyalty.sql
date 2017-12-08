SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Logical_Sys_Loyalty] (@DocumentNo AS NVARCHAR(50))
AS
	
--DECLARE @DocumentNo AS NVARCHAR(50) 
--SET @DocumentNo='110912150002'
DECLARE @ClientCode AS NVARCHAR(50),@ClientCardNo AS NVARCHAR(50)
--,@CouponSetCode AS NVARCHAR(50),@CouponType AS NVARCHAR(50)
, @CountValidated AS INT, @CountRedeemed AS INT,
@CountPayment AS INT, @CountDicount AS int

declare Cur_Loyalty CURSOR LOCAL for
    SELECT ClientId,ClientCardNo
    --,lh.DocumentNo
    --,ISNULL(ll.CouponSetCode,'')CouponSetCode,ISNULL(ll.CouponCode,'')CouponCode
   -- ,ISNULL(ll.CouponValue,'')CouponValue,ISNULL(ll.CouponType,'')CouponType,ISNULL(ll.Validated,0)Validated,ISNULL(ll.Reedem,0)Reedem
    ,(SELECT count(1) FROM dbo.LoyaltyLines WHERE DocumentNo=lh.documentno AND Validated=1)CountValidated
    ,(SELECT count(1) FROM dbo.LoyaltyLines WHERE DocumentNo=lh.documentno AND Reedem=1)CountRedeemed
    ,(SELECT COUNT(1) FROM dbo.LoyaltyLines WHERE DocumentNo = lh.documentno AND CouponType='PAYMENT')CountPayment
    ,(SELECT COUNT(1) FROM dbo.LoyaltyLines WHERE DocumentNo = lh.documentno AND (CouponType='DISCOUNT_VALUE' OR CouponType = 'DISCOUNT_PERCENTAGE'))CountDiscount
FROM dbo.LoyaltyHeader lh LEFT JOIN 
dbo.LoyaltyLines ll ON 
lh.DocumentNo = ll.DocumentNo
WHERE lh.DocumentNo = @DocumentNo
GROUP BY ClientId,ClientCardNo,lh.DocumentNo
-- WHERE [Online]=0 and Synced=0
	
open Cur_Loyalty

fetch next from Cur_Loyalty into @ClientCode,@ClientCardNo,@CountValidated,@CountRedeemed,@CountPayment,@CountDicount

if @@FETCH_STATUS =0 
BEGIN
	IF (@CountValidated + @CountRedeemed) >0
		BEGIN 
			IF @CountPayment >0 AND @CountPayment = @CountValidated
				BEGIN
					--jane te gjitha payment
					SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
							,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
							,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
							,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
							,sl.ItemNo
							,'' AS CouponSetCode
							,sl.Quantity                                     
							,sl.ItemUnitPrice AS RetailPrice--(sl.ItemUnitPrice-sl.DiscountValue)RetailPrice                                     
							,(sl.DiscountValue + sl.InvoiceDiscountValue) AS discountAmount
							,sl.Amount AS lineAmount
							,sl.Amount AS totalamount
							,sl.amount AS AmountinCash
							,1 AS Item			
					FROM dbo.SalesHeader  sh LEFT JOIN dbo.SalesLines sl ON sl.HeaderID=sh.id										
					WHERE sh.DocumentNo=@DocumentNo
					UNION ALL
					SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
							,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
							,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
							,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
							,ISNULL(ll.CouponCode,'') AS ItemNo
							,ISNULL(ll.CouponSetCode,'') AS CouponSetCode
							,1 AS Quantity
							,(-1)*CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS RetailPrice
							,0 AS discountAmount
							,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS lineAmount
							,0 AS totalAmount
							,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS AmountinCash
							,(CASE ISNULL(Validated,0) WHEN 0 THEN -1 WHEN 1 THEN 2 ELSE 3 END)  AS Item
					FROM dbo.SalesHeader sh LEFT JOIN dbo.LoyaltyLines ll ON 
							sh.DocumentNo = ll.DocumentNo
					WHERE sh.DocumentNo=@DocumentNo
				END
			ELSE IF @CountDicount >0  AND @CountDicount = @CountValidated
				BEGIN
					--jane te gjitha discount value dhe percentage 
					SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
							,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
							,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
							,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
							,sl.ItemNo
							,''AS CouponSetCode
							,sl.Quantity							                                     
							,sl.ItemUnitPrice AS RetailPrice                                   
							,(sl.DiscountValue) AS discountAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS lineAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS totalAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS AmountInCash
							,1 AS Item										
					FROM dbo.SalesHeader  sh 
					LEFT JOIN  
						dbo.SalesLines sl ON sl.HeaderID=sh.id
					WHERE sh.DocumentNo=@DocumentNo
					UNION ALL
					SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
							,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
							,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
							,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
							,ISNULL(ll.CouponCode,'') AS ItemNo
							,ISNULL(ll.CouponSetCode,'') AS CouponSetCode
							,1 AS Quantity
							,(-1)*CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS RetailPrice
							,0 AS discountAmount
							,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS lineAmount
							,0 AS totalAmount
							,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS AmountinCash
							,(CASE ISNULL(Validated,0) WHEN 0 THEN -1 WHEN 1 THEN 2 ELSE 3 END)  AS Item
					FROM dbo.SalesHeader sh LEFT JOIN dbo.LoyaltyLines ll ON 
							sh.DocumentNo = ll.DocumentNo
					WHERE sh.DocumentNo=@DocumentNo
				END
			ELSE 
				BEGIN
					--jane si payment si Discount
					SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
							,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
							,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
							,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
							,sl.ItemNo
							,'' AS CouponSetCode
							,sl.Quantity                                     
							,sl.ItemUnitPrice AS RetailPrice                                   
							,(sl.DiscountValue) AS discountAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS lineAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS totalAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS AmountInCash
							,1 AS Item									
					FROM dbo.SalesHeader  sh 
					LEFT JOIN  
						dbo.SalesLines sl ON sl.HeaderID=sh.id
					WHERE sh.DocumentNo=@DocumentNo
					UNION ALL
					SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
							,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
							,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
							,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
							,ISNULL(ll.CouponCode,'') AS ItemNo
							,ISNULL(ll.CouponSetCode,'') AS CouponSetCode
							,1 AS Quantity
							,(-1)*CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS RetailPrice
							,0 AS discountAmount
							,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS lineAmount
							,0 AS totalAmount
							,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS AmountinCash
							,(CASE ISNULL(Validated,0) WHEN 0 THEN -1 WHEN 1 THEN 2 ELSE 3 END)  AS Item--kur eshte 1 eshte artikull kur eshte 2eshte validated kur eshte 3 eshte redeemed 
					FROM dbo.SalesHeader sh LEFT JOIN dbo.LoyaltyLines ll ON 
							sh.DocumentNo = ll.DocumentNo
					WHERE sh.DocumentNo=@DocumentNo
				END
        END 
    ELSE
    Begin
    SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
							,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
							,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
							,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
							,sl.ItemNo
							,'' AS CouponSetCode
							,sl.Quantity                                     
							,sl.ItemUnitPrice AS RetailPrice                                   
							,(sl.DiscountValue) AS discountAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS lineAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS totalAmount
							,(sl.Quantity * (sl.ItemUnitPrice -sl.DiscountValue)) AS AmountInCash
							,1 AS Item									
					FROM dbo.SalesHeader  sh 
					LEFT JOIN  
						dbo.SalesLines sl ON sl.HeaderID=sh.id
					WHERE sh.DocumentNo=@DocumentNo
					--UNION ALL
					--SELECT @ClientCode AS ClientCode,@ClientCardNo AS ClientCard,@CountValidated AS CountValidated,@CountRedeemed AS COUNTRedeemed
					--		,sh.DocumentNo,sh.CustomerNo,ISNULL((SELECT Name FROM dbo.Customer WHERE no=sh.customerno),'')CustomerName
					--		,sh.CashDesk,sh.DocumentDate,'receipt'AS transactionType
					--		,'al'AS Countrycode,'Lek'AS CurrencyCode,sh.DiscountValue AS HeaderDiscountValue,sh.Amount AS AmountHeader
					--		,ISNULL(ll.CouponCode,'') AS ItemNo
					--		,ISNULL(ll.CouponSetCode,'') AS CouponSetCode
					--		,1 AS Quantity
					--		,(-1)*CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS RetailPrice
					--		,0 AS discountAmount
					--		,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS lineAmount
					--		,0 AS totalAmount
					--		,(-1) *CONVERT(FLOAT,ISNULL(ll.CouponValue,0)) AS AmountinCash
					--		,(CASE ISNULL(Validated,0) WHEN 0 THEN -1 WHEN 1 THEN 2 ELSE 3 END)  AS Item--kur eshte 1 eshte artikull kur eshte 2eshte validated kur eshte 3 eshte redeemed 
					--FROM dbo.SalesHeader sh LEFT JOIN dbo.LoyaltyLines ll ON 
					--		sh.DocumentNo = ll.DocumentNo
					--WHERE sh.DocumentNo=@DocumentNo
    END             
END

GO
