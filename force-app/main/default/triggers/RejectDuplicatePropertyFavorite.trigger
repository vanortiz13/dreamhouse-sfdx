trigger RejectDuplicatePropertyFavorite on Property_Favorite__c (before insert) {
    List<Property__c> propList = new List<property__c>();
    List<User__c> userList = new List<User__c>();

    // NOTE: this trigger needs to be bulkified
    //Property_Favorite__c favorite = Trigger.New[0];

    for(Property_Favortite__c favorite : Trigger.new){
        propList.add(favorite.Property__c);
        userList.add(favorite.User__c);
    }

    List<Property_Favorite__c> dupes = [Select Id FROM Property_Favorite__C WHERE Property__c in :propList AND User__c in :userList];
    if (!dupes.isEmpty()) {
        favorite.addError('duplicate');
    }

}