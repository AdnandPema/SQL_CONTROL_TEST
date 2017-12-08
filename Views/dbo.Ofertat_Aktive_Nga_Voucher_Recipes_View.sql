SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Ofertat_Aktive_Nga_Voucher_Recipes_View] AS
	select distinct id,Code, VoucherDescription from Voucher_Recipes where 
                              CONVERT(DATE,GETDATE()) between VoucherStartDate and VoucherEndDate
                              and Status = 0   and (
							monday = 1 and 'monday' = datename(dw,getdate()) 
							or tuesday = 1 and 'tuesday' = datename(dw,getdate())
							or Wednesday = 1 and 'Wednesday' = datename(dw,getdate())
							or thursday = 1 and 'thursday' = datename(dw,getdate())
							or friday = 1 and 'friday' = datename(dw,getdate())
							or saturday = 1 and 'saturday' = datename(dw,getdate())
							or sunday = 1 and 'sunday' = datename(dw,getdate()))
GO
