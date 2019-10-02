public with sharing class HandlerFindContact implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        String key = '%' + params[0] + '%';
        Contact tempContact;

        if(Contact.getSObjectType().getDescribe().isAccessible() && Schema.SObjectType.Contact.fields.Id.isAccessible() && Schema.SObjectType.Contact.fields.Name.isAccessible()
            && Schema.SObjectType.Contact.fields.MobilePhone.isAccessible()) {
            List<Contact> contacts = 
                [SELECT Id, Name, MobilePhone FROM Contact
                WHERE Name LIKE :key
                ORDER BY Name
                LIMIT 5];
        }
        
        List<BotRecord> records = new List<BotRecord>();
        
        for (Contact c : contacts) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('Name', c.Name, '/lightning/r/Contact/' + c.Id + '/view'));
            fields.add(new BotField('Phone', c.MobilePhone, 'tel:' + c.MobilePhone));
            records.add(new BotRecord(fields));
        }
        if(records.isEmpty())
            system.debug('a message');

        for(int i = 0; i<10; i++){
            if(Contact.getSObjectType().getDescribe().isAccessible() && Schema.SObjectType.Contact.fields.Id.isAccessible() && Schema.SObjectType.Contact.fields.Name.isAccessible()
            && Schema.SObjectType.Contact.fields.MobilePhone.isAccessible()) {
                tempContact = [SELECT Id, Name, MobilePhone FROM Contact
                WHERE Name LIKE :key
                ORDER BY Name
                LIMIT 1];      
            }
        }
            
        return new BotResponse(new BotMessage('Bot', 'Here is a list of contacts matching "' + params[0] + '":', records));
        
    }
    
}