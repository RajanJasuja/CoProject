global class ClientRefresh {
// ----------------------------------------------------------------------------------------------
// Refresh client data in 8000-record jobs made up of 200-record batches
//
// M.Witchalls June 2008 
// -----------------------------------------------------------------------------------------------
    private static String latestID = '000000000000000';
    private static String queueLatestID = '000000000000000';
    private static final Integer JOB_SIZE = 2000;
    private static final Integer BATCH_SIZE = 200;
    
    webservice static Integer getJobSize() {
        return JOB_SIZE;
    }       
    
    webservice static Integer getClientCount() {
        Integer returnCount = [
            select count() from Account limit 10000
        ];
        return returnCount;
    }       
    
    webservice static String updateClients(String lastUpdateID) {
        if (lastUpdateID.length() > 0) latestID = lastUpdateID;
        String startID = latestID;      
        String endID = getFinalClientID();
        
        system.debug('Start ClientID: '+startID);
        system.debug('End ClientID: '+endID);
        Integer processedCount = 0;
        
        for (Account client :[
            select Id, ClientID__c, Last_Data_Refresh_Time__c 
            from Account 
            where ClientID__c > :latestID
            order by ClientID__c
            limit :JOB_SIZE
        ]) {
            processedCount++;
            latestID = client.ClientID__c;
        }
        system.debug('Last ClientID: '+latestID);
        system.debug('Job Count: '+processedCount);
        queueBatchUpdates(startID);

        if (latestID == endID) {
            return processedCount.format();
        } else {
            return latestID;
        }
    }       
    
    webservice static String getFinalClientID() {
        Account a = [
            select ClientID__c from Account 
            order by ClientID__c DESC
            limit 1
        ];
        return a.ClientID__c;
    }       
    
    @future     
    private static void queueBatchUpdates(String lastUpdateID) {
        if (lastUpdateID.length() > 0) queueLatestID = lastUpdateID;
        Account[] clientsToUpdate = new List<Account>();        
        Integer processedCount = 0;
        system.debug('********************************************************************');
        system.debug('Start ClientID: '+queueLatestID);
        system.debug('********************************************************************');
        try {
            // Update each client record
            for (Account client :[
                select Id, ClientID__c, Last_Data_Refresh_Time__c 
                from Account where ClientID__c > :queueLatestID
                order by ClientID__c
                limit :JOB_SIZE
            ]) {
                processedCount++;
                queueLatestID = client.ClientID__c;
                client.Last_Data_Refresh_Time__c = Datetime.now();
                clientsToUpdate.add(client);
                if (clientsToUpdate.size() == BATCH_SIZE) {
                    system.debug('Updates: '+clientsToUpdate);
                    update clientsToUpdate;
                    clientsToUpdate.clear();
                }
            }
            if (clientsToUpdate.size() > 0) {
                system.debug('Updates: '+clientsToUpdate);
                update clientsToUpdate;
            }
        } catch (DmlException e) {
            for (Integer i = 0; i < e.getNumDml(); i++) {
                System.debug('ERROR: '+e.getDmlMessage(i));
            }
        }           
    }           
}