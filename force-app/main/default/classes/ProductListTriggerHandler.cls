/*Trigger Name: ProductListTrigger
     * Controller:ProductListTriggerHandler
     * Test Class : ProductListTriggerHandlerTest
    Created Date: 4/4/2023*/

public class  ProductListTriggerHandler {
    public static void  beforeInsert(List<Product_List__c> prodList){
       // productTypeError(prodList);
         String productId;
        String OppId;
    String ReportingManager=[Select Id, Name, ManagerId From User where Id=:UserInfo.getUserId()].ManagerId;
    String CurrenRoleName=[Select Id,Name,DeveloperName From UserRole where id=:UserInfo.getUserRoleId()].Name;
        System.debug('Role'+CurrenRoleName);
    Decimal SalesExecutive;Decimal AreaManager;Decimal SalesDirector;Decimal ManagingDirector;Decimal RegionalManager;//Decimal portfoliManager;
    Decimal maxDiscount=0;  
        Decimal accClassDiscount=0; 
        for(Product_List__c pl:prodList){
            productId=pl.Product__c;
            OppId=pl.Opportunity__c;
        }
        if(productId!=null){
        Product__c productRec=[Select Id,Name,Sub_Category__c,Sub_Category__r.Area_Sales_Manager_Discount__c,
                               Sub_Category__r.Managing_Director_Discount__c,Sub_Category__r.Outside_Sales_Director_Discount__c,
                               Sub_Category__r.Regional_Sales_Manager_Discount__c,Sub_Category__r.Sales_Executive_Discount__c/*,Sub_Category__r.Portfolio_Manager_Discount__c*/ from Product__c where Id=:productId];
   		
        SalesExecutive=productRec.Sub_Category__r.Sales_Executive_Discount__c;
       	 AreaManager=productRec.Sub_Category__r.Area_Sales_Manager_Discount__c;  //This value applicable to Inside Sales team (executive)
         RegionalManager=productRec.Sub_Category__r.Regional_Sales_Manager_Discount__c;//This value applicable to Inside Sales Manager
         SalesDirector=productRec.Sub_Category__r.Outside_Sales_Director_Discount__c;
       // portfoliManager=productRec.Sub_Category__r.Portfolio_Manager_Discount__c;
 		 ManagingDirector=productRec.Sub_Category__r.Managing_Director_Discount__c;
        BiomatiQ_Lead__c opportunityRec=[Select Id,Name,Company_Name__c,Company_Name__r.Class__c,Opportunity_Product_Category__c From BiomatiQ_Lead__c Where Id=:OppId];
         String accountClass=opportunityRec.Company_Name__r.Class__c;
        String segment=opportunityRec.Opportunity_Product_Category__c;
        system.debug('accountClass==>'+accountClass);
   if(accountClass !=null){
         if(accountClass.contains('A - 45 days credit without followup')){
                accClassDiscount=1;
               AreaManager=AreaManager+1; SalesDirector=SalesDirector+1; ManagingDirector=ManagingDirector+1; RegionalManager=RegionalManager+1;/* portfoliManager=portfoliManager+1;*/
             SalesExecutive=SalesExecutive+1;
            }
            else if(accountClass.contains('B - 90 days credit without followup')){
                 accClassDiscount=0;
            }
            else if(accountClass.contains('C - Above 90 days credit or Poor payment')){
                 accClassDiscount=-1;
                 AreaManager=AreaManager-1; SalesDirector=SalesDirector-1; ManagingDirector=ManagingDirector-1; RegionalManager=RegionalManager-1; /*portfoliManager=portfoliManager-1;*/
             SalesExecutive=SalesExecutive-1;
            }
             else if(accountClass.contains('D - New Customers')){
                 accClassDiscount=-2;
                 AreaManager=AreaManager-2; SalesDirector=SalesDirector-2; ManagingDirector=ManagingDirector-2; RegionalManager=RegionalManager-2; /*portfoliManager=portfoliManager-2;*/
             SalesExecutive=SalesExecutive-2;
            }
        }
        if(CurrenRoleName.contains('Sales Executive') && SalesExecutive!=null){
            maxDiscount=SalesExecutive;
        }
        else if(CurrenRoleName.contains('Area Sales Manager') && AreaManager!=null){
            maxDiscount=AreaManager;
        }
        else if(CurrenRoleName.contains('Regional Sales Manager') && RegionalManager!=null){
            maxDiscount=RegionalManager;
        } 
        else if(CurrenRoleName.contains('Outside Sales Director') && SalesDirector!=null){
            maxDiscount=SalesDirector;
        }
         /*else if(CurrenRoleName.contains('Portfolio Manager') && portfoliManager!=null){
            maxDiscount=portfoliManager;
        }*/
        else if(CurrenRoleName.contains('Managing Director') && ManagingDirector!=null){
            maxDiscount=ManagingDirector;
        }
        
         else if(CurrenRoleName.contains('Inside Sales team') && AreaManager!=null){
            maxDiscount=AreaManager;
        }
       else if(CurrenRoleName.contains('Inside Sales Manager') && RegionalManager!=null){
            maxDiscount=RegionalManager;
        }
        
          if(maxDiscount >=100){
                maxDiscount=100;
            }
        for(Product_List__c pl:prodList){
  
            pl.Eligible_Discount__c=maxDiscount;

        }
        }
    }
    
    
    
    
    
