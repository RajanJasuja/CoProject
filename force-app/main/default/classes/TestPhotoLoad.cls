public class TestPhotoLoad {

    public static void LoadPhoto(List<User> usersToUpdate){
    
    Set<ID> attIDs=new Set<ID>();
    Map<ID,User> UsersMap=new Map<ID,User>();
    
    
    for(user usr:UsersToUpdate){
        attIDs.add(usr.Profile_Picture_ID__c);
        UsersMap.put(usr.Profile_Picture_ID__c,usr);
    }
    
    System.debug('***Test 2****'+attIDs);

    
    for(Document att:[Select ID,Body,Name from Document where id in:attIDs]){
        ConnectApi.BinaryInput fileUpload =new ConnectApi.BinaryInput(att.body,'image/jpg','userImage.jpg');
        ConnectApi.Photo photo = ConnectApi.ChatterUsers.setPhoto(null,UsersMap.get(att.ID).ID,fileUpload);
        System.debug('Photo loaded for'+ UsersMap.get(att.ID).Name);
    }
    
    
    //List<Attachment> att=[Select ID,Body,Name from Attachment where id in:attIDs];
    //Document doc=[SELECT Body,ID,Name FROM Document WHERE Id =:docID];
    //ConnectApi.BinaryInput fileUpload =new ConnectApi.BinaryInput(doc.body,'image/jpg','userImage.jpg');
    //ConnectApi.Photo photoProfile = ConnectApi.ChatterUsers.setPhoto(communityId,userId,fileUpload);
    //ConnectApi.Photo photo = ConnectApi.ChatterUsers.setPhoto(null,UserID,fileUpload);
    //ConnectApi.Photo ph = ConnectApi.ChatterUsers.getPhoto(null, '00560000000wxjfAAA');
    //System.debug(ph);
    
    }

    public static void LoadPhoto(){
    
    Document doc=[SELECT Body,ID,Name FROM Document WHERE Id = '015f20000024ZUTAA2'];
    ConnectApi.BinaryInput fileUpload =new ConnectApi.BinaryInput(doc.body,'image/jpg','userImage.jpg');
    //ConnectApi.Photo photoProfile = ConnectApi.ChatterUsers.setPhoto(communityId,userId,fileUpload);
    ConnectApi.Photo photo = ConnectApi.ChatterUsers.setPhoto(null,'00560000000wxjfAAA',fileUpload);
    //ConnectApi.Photo ph = ConnectApi.ChatterUsers.getPhoto(null, '00560000000wxjfAAA');
    //System.debug(ph);
    
    }

}