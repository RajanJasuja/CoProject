global class UploadUserProfilePic implements Database.Batchable<sObject> {
    
    global String query;
    global UploadUserProfilePic(String query) {
    this.query = query;
	}
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<User> userToLoad) {
        
        TestPhotoLoad.LoadPhoto(userToLoad);
    }
    global void finish(Database.BatchableContext bc) {
        
        Delete [SELECT Id FROM Document WHERE Name LIKE 'TempLoad%']; 
        System.debug('Job Done');
    }
}