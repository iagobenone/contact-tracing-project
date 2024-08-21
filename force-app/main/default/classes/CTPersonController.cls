public with sharing class CTPersonController {
 
    //Método para gerar um token aleatório quando for passado o número de telefone
    public static String getToken(String mobile){
        Blob targetBlob = Blob.valueOf(mobile);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        //retornar o valor em String
        return EncodingUtil.base64Encode(hash);
    }

    /* 
    *Get 100 contacts with recent health status change
    * @return List<Person__c>
    */
    public static List<Person__c> getRecentHealthChanges(){
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    /*
    *  
    */
    public static List<Person__c> searchPeople(String searchTerm){
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Name LIKE :searchTerm OR Mobile__c LIKE: searchTerm OR Token__c LIKE: searchTerm ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }

    /**
     * Search person by Id
     * @param personId the Id of the person we are looking for
     * @return the person if exists, null if not
    */
    public static Person__c getPersonById(String personId){
        list<People__c> people = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Id =: personId];

        if(people != null && people.size() > 0){
            return people[0];
        }

        return null;
    }
}