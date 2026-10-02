/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class partnerSoapSforceCom_Test {


    /**
     * Dummy Metadata API web service mock class (see MetadataCreateJobTest.cls for a better example)
    **/
    private class WebServiceMockImpl implements WebServiceMock {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType)
        {
            if(request instanceof partnerSoapSforceCom.DescribeSoftphoneLayoutResult)
                response.put('response_x', new partnerSoapSforceCom.describeSoftphoneLayoutResponse_element());
            else if(request instanceof partnerSoapSforceCom.queryMore_element)
                response.put('response_x', new partnerSoapSforceCom.queryMoreResponse_element());
            else if(request instanceof partnerSoapSforceCom.DescribeAppMenuResult)
                response.put('response_x', new partnerSoapSforceCom.describeAppMenuResponse_element());
            else if(request instanceof partnerSoapSforceCom.DescribeSoftphoneLayoutItem)
                response.put('response_x', new partnerSoapSforceCom.describeSoftphoneLayoutResponse_element());
            else if(request instanceof partnerSoapSforceCom.DescribeSoftphoneLayoutSection)
                response.put('response_x', new partnerSoapSforceCom.describeSoftphoneLayoutResponse_element());
            else if(request instanceof partnerSoapSforceCom.PerformQuickActionRequest)
                response.put('response_x', new partnerSoapSforceCom.performQuickActionsResponse_element());
            else if(request instanceof partnerSoapSforceCom.DescribeApprovalLayoutResult)
                response.put('response_x', new partnerSoapSforceCom.describeApprovalLayoutResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeGlobal_element)
                response.put('response_x', new partnerSoapSforceCom.describeGlobalResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeGlobalTheme_element)
                response.put('response_x', new partnerSoapSforceCom.describeGlobalThemeResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeDataCategoryGroupStructures_element)
                response.put('response_x', new partnerSoapSforceCom.describeDataCategoryGroupStructuresResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeDataCategoryGroupStructures_element)
                response.put('response_x', new partnerSoapSforceCom.describeDataCategoryGroupStructuresResponse_element());
            else if(request instanceof partnerSoapSforceCom.sendEmail_element)
                response.put('response_x', new partnerSoapSforceCom.sendEmailResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeAvailableQuickActions_element)
                response.put('response_x', new partnerSoapSforceCom.describeAvailableQuickActionsResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeCompactLayouts_element)
                response.put('response_x', new partnerSoapSforceCom.describeCompactLayoutsResponse_element());
            else if(request instanceof partnerSoapSforceCom.retrieve_element)
                response.put('response_x', new partnerSoapSforceCom.retrieveResponse_element());
            else if(request instanceof partnerSoapSforceCom.emptyRecycleBin_element)
                response.put('response_x', new partnerSoapSforceCom.emptyRecycleBinResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeLayout_element)
                response.put('response_x', new partnerSoapSforceCom.describeLayoutResponse_element());
            else if(request instanceof partnerSoapSforceCom.process_element)
                response.put('response_x', new partnerSoapSforceCom.processResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeAppMenu_element)
                response.put('response_x', new partnerSoapSforceCom.describeAppMenuResponse_element());
            else if(request instanceof partnerSoapSforceCom.logout_element)
                response.put('response_x', new partnerSoapSforceCom.logoutResponse_element());
            else if(request instanceof partnerSoapSforceCom.create_element)
                response.put('response_x', new partnerSoapSforceCom.createResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeAllTabs_element)
                response.put('response_x', new partnerSoapSforceCom.describeAllTabsResponse_element());
            else if(request instanceof partnerSoapSforceCom.invalidateSessions_element)
                response.put('response_x', new partnerSoapSforceCom.invalidateSessionsResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeKnowledgeSettings_element)
                response.put('response_x', new partnerSoapSforceCom.describeKnowledgeSettingsResponse_element());
            else if(request instanceof partnerSoapSforceCom.getUserInfo_element)
                response.put('response_x', new partnerSoapSforceCom.getUserInfoResponse_element());
            else if(request instanceof partnerSoapSforceCom.describePrimaryCompactLayouts_element)
                response.put('response_x', new partnerSoapSforceCom.describePrimaryCompactLayoutsResponse_element());
            else if(request instanceof partnerSoapSforceCom.getServerTimestamp_element)
                response.put('response_x', new partnerSoapSforceCom.getServerTimestampResponse_element());
            else if(request instanceof partnerSoapSforceCom.getDeleted_element)
                response.put('response_x', new partnerSoapSforceCom.getDeletedResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeSearchLayouts_element)
                response.put('response_x', new partnerSoapSforceCom.describeSearchLayoutsResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeQuickActions_element)
                response.put('response_x', new partnerSoapSforceCom.describeQuickActionsResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeFlexiPages_element)
                response.put('response_x', new partnerSoapSforceCom.describeFlexiPagesResponse_element());
            else if(request instanceof partnerSoapSforceCom.setPassword_element)
                response.put('response_x', new partnerSoapSforceCom.setPasswordResponse_element());
            else if(request instanceof partnerSoapSforceCom.sendEmailMessage_element)
                response.put('response_x', new partnerSoapSforceCom.sendEmailMessageResponse_element());
            else if(request instanceof partnerSoapSforceCom.retrieveQuickActionTemplates_element)
                response.put('response_x', new partnerSoapSforceCom.retrieveQuickActionTemplatesResponse_element());
            else if(request instanceof partnerSoapSforceCom.delete_element)
                response.put('response_x', new partnerSoapSforceCom.deleteResponse_element());
            else if(request instanceof partnerSoapSforceCom.performQuickActions_element)
                response.put('response_x', new partnerSoapSforceCom.performQuickActionsResponse_element());
            else if(request instanceof partnerSoapSforceCom.login_element)
                response.put('response_x', new partnerSoapSforceCom.loginResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeTabs_element)
                response.put('response_x', new partnerSoapSforceCom.describeTabsResponse_element());
            else if(request instanceof partnerSoapSforceCom.search_element)
                response.put('response_x', new partnerSoapSforceCom.searchResponse_element());
            else if(request instanceof partnerSoapSforceCom.queryMore_element)
                response.put('response_x', new partnerSoapSforceCom.queryMoreResponse_element());                
            else if(request instanceof partnerSoapSforceCom.describeDataCategoryGroups_element)
                response.put('response_x', new partnerSoapSforceCom.describeDataCategoryGroupsResponse_element());                
            else if(request instanceof partnerSoapSforceCom.describeSearchScopeOrder_element)
                response.put('response_x', new partnerSoapSforceCom.describeSearchScopeOrderResponse_element());                
            else if(request instanceof partnerSoapSforceCom.describeSoftphoneLayout_element)
                response.put('response_x', new partnerSoapSforceCom.describeSoftphoneLayoutResponse_element());            
            else if(request instanceof partnerSoapSforceCom.describeSObject_element)
                response.put('response_x', new partnerSoapSforceCom.describeSObjectResponse_element());                
            else if(request instanceof partnerSoapSforceCom.describeTheme_element)
                response.put('response_x', new partnerSoapSforceCom.describeThemeResponse_element());                            
            else if(request instanceof partnerSoapSforceCom.describeSObjects_element)
                response.put('response_x', new partnerSoapSforceCom.describeSObjectsResponse_element());
            else if(request instanceof partnerSoapSforceCom.getUpdated_element)
                response.put('response_x', new partnerSoapSforceCom.getUpdatedResponse_element());                                
            else if(request instanceof partnerSoapSforceCom.upsert_element)
                response.put('response_x', new partnerSoapSforceCom.upsertResponse_element());   
            else if(request instanceof partnerSoapSforceCom.queryAll_element)
                response.put('response_x', new partnerSoapSforceCom.queryAllResponse_element());
            else if(request instanceof partnerSoapSforceCom.describeApprovalLayout_element)
                response.put('response_x', new partnerSoapSforceCom.describeApprovalLayoutResponse_element());                                               
            else if(request instanceof partnerSoapSforceCom.resetPassword_element)
                response.put('response_x', new partnerSoapSforceCom.resetPasswordResponse_element());   
            else if(request instanceof partnerSoapSforceCom.merge_element)
                response.put('response_x', new partnerSoapSforceCom.mergeResponse_element());                
            else if(request instanceof partnerSoapSforceCom.query_element)
                response.put('response_x', new partnerSoapSforceCom.queryResponse_element());                
            else if(request instanceof partnerSoapSforceCom.undelete_element)
                response.put('response_x', new partnerSoapSforceCom.undeleteResponse_element());                
            else if(request instanceof partnerSoapSforceCom.update_element)
                response.put('response_x', new partnerSoapSforceCom.updateResponse_element());
                
            return;
        }
    }  
    
    @IsTest  
    public static void partnerSoapSforceComTest1() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.describeGlobalTheme();
        partnerSoap.describeDataCategoryGroupStructures(null, false);
        partnerSoap.sendEmail(null);
        partnerSoap.describeAvailableQuickActions(null);
        partnerSoap.describeCompactLayouts(null,null);
        partnerSoap.describeGlobal();
        partnerSoap.retrieve_x(null, null, null);
        partnerSoap.emptyRecycleBin(null);
        
    }
    
    @IsTest  
    public static void partnerSoapSforceComTest2() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.describeLayout(null, null, null);
        partnerSoap.describeAllTabs();
        partnerSoap.process(null);
        partnerSoap.describeAppMenu(null);
        partnerSoap.logout();
        partnerSoap.create(null);
    }
    
    @IsTest  
    public static void partnerSoapSforceComTest3() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.invalidateSessions(null);
        partnerSoap.describeKnowledgeSettings();
        partnerSoap.getUserInfo();
        partnerSoap.describePrimaryCompactLayouts(null);
        partnerSoap.getServerTimestamp();
    }
    
    @IsTest  
    public static void partnerSoapSforceComTest4() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.getDeleted(null, null, null);
        partnerSoap.describeSearchLayouts(null);
        partnerSoap.describeQuickActions(null);
        partnerSoap.describeFlexiPages(null);
        partnerSoap.setPassword(null, null);
        partnerSoap.sendEmailMessage(null);
    }
    
    @IsTest  
    public static void partnerSoapSforceComTest5() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.retrieveQuickActionTemplates(null, null);
        partnerSoap.delete_x(null);
        partnerSoap.performQuickActions(null);
        partnerSoap.login(null, null);
        partnerSoap.describeTabs();
        partnerSoap.search_x(null);
    }
    
    @IsTest  
    public static void partnerSoapSforceComTest6() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.queryMore(null);
        partnerSoap.describeDataCategoryGroups(null);
        partnerSoap.describeSearchScopeOrder();
        partnerSoap.describeSoftphoneLayout();
        partnerSoap.describeSObject(null);
        partnerSoap.describeTheme(null);
    }
    
    @IsTest  
    public static void partnerSoapSforceComTest7() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.describeSObjects(null);
        partnerSoap.getUpdated(null, null, null);
        partnerSoap.upsert_x(null, null);
        partnerSoap.queryAll(null);
        partnerSoap.describeApprovalLayout(null, null);
        partnerSoap.resetPassword(null);
    }
    
    @IsTest  
    public static void partnerSoapSforceComTest8() {
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        partnerSoapSforceCom partnerSoapSforceCom = new partnerSoapSforceCom();
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoap.merge_x(null);
        partnerSoap.query(null);
        partnerSoap.undelete_x(null);
        partnerSoap.update_x(null);
        partnerSoap.describeApprovalLayout(null, null);
        partnerSoap.resetPassword(null);
    }

    @IsTest  
    public static void partnerWebservice() {
        new partnerSoapSforceCom.DescribeSoftphoneLayoutResult();
        new partnerSoapSforceCom.queryMore_element();
        new partnerSoapSforceCom.DescribeAppMenuResult();
        new partnerSoapSforceCom.DescribeSoftphoneLayoutItem();
        new partnerSoapSforceCom.DescribeSoftphoneLayoutSection();
        new partnerSoapSforceCom.PerformQuickActionRequest();
        new partnerSoapSforceCom.describeQuickActionsResponse_element();
        new partnerSoapSforceCom.DescribeApprovalLayoutResult();
        new partnerSoapSforceCom.CustomLinkComponent();
        new partnerSoapSforceCom.ReportChartComponent();
        new partnerSoapSforceCom.KnowledgeLanguageItem();
        new partnerSoapSforceCom.loginResponse_element();
        new partnerSoapSforceCom.describeAppMenuResponse_element();
        new partnerSoapSforceCom.Email();
        new partnerSoapSforceCom.describeSoftphoneLayout_element();
        new partnerSoapSforceCom.getServerTimestamp_element();
        new partnerSoapSforceCom.ChildRelationship();
        new partnerSoapSforceCom.process_element();
        new partnerSoapSforceCom.DescribeLayoutComponent();
        new partnerSoapSforceCom.LimitInfo();
        new partnerSoapSforceCom.LimitInfoHeader_element();
        new partnerSoapSforceCom.QueryOptions_element();
        new partnerSoapSforceCom.CallOptions_element();
        new partnerSoapSforceCom.describeAvailableQuickActions_element();
        new partnerSoapSforceCom.AllOrNoneHeader_element();
        new partnerSoapSforceCom.DescribeSoftphoneLayoutInfoField();
        new partnerSoapSforceCom.describeTabsResponse_element();
        new partnerSoapSforceCom.describeTabs_element();
        new partnerSoapSforceCom.DescribeLayoutButton();
        new partnerSoapSforceCom.describeGlobalResponse_element();
        new partnerSoapSforceCom.SendEmailError();
        new partnerSoapSforceCom.DescribeLayoutItem();
        new partnerSoapSforceCom.emptyRecycleBin_element();
        new partnerSoapSforceCom.DisableFeedTrackingHeader_element();
        new partnerSoapSforceCom.MergeResult();
        new partnerSoapSforceCom.describeAppMenu_element();
        new partnerSoapSforceCom.searchResponse_element();
        new partnerSoapSforceCom.sendEmail_element();
        new partnerSoapSforceCom.delete_element();
        new partnerSoapSforceCom.DescribeQuickActionListResult();
        new partnerSoapSforceCom.DescribeLayoutButtonSection();
        new partnerSoapSforceCom.updateResponse_element();
        new partnerSoapSforceCom.DescribeComponentInstanceProperty();
        new partnerSoapSforceCom.retrieve_element();
        new partnerSoapSforceCom.RelatedList();
        new partnerSoapSforceCom.describeGlobalThemeResponse_element();
        new partnerSoapSforceCom.describeSearchScopeOrderResponse_element();
        new partnerSoapSforceCom.describeApprovalLayout_element();
        new partnerSoapSforceCom.DescribeThemeItem();
        new partnerSoapSforceCom.create_element();
        new partnerSoapSforceCom.DescribeFlexiPageRegion();
        new partnerSoapSforceCom.describeThemeResponse_element();
        new partnerSoapSforceCom.createResponse_element();
        new partnerSoapSforceCom.describeKnowledgeSettings_element();
        new partnerSoapSforceCom.ProcessRequest();
        new partnerSoapSforceCom.LeadConvert();
        new partnerSoapSforceCom.DescribeQuickActionListItemResult();
        new partnerSoapSforceCom.QuickActionTemplateResult();
        new partnerSoapSforceCom.LocaleOptions_element();
        new partnerSoapSforceCom.DescribeSoftphoneScreenPopOption();
        new partnerSoapSforceCom.getUpdatedResponse_element();
        new partnerSoapSforceCom.StreamingEnabledHeader_element();
        new partnerSoapSforceCom.DescribeDataCategoryGroupResult();
        new partnerSoapSforceCom.FilteredLookupInfo();
        new partnerSoapSforceCom.DataCategory();
        new partnerSoapSforceCom.DescribeLayoutResult();
        new partnerSoapSforceCom.GetDeletedResult();
        new partnerSoapSforceCom.DescribeLayoutSection();
        new partnerSoapSforceCom.AssignmentRuleHeader_element();
        new partnerSoapSforceCom.PackageVersionHeader_element();
        new partnerSoapSforceCom.retrieveQuickActionTemplatesResponse_element();
        new partnerSoapSforceCom.login_element();
        new partnerSoapSforceCom.SendEmailResult();
        new partnerSoapSforceCom.PicklistForRecordType();
        new partnerSoapSforceCom.getUpdated_element();
        new partnerSoapSforceCom.upsertResponse_element();
        new partnerSoapSforceCom.Field();
        new partnerSoapSforceCom.describeFlexiPagesResponse_element();
        new partnerSoapSforceCom.describeSObjectsResponse_element();
        new partnerSoapSforceCom.undeleteResponse_element();
        new partnerSoapSforceCom.setPasswordResponse_element();
        new partnerSoapSforceCom.describeLayout_element();
        new partnerSoapSforceCom.DescribeLayout();
        new partnerSoapSforceCom.sendEmailResponse_element();
        new partnerSoapSforceCom.describeKnowledgeSettingsResponse_element();
        new partnerSoapSforceCom.PicklistEntry();
        new partnerSoapSforceCom.UserTerritoryDeleteHeader_element();
        new partnerSoapSforceCom.describeApprovalLayoutResponse_element();
        new partnerSoapSforceCom.DescribeQuickActionResult();
        new partnerSoapSforceCom.KnowledgeSettings();
        new partnerSoapSforceCom.DescribeGlobalSObjectResult();
        new partnerSoapSforceCom.RecordTypeMapping();
        new partnerSoapSforceCom.InvalidateSessionsResult();
        new partnerSoapSforceCom.logoutResponse_element();
        new partnerSoapSforceCom.retrieveQuickActionTemplates_element();
        new partnerSoapSforceCom.DescribeSObjectResult();
        new partnerSoapSforceCom.UpsertResult();
        new partnerSoapSforceCom.DescribeCompactLayoutsResult();
        new partnerSoapSforceCom.getUserInfoResponse_element();
        new partnerSoapSforceCom.DescribeTabSetResult();
        new partnerSoapSforceCom.DescribeAppMenuItem();
        new partnerSoapSforceCom.mergeResponse_element();
        new partnerSoapSforceCom.describePrimaryCompactLayoutsResponse_element();
        new partnerSoapSforceCom.MassEmailMessage();
        new partnerSoapSforceCom.SingleEmailMessage();
        new partnerSoapSforceCom.describeAllTabs_element();
        new partnerSoapSforceCom.DataCategoryGroupSobjectTypePair();
        new partnerSoapSforceCom.query_element();
        new partnerSoapSforceCom.describeGlobalTheme_element();
        new partnerSoapSforceCom.SearchResult();
        new partnerSoapSforceCom.DeletedRecord();
        new partnerSoapSforceCom.DescribeIcon();
        new partnerSoapSforceCom.getServerTimestampResponse_element();
        new partnerSoapSforceCom.ProcessSubmitRequest();
        new partnerSoapSforceCom.invalidateSessions_element();
        new partnerSoapSforceCom.queryAllResponse_element();
        new partnerSoapSforceCom.retrieveResponse_element();
        new partnerSoapSforceCom.describePrimaryCompactLayouts_element();
        new partnerSoapSforceCom.GetServerTimestampResult();
        new partnerSoapSforceCom.queryAll_element();
        new partnerSoapSforceCom.DescribeSearchLayoutResult();
        new partnerSoapSforceCom.describeLayoutResponse_element();
        new partnerSoapSforceCom.location();
        new partnerSoapSforceCom.describeSearchLayouts_element();
        new partnerSoapSforceCom.describeCompactLayoutsResponse_element();
        new partnerSoapSforceCom.DescribeGlobalTheme();
        new partnerSoapSforceCom.DescribeGlobalResult();
        new partnerSoapSforceCom.getDeleted_element();
        new partnerSoapSforceCom.PackageVersion();
        new partnerSoapSforceCom.SearchRecord();
        new partnerSoapSforceCom.NamedLayoutInfo();
        new partnerSoapSforceCom.describeSObjectResponse_element();
        new partnerSoapSforceCom.EmailHeader_element();
        new partnerSoapSforceCom.RelatedListColumn();
        new partnerSoapSforceCom.GetUpdatedResult();
        new partnerSoapSforceCom.DescribeQuickActionDefaultValue();
        new partnerSoapSforceCom.performQuickActionsResponse_element();
        new partnerSoapSforceCom.resetPassword_element();
        new partnerSoapSforceCom.UndeleteResult();
        new partnerSoapSforceCom.Error();
        new partnerSoapSforceCom.DebuggingHeader_element();
        new partnerSoapSforceCom.SetPasswordResult();
        new partnerSoapSforceCom.DescribeApprovalLayout();
        new partnerSoapSforceCom.getUserInfo_element();
        new partnerSoapSforceCom.LoginResult();
        new partnerSoapSforceCom.Soap();
        new partnerSoapSforceCom.DescribeTab();
        new partnerSoapSforceCom.MergeRequest();
        new partnerSoapSforceCom.resetPasswordResponse_element();
        new partnerSoapSforceCom.address();
        new partnerSoapSforceCom.sendEmailMessageResponse_element();
        new partnerSoapSforceCom.describeFlexiPages_element();
        new partnerSoapSforceCom.DescribeThemeResult();
        new partnerSoapSforceCom.DescribeSoftphoneLayoutCallType();
        new partnerSoapSforceCom.setPassword_element();
        new partnerSoapSforceCom.describeAvailableQuickActionsResponse_element();
        new partnerSoapSforceCom.describeAllTabsResponse_element();
        new partnerSoapSforceCom.DescribeCompactLayout();
        new partnerSoapSforceCom.DescribeLayoutRow();
        new partnerSoapSforceCom.OwnerChangeOptions_element();
        new partnerSoapSforceCom.upsert_element();
        new partnerSoapSforceCom.queryMoreResponse_element();
        new partnerSoapSforceCom.DeleteResult();
        new partnerSoapSforceCom.undelete_element();
        new partnerSoapSforceCom.DebuggingInfo_element();
        new partnerSoapSforceCom.RelatedListSort();
        new partnerSoapSforceCom.describeQuickActions_element();
        new partnerSoapSforceCom.DescribeAvailableQuickActionResult();
        new partnerSoapSforceCom.search_element();
        new partnerSoapSforceCom.update_element();
        new partnerSoapSforceCom.convertLead_element();
        new partnerSoapSforceCom.describeDataCategoryGroupStructuresResponse_element();
        new partnerSoapSforceCom.describeSObjects_element();
        new partnerSoapSforceCom.RecordTypeCompactLayoutMapping();
        new partnerSoapSforceCom.deleteResponse_element();
        new partnerSoapSforceCom.getDeletedResponse_element();
        new partnerSoapSforceCom.SaveResult();
        new partnerSoapSforceCom.AllowFieldTruncationHeader_element();
        new partnerSoapSforceCom.describeDataCategoryGroups_element();
        new partnerSoapSforceCom.DescribeFlexiPageResult();
        new partnerSoapSforceCom.DescribeDataCategoryGroupStructureResult();
        new partnerSoapSforceCom.SessionHeader_element();
        new partnerSoapSforceCom.ProcessWorkitemRequest();
        new partnerSoapSforceCom.DescribeSearchScopeOrderResult();
        new partnerSoapSforceCom.processResponse_element();
        new partnerSoapSforceCom.MruHeader_element();
        new partnerSoapSforceCom.sendEmailMessage_element();
        new partnerSoapSforceCom.LeadConvertResult();
        new partnerSoapSforceCom.FieldLayoutComponent();
        new partnerSoapSforceCom.performQuickActions_element();
        new partnerSoapSforceCom.QueryResult();
        new partnerSoapSforceCom.GetUserInfoResult();
        new partnerSoapSforceCom.DescribeRelatedContentItem();
        new partnerSoapSforceCom.DescribeComponentInstance();
        new partnerSoapSforceCom.describeDataCategoryGroupStructures_element();
        new partnerSoapSforceCom.RelatedContent();
        new partnerSoapSforceCom.EmptyRecycleBinResult();
        new partnerSoapSforceCom.emptyRecycleBinResponse_element();
        new partnerSoapSforceCom.queryResponse_element();
        new partnerSoapSforceCom.DescribeColumn();
        new partnerSoapSforceCom.RecordTypeInfo();
        new partnerSoapSforceCom.describeGlobal_element();
        new partnerSoapSforceCom.describeSoftphoneLayoutResponse_element();
        new partnerSoapSforceCom.describeTheme_element();
        new partnerSoapSforceCom.merge_element();
        new partnerSoapSforceCom.DescribeColor();
        new partnerSoapSforceCom.ResetPasswordResult();
        new partnerSoapSforceCom.PerformQuickActionResult();
        new partnerSoapSforceCom.describeDataCategoryGroupsResponse_element();
        new partnerSoapSforceCom.logout_element();
        new partnerSoapSforceCom.ProcessResult();
        new partnerSoapSforceCom.describeCompactLayouts_element();
        new partnerSoapSforceCom.describeSObject_element();
    }
}