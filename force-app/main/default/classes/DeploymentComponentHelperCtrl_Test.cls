/**
 * @Company     : PwC.
 * @Description : 
 * *****************************************************************************************************
 * Test Class for DeploymentComponentHelperCtrl apex controller.
 * *****************************************************************************************************
 * @History     : 
 * [19.Sept.2014] Ushank Khanna - Code Creation 
 */
 @isTest
private class DeploymentComponentHelperCtrl_Test {
    static List<Work_Task__c>  listWT = new List<Work_Task__c>();


    /**
     * Dummy Metadata API web service mock class (see MetadataCreateJobTest.cls for a better example)
    **/
    private class WebServiceMockImpl implements WebServiceMock {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType)
        {
            if(request instanceof MetadataServiceVer2.retrieve_element)
                response.put('response_x', new MetadataServiceVer2.retrieveResponse_element());
            else if(request instanceof MetadataServiceVer2.checkDeployStatus_element)
                response.put('response_x', new MetadataServiceVer2.checkDeployStatusResponse_element());
            else if(request instanceof MetadataServiceVer2.listMetadata_element)
                response.put('response_x', new MetadataServiceVer2.listMetadataResponse_element());
            else if(request instanceof MetadataServiceVer2.checkRetrieveStatus_element)
                response.put('response_x', new MetadataServiceVer2.checkRetrieveStatusResponse_element());
            else if(request instanceof MetadataServiceVer2.describeMetadata_element)
                response.put('response_x', new MetadataServiceVer2.describeMetadataResponse_element());
            else if(request instanceof MetadataServiceVer2.deploy_element)
                response.put('response_x', new MetadataServiceVer2.deployResponse_element());
            else if(request instanceof MetadataServiceVer2.updateMetadata_element)
                response.put('response_x', new MetadataServiceVer2.updateMetadataResponse_element());
            else if(request instanceof MetadataServiceVer2.renameMetadata_element)
                response.put('response_x', new MetadataServiceVer2.renameMetadataResponse_element());
            else if(request instanceof  MetadataServiceVer2.cancelDeploy_element)
                response.put('response_x', new MetadataServiceVer2.cancelDeployResponse_element());
            else if(request instanceof  MetadataServiceVer2.deleteMetadata_element)
                response.put('response_x', new MetadataServiceVer2.deleteMetadataResponse_element());
            else if(request instanceof  MetadataServiceVer2.upsertMetadata_element)
                response.put('response_x', new MetadataServiceVer2.upsertMetadataResponse_element());
            else if(request instanceof  MetadataServiceVer2.createMetadata_element)
                response.put('response_x', new MetadataServiceVer2.createMetadataResponse_element());
            else if (request instanceof  partnerSoapSforceCom.LoginResult) 
                response.put('response_x', new partnerSoapSforceCom.LoginResult());
            else if (request instanceof  partnerSoapSforceCom.Soap) 
                response.put('response_x', new partnerSoapSforceCom.Soap());
            return;
        }
    }    

    
    private static void setupData() {
        //create project.
        List<Project__c> listProject = UnitTestHelper.getProjectInstances(1);
        insert listProject;

        //create sprint
        List<Work_Package__c> listWorkPackage = UnitTestHelper.getWorkPackageInstances(1,listProject[0].Id);
        insert listWorkPackage;

        // create user stories
        List<Requirement__c> listReq = UnitTestHelper.getRequirementInstances(1,listWorkPackage[0].Id);
        insert listReq;

        //create work task
        listWT = UnitTestHelper.getWorkTaskInstances(1,listReq[0].Id);
        insert listWT;


        

    }

    @isTest static void testMyController() {
        try {
            Test.startTest();
            setupData();
            Connected_Instance__c oConnectedIns = UnitTestHelper.getConnectedInstance('dev');
            insert oConnectedIns;

            PageReference pref = Page.DeploymentComponentHelper;
            Test.setCurrentPage(pref);
            
            ApexPages.currentPage().getParameters().put('Id', listWT[0].Id);
            ApexPages.currentPage().getParameters().put('Instance', 'dev');

            DeploymentComponentHelperCtrl cont = new DeploymentComponentHelperCtrl();

            Test.stopTest();
            
        } catch(Exception ex) {
            system.assert(false,'Error should not come');
        }
    }

    @isTest static void testInstanceNull() {
        try {
            Test.startTest();
            setupData();
            
            Connected_Instance__c oConnectedIns = UnitTestHelper.getConnectedInstance('dev');
            insert oConnectedIns;


            PageReference pref = Page.DeploymentComponentHelper;
            Test.setCurrentPage(pref);
            
            ApexPages.currentPage().getParameters().put('Id', listWT[0].Id);
            //ApexPages.currentPage().getParameters().put('Instance', 'dev');

            DeploymentComponentHelperCtrl cont = new DeploymentComponentHelperCtrl();
            Test.stopTest();
        } catch(Exception ex) {
            system.assert(false,'exception occur');
        }
    }


     @isTest static void testInstanceNotPopulated() {
        try {
            Test.startTest();
            setupData();
            


            
            PageReference pref = Page.DeploymentComponentHelper;
            Test.setCurrentPage(pref);
            
            ApexPages.currentPage().getParameters().put('Id', listWT[0].Id);
            ApexPages.currentPage().getParameters().put('Instance', 'dev');

            DeploymentComponentHelperCtrl cont = new DeploymentComponentHelperCtrl();
            Test.stopTest();
        } catch(Exception ex) {
            system.assert(false,'exception occur');
        }
    }


    @isTest static void testInstanceWrongPassword() {
        try {
            Test.startTest();
            setupData();

            Connected_Instance__c oConnectedIns = UnitTestHelper.getConnectedInstance('dev');
            oConnectedIns.Password__c = '';
            insert oConnectedIns;

            
            PageReference pref = Page.DeploymentComponentHelper;
            Test.setCurrentPage(pref);
            
            ApexPages.currentPage().getParameters().put('Id', listWT[0].Id);
            ApexPages.currentPage().getParameters().put('Instance', 'dev');

            DeploymentComponentHelperCtrl cont = new DeploymentComponentHelperCtrl();
            Test.stopTest();
        } catch(Exception ex) {
            system.assert(false,'exception occur');
        }
    }


    @isTest static void testPageButtonFeature() {
        try {
            Test.startTest();
            setupData();

            Connected_Instance__c oConnectedIns = UnitTestHelper.getConnectedInstance('dev');
            oConnectedIns.Password__c = '';
            insert oConnectedIns;

            Deployment_Component__c oDiploymentComponent = UnitTestHelper.getDeploymentComponent(listWT[0].id);
            insert oDiploymentComponent;
            
            PageReference pref = Page.DeploymentComponentHelper;
            Test.setCurrentPage(pref);
            
            ApexPages.currentPage().getParameters().put('Id', listWT[0].Id);
            ApexPages.currentPage().getParameters().put('Instance', 'dev');

            DeploymentComponentHelperCtrl cont = new DeploymentComponentHelperCtrl();

            PageReference oPage = cont.filterRecords();
            
            oPage = cont.refreshMassUpdateField();
            oPage = cont.massUpdateSelected();
            oPage = cont.selectAll();
            oPage = cont.deSelectAll();
            Integer i = cont.getPageStartIndex();
            Integer i1 = cont.getPageEndIndex();
            cont.setCurrentPageNumber(1);
            Integer i2 = cont.getCurrentPageNumber();

            oPage = cont.selectAllSearchSection();
            oPage = cont.deSelectAllSearchSection();
            boolean b = cont.getHasPreviousPage();
            boolean b1 = cont.getHasResults();
            boolean b2 = cont.getHasNextPage();

            Test.stopTest();
        } catch(Exception ex) {
            system.debug('exception'+ex.getMessage());
        }
    }


    @isTest static void testWebservice() {
        try {
            Test.startTest();
            setupData();

            Connected_Instance__c oConnectedIns = UnitTestHelper.getConnectedInstance('dev');
            oConnectedIns.Password__c = '';
            insert oConnectedIns;

            Deployment_Component__c oDiploymentComponent = UnitTestHelper.getDeploymentComponent(listWT[0].id);
            insert oDiploymentComponent;
            
            PageReference pref = Page.DeploymentComponentHelper;
            Test.setCurrentPage(pref);
            
            ApexPages.currentPage().getParameters().put('Id', listWT[0].Id);
            ApexPages.currentPage().getParameters().put('Instance', 'dev');
            DeploymentComponentHelperCtrl cont = new DeploymentComponentHelperCtrl();
            cont.sParentName = 'Account';
            cont.sMetaDataType = 'CustomField';
            
            DeploymentComponentHelperCtrl.WrapperComponentList oWrapperComponentList = new DeploymentComponentHelperCtrl.WrapperComponentList(oDiploymentComponent);
            DeploymentComponentHelperCtrl.WrapperComponentList oWrapperComponentList1 = new DeploymentComponentHelperCtrl.WrapperComponentList(oDiploymentComponent, 'Name');

            DeploymentComponentHelperCtrl.WrapperFields oWrapperFields = new DeploymentComponentHelperCtrl.WrapperFields();
            oWrapperComponentList  = cont.wrapCRItem('CustomField');

            System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
            // Only required to workaround a current code coverage bug in the platform
            partnerSoapSforceCom oPartnerSoapSforceCom = new partnerSoapSforceCom();
            // Invoke operations         
            partnerSoapSforceCom.Soap metaDataPort = new partnerSoapSforceCom.Soap();
            Test.stopTest();
        } catch(Exception ex) {
            system.debug('exception'+ex.getMessage());
        }
    }
}