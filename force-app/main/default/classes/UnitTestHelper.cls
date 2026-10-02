/**
 * @Company     : PwC.
 * @Description : 
 * *****************************************************************************************************
 * Unit Test Helper class.
 * *****************************************************************************************************
 * @History     : 
 * [19.Sept.2014] Ushank Khanna - Code Creation 
 */


public with sharing class UnitTestHelper {
    
    /**
     * Static method that generates multiple instances of an user object
     * with its required field values pre-populated.
     *
     * @param   iCount  the number of Users to generate
     * @return  a list of Users that have not been committed
     *          to the database
    */

    public static List<User> getUserInstances(integer iCount, String s){
        List<User> listUsers = new List<User>();
        Profile profile = [SELECT Id FROM Profile WHERE Name=:s]; 

        for (integer i = 0; i < iCount; i++) {
            User oUser = new User();
            String sAppend = ''+String.valueOf(Math.random());
            oUser.FirstName = 'TestFirstName';
            oUser.LastName = 'TestLastName';
            oUser.Email = 'test'+sAppend+'@demo.com';
            oUser.Username = 'test'+sAppend+'@demo.com.sandbox';
            oUser.Alias = oUser.FirstName.substring(0,1)+oUser.LastName.substring(0,4);
            oUser.ProfileId = profile.Id;
            oUser.TimeZoneSidKey = 'America/Los_Angeles';
            oUser.LocaleSidKey = 'en_US';
            oUser.LanguageLocaleKey = 'en_US';
            oUser.EmailEncodingKey = 'ISO-8859-1';
            listUsers.add(oUser);    
        }
        return listUsers;
    }

    
    /**
     * Static method that generates multiple instances of an Project__c object
     * with its required field values pre-populated.
     *
     * @param   iCount  the number of Project__c to generate
     * @return  a list of Project__c that have not been committed
     *          to the database
    */

     public static List<Project__c> getProjectInstances(integer iCount) {
        List<Project__c> listProjects = new List<Project__c>();
        
        for (integer i = 0; i < iCount; i++) {
            Project__c oProject = new Project__c();
            oProject.Name = 'Test Account - ' + i;
            oProject.Status__c = 'In Progress';
            oProject.Description__c = 'Test Data';
            oProject.Start_Date__c = System.today();
            oProject.End_Date__c = System.today();
            listProjects.add(oProject); 
        }
        return listProjects;
    }

    /**
     * Static method that generates multiple instances of an Work_Package__c object
     * with its required field values pre-populated.
     *
     * @param   iCount  the number of Work_Package__c to generate
     * @return  a list of Work_Package__c that have not been committed
     *          to the database
    */

     public static List<Work_Package__c> getWorkPackageInstances(integer iCount, Id projectId) {
        List<Work_Package__c> listWorkPackages = new List<Work_Package__c>();
        
        for (integer i = 0; i < iCount; i++) {
            Work_Package__c oWP = new Work_Package__c();
            oWP.Name = 'Test Account - ' + i;
            oWP.Status__c = 'In Progress';
            oWP.Project__c = projectId;
            oWP.Number_Of_Resources__c = 5.0;
            oWP.Estimated_Start_Date__c = System.today();
            oWP.Estimated_Completion_Date__c = System.today()+60;
            listWorkPackages.add(oWP); 
        }
        return listWorkPackages;
    }

    /**
     * Static method that generates multiple instances of an Requirement__c object
     * with its required field values pre-populated.
     *
     * @param   iCount  the number of Requirement__c to generate
     * @return  a list of Requirement__c that have not been committed
     *          to the database
    */

     public static List<Requirement__c> getRequirementInstances(integer iCount, Id recordId) {
        List<Requirement__c> listRequirement = new List<Requirement__c>();
        
        for (integer i = 0; i < iCount; i++) {
            Requirement__c oReq = new Requirement__c();
            oReq.Work_Package__c = recordId;
            oReq.Status__c = 'In Progress';
            oReq.Priority__c = 'High';
            oReq.Work_Stream_Type__c = 'Integration';
            oReq.Summary__c = 'test Demo';
            listRequirement.add(oReq); 
        }
        return listRequirement;
    }

    /**
     * Static method that generates multiple instances of an Work_Task__c object
     * with its required field values pre-populated.
     *
     * @param   iCount  the number of Work_Task__c to generate
     * @return  a list of Work_Task__c that have not been committed
     *          to the database
    */

     public static List<Work_Task__c> getWorkTaskInstances(integer iCount, Id recordId) {
        List<Work_Task__c> listWorkTask = new List<Work_Task__c>();
        
        for (integer i = 0; i < iCount; i++) {
            Work_Task__c oWT = new Work_Task__c();
            oWT.Task_Summary__c = 'Test';
            oWT.Status__c = '5.2 Sprint Team - With BPC';
            oWT.Assigned_To__c = UserInfo.getUserId();
            oWT.Requirement__c = recordId;
            oWT.Complexity__c = '3 - Low Complexity Development with Config';
            listWorkTask.add(oWT); 
        }
        return listWorkTask;
    }


    /**
     * Static method that generates multiple instances of an Connected_Instance__c object
     * with its required field values pre-populated.
     *
     * @param   iCount  the number of Connected_Instance__c to generate
     * @return  a list of Connected_Instance__c that have not been committed
     *          to the database
    */

    public static Connected_Instance__c getConnectedInstance(String name) {
        Connected_Instance__c oConnectedIns = new Connected_Instance__c();
        oConnectedIns.Login_Id__c = 'demo@demo.com';
        oConnectedIns.Password__c = 'password';
        oConnectedIns.Name = name;
        oConnectedIns.Security_Token__c = 'token';
        return oConnectedIns;
    }

	
	/**
     * Static method that generates multiple instances of an Deployment_Component__c object
     * with its required field values pre-populated.
     *
     * @RecordID id of Work Task
     * @return  a list of Deployment_Component__c that have not been committed
     *          to the database
    */

    public static Deployment_Component__c getDeploymentComponent(Id RecordID) {
        Deployment_Component__c oDeploymentComponent = new Deployment_Component__c();
        oDeploymentComponent.Work_Task__c = RecordID;
        oDeploymentComponent.Component_Type__c = 'CustomObject';
        oDeploymentComponent.Full_Name__c = 'ABC';
        oDeploymentComponent.Label_Name__c = 'ABC';
        return oDeploymentComponent;
    }

}