    public static void toExecuteApprovalProcess(List<Product_List__c> prodList,Map<Id,Product_List__c> OldMap){
         String productId;
        String OppId;
    String ReportingManager=[Select Id, Name, ManagerId From User where Id=:UserInfo.getUserId()].ManagerId;
    String CurrenRoleName=[Select Id,Name,DeveloperName From UserRole where id=:UserInfo.getUserRoleId()].Name;
    Decimal SalesExecutive;Decimal AreaManager;Decimal SalesDirector;Decimal ManagingDirector;Decimal RegionalManager;/*Decimal portfoliManager;*/
    Decimal maxDiscount=0;   
        Decimal accClassDiscount=0; 
    Map<Id,User> UserManagerMap=New Map<Id,User>([Select Id,Name,ManagerId,UserRoleId From User]);
    
        for(Product_List__c pl:prodList){
            productId=pl.Product__c;
            OppId=pl.Opportunity__c;
        }
         if(productId!=null){
        Product__c productRec=[Select Id,Name,Sub_Category__c,Sub_Category__r.Area_Sales_Manager_Discount__c,
                               Sub_Category__r.Managing_Director_Discount__c,Sub_Category__r.Outside_Sales_Director_Discount__c,
                               Sub_Category__r.Regional_Sales_Manager_Discount__c,Sub_Category__r.Sales_Executive_Discount__c/*,Sub_Category__r.Portfolio_Manager_Discount__c*/ from Product__c where Id=:productId];
   		 SalesExecutive=productRec.Sub_Category__r.Sales_Executive_Discount__c;
       	 AreaManager=productRec.Sub_Category__r.Area_Sales_Manager_Discount__c;     //This value applicable to Inside Sales team (executive)
         RegionalManager=productRec.Sub_Category__r.Regional_Sales_Manager_Discount__c; //This value applicable to Inside Sales Manager
         SalesDirector=productRec.Sub_Category__r.Outside_Sales_Director_Discount__c;
        // portfoliManager=productRec.Sub_Category__r.Portfolio_Manager_Discount__c;
 		 ManagingDirector=productRec.Sub_Category__r.Managing_Director_Discount__c;

        
        BiomatiQ_Lead__c opportunityRec=[Select Id,Name,Company_Name__c,Company_Name__r.Class__c,Opportunity_Product_Category__c From BiomatiQ_Lead__c Where Id=:OppId];
         String accountClass=opportunityRec.Company_Name__r.Class__c;
        String segment=opportunityRec.Opportunity_Product_Category__c;
         /* Id portfolioUserId;
        PortfolioManager_Segment__mdt[] psMetaDataList=[Select MasterLabel,Segment__c From PortfolioManager_Segment__mdt] ;
        for(PortfolioManager_Segment__mdt ps:psMetaDataList){
            if(ps.MasterLabel==segment){
                portfolioUserId=ps.Segment__c;
            }
        }*/
          //PortfolioManager_Segment__mdt psMetaData=PortfolioManager_Segment__mdt.getInstance(segment);
      
          //Company Class Based Discount
           if(accountClass !=null){
         if(accountClass.contains('A - 45 days credit without followup')){
                accClassDiscount=1;
               AreaManager=AreaManager+1; SalesDirector=SalesDirector+1; ManagingDirector=ManagingDirector+1; RegionalManager=RegionalManager+1;/* portfoliManager=portfoliManager+1;*/
             SalesExecutive=SalesExecutive+1;
            }
            else if(accountClass.contains('B - 90 days credit without followup')){
                 accClassDiscount=0;
            }
            else if(accountClass.contains('C - Above 90 days credit or Poor payment')){
                 accClassDiscount=-1;
                 AreaManager=AreaManager-1; SalesDirector=SalesDirector-1; ManagingDirector=ManagingDirector-1; RegionalManager=RegionalManager-1; /*portfoliManager=portfoliManager-1;*/
             SalesExecutive=SalesExecutive-1;
            }
             else if(accountClass.contains('D - New Customers')){
                 accClassDiscount=-2;
                 AreaManager=AreaManager-2; SalesDirector=SalesDirector-2; ManagingDirector=ManagingDirector-2; RegionalManager=RegionalManager-2; /*portfoliManager=portfoliManager-2;*/
             SalesExecutive=SalesExecutive-2;
            }
        }
       //Role Based Discount

       if(CurrenRoleName.contains('Sales Executive') && SalesExecutive!=null){
            maxDiscount=SalesExecutive;
        }
        else if(CurrenRoleName.contains('Area Sales Manager') && AreaManager!=null){
            maxDiscount=AreaManager;
        }
        else if(CurrenRoleName.contains('Regional Sales Manager') && RegionalManager!=null){
            maxDiscount=RegionalManager;
        } 
        else if(CurrenRoleName.contains('Outside Sales Director') && SalesDirector!=null){
            maxDiscount=SalesDirector;
        }
       /* else if(CurrenRoleName.contains('Portfolio Manager') && portfoliManager!=null){
            maxDiscount=portfoliManager;
        }*/
        else if(CurrenRoleName.contains('Managing Director') && ManagingDirector!=null){
            maxDiscount=ManagingDirector;
        }
               else if(CurrenRoleName.contains('Inside Sales team') && AreaManager!=null){
            maxDiscount=AreaManager;
        }
       else if(CurrenRoleName.contains('Inside Sales Manager') && RegionalManager!=null){
            maxDiscount=RegionalManager;
        }
       
          if(maxDiscount >=100){
                maxDiscount=100;
            }
      
      
         for(Product_List__c pl:prodList){
            
             if(pl.Discount__c != OldMap.get(pl.Id).Discount__c){
             pl.Eligible_Discount__c=maxDiscount;
             if(pl.Discount__c > maxDiscount ){
                  pl.Approval_Check__c=false;
                 pl.Approval_status__c='';	
                 pl.Need_Approval__c=true;
               
                  if(CurrenRoleName.contains('Sales Executive')){ 
                  if(pl.Discount__c > SalesExecutive){
                     pl.Approvar__c=ReportingManager;
                     pl.Approver_Role__c='Area Sales Manager';
                   if(pl.Discount__c  > AreaManager){
                      pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                          pl.Approver_Role__c='Regional Sales Manager';
                         if(pl.Discount__c  > RegionalManager){
                             pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                              pl.Approver_Role__c='Outside Sales Director';
                             /*if(pl.Discount__c > SalesDirector){
                                 pl.Approvar__c=portfolioUserId; 
                                 pl.Approver_Role__c='Portfolio Manager';
                             }*/
                             if(pl.Discount__c > SalesDirector){ 
                                 System.debug('pl.Approvar__c'+pl.Approvar__c);
                                 pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                                
                                 pl.Approver_Role__c='Managing Director';
                             }
                          }
                        }
                      }
                    }
                  else if(CurrenRoleName.contains('Area Sales Manager')){         
                   if(pl.Discount__c  > AreaManager){
                      pl.Approvar__c=ReportingManager;
                          pl.Approver_Role__c='Regional Sales Manager';
                         if(pl.Discount__c  > RegionalManager){
                             pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                              pl.Approver_Role__c='Outside Sales Director';
                            /*if(pl.Discount__c > SalesDirector){
                                 pl.Approvar__c=portfolioUserId; 
                                 pl.Approver_Role__c='Portfolio Manager';
                              }*/
                             if(pl.Discount__c > SalesDirector){
                                 pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                                 pl.Approver_Role__c='Managing Director';
                             }
                           
                           }
                        }
                      }
                    
             
              else if(CurrenRoleName.contains('Regional Sales Manager')){
                         if(pl.Discount__c > RegionalManager){
                             pl.Approvar__c=ReportingManager;
                              pl.Approver_Role__c='Outside Sales Director';
                            /* if(pl.Discount__c > SalesDirector){
                                 pl.Approvar__c=portfolioUserId;
                                 pl.Approver_Role__c='Portfolio Manager';
                             }*/
                             if(pl.Discount__c > SalesDirector){
                                 pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                                 pl.Approver_Role__c='Managing Director';
                             }
                             
                         }
                     }
                      else if(CurrenRoleName.contains('Outside Sales Director')){
                  if(pl.Discount__c > SalesDirector){
                                // pl.Approvar__c=portfolioUserId;
                                // pl.Approver_Role__c='Portfolio Manager';
                               pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                               pl.Approver_Role__c='Managing Director';
                             /*if(pl.Discount__c > portfoliManager){
                               
                             }*/
                  }
                      }

             /* else if(CurrenRoleName.contains('Portfolio Manager')){
                  if(pl.Discount__c > SalesDirector){
                                 pl.Approvar__c=ReportingManager;
                                 pl.Approver_Role__c='Managing Director';
                             }   
              }*/
                 
                               else if(CurrenRoleName.contains('Inside Sales team')){
                  if(pl.Discount__c > AreaManager){
                                 pl.Approvar__c=ReportingManager;
                                 pl.Approver_Role__c='Inside Sales Manager';
                      if(pl.Discount__c > RegionalManager){
                           pl.Approvar__c=UserManagerMap.get(pl.Approvar__c).ManagerId;
                          pl.Approver_Role__c='Managing Director';
                    }  
                  }  
                }
                  else if(CurrenRoleName.contains('Inside Sales Manager')){
                  if(pl.Discount__c > RegionalManager){
                                 pl.Approvar__c=ReportingManager;
                                 pl.Approver_Role__c='Managing Director';
                             }   
              }
             }
             }
         }
  }
   
    
    }
        

 public static void emptyProductDelete(List<Product_List__c> prodList){
     
    // Set<id> categoryIds=New Set<id>();
    String oppId;
     for(Product_List__c pl:prodList){
         if(pl.Product__c!=null){
        // categoryIds.add(pl.Sub_Category__c);
           oppId=pl.Opportunity__c;
         }
     }
     List<Product_List__c> plListWithoutProducts=[Select Id,Sub_Category__c,Brand_Name_Text__c,Product__c,Opportunity__c from Product_List__c where Product__c=:null And Opportunity__c=:oppId];
     system.debug('plListWithoutProducts'+plListWithoutProducts.size());
     if(plListWithoutProducts.size()>0 && !plListWithoutProducts.isEmpty()){
         system.debug('if condition');
         Delete plListWithoutProducts;
     }
    
}
}