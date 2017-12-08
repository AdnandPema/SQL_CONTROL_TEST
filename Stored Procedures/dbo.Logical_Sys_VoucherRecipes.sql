SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Logical_Sys_VoucherRecipes] (@RecipeNo NVARCHAR(50))
AS
select vr.id
                                        ,vr.[Code]
                                        ,vr.[RecipeNo]
                                        ,vr.[VoucherStartDate]
                                        ,vr.[StartTime]
                                        ,vr.[VoucherEndDate]
                                        ,vr.[EndTime]
                                        ,vr.[VoucherDescription]
                                        ,vr.[VoucherStore]
                                        ,vr.[VoucherStoreSpecific]
                                        ,vr.[Voucher_Type]
                                        ,vr.[PeriodType]
                                        ,vr.[PeriodDay]
                                        ,vr.[Status]
                                        ,vr.[ActiveRecipeCode]
                                        ,ISNULL(vr.[Monday],0)[Monday]
                                        ,ISNULL(vr.[TuesDay],0)[TuesDay]
                                        ,ISNULL(vr.[Wednesday],0)[Wednesday]
                                        ,ISNULL(vr.[Thursday],0)[Thursday]
                                        ,ISNULL(vr.[Friday],0)[Friday]
                                        ,ISNULL(vr.[Saturday],0)[Saturday]
                                        ,ISNULL(vr.[Sunday],0)[Sunday]
                                        ,vt.TextToPrint Voucher_text
                                        ,isnull(vt.PrintText,0)Print_VoucherText
                                        ,isnull(vt.HeaderText,'') Voucher_HeaderText
                                        ,isnull(vt.PrintHeader,0)Print_VoucherHeaderText
                                        ,isnull(vt.PrintValidity,0)Print_VoucherValidity  
                                        ,isnull(vt.PrintBarcode,0)Print_VoucherBarcode
                                        ,isnull(vt.PrintFooter,0)Print_VouchertFooter
                                        ,isnull(vt.FooterText,'')Voucher_FooterText                                        
                                        from Voucher_Recipes vr left join voucher_type vt on vt.code=vr.Voucher_type  where RecipeNo=@RecipeNo
GO
