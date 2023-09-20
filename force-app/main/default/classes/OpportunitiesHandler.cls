/*******************************************************************************************
* @Name         Biomatiq Opportunities
* @Author       Ganesh P <ganesh.p@rudhrainfosolutions.com>
* @Date         27/06/2023
* @Group        Opportunities Trigger
* @Description  This class is executed whenever opportunities is updated.
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer          Date               Description
*-------------------------------------------------------------------------------------------
*  1.0             Ganesh P       27/06/2023          Initial Creation                                                      
*******************************************************************************************/




public class OpportunitiesHandler {
/****************************************************************************************************************
* @Description   update the Email,Phone,Mobile,Deparment.Designation in opportunity if contact changes otherwise 
                 all values to null.
* @Param		List<sObject>,Map<Id,sObject>
* @Return       Nothing
* @Example     
* OpportunitiesHandler.contactBasedEmailPhone(List<BiomatiQ_Lead__c> oppNewList,Map<Id,BiomatiQ_Lead__c> oppOldMap);
********************************************************************************************************************/ 
    
    public static void contactBasedEmailPhone(List<BiomatiQ_Lead__c> oppNewList,Map<Id,BiomatiQ_Lead__c> oppOldMap){
       Map<Id, Contact> contactsById = new Map<Id, Contact>();
        // Query all the contacts.
       List<Contact> contacts = [SELECT Id,Email,Phone,MobilePhone,Designation__c,Department__c FROM Contact];

      // Store the contacts in the Map by ID.
      for (Contact contact : contacts) {
         contactsById.put(contact.id, contact);
      }

        
        for(BiomatiQ_Lead__c op:oppNewList){
            
            if(op.Contact__c != oppOldMap.get(op.Id).Contact__c  && op.Contact__c !=null){
                system.debug('contact==>'+op.Contact__c);
                Contact con=contactsById.get(op.Contact__c);
                op.Email__c=con.Email;
                op.Phone__c=con.Phone;
                op.Mobile__c=con.MobilePhone;
                op.Designation__c=con.Designation__c;
                op.Department__c=con.Department__c;
                
            }else{
                //op.Email__c=null;
               // op.Phone__c=null;
                //op.Mobile__c=null;
               // op.Designation__c=null;
               // op.Department__c=null;
            }
            
        }
        
        
        
        
    }

}