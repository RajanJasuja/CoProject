/**
 * @Company     : PwC.
 * @Description : 
 * *****************************************************************************************************
 * Test class for MetadataServiceVer2Ver2 class.
 * *****************************************************************************************************
 * @History     : 
 * [22.Sept.2014] Ushank Khanna - Code Creation 
 */

@isTest
private class MetadataServiceVer2_Test {
    
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
            return;
        }
    }    

    @IsTest
    private static void coverGeneratedCodeCRUDOperations()
    {   
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataServiceVer2 metaDataService = new MetadataServiceVer2();
        // Invoke operations         
        MetadataServiceVer2.MetadataWebSvc metaDataPort = new MetadataServiceVer2.MetadataWebSvc();
    }
    
    @IsTest
    private static void coverGeneratedCodeFileBasedOperations1()
    {       
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataServiceVer2 MetadataServiceVer2 = new MetadataServiceVer2();
        // Invoke operations         
        MetadataServiceVer2.MetadataWebSvc metaDataPort = new MetadataServiceVer2.MetadataWebSvc();
        metaDataPort.retrieve_x(null);
        metaDataPort.checkDeployStatus(null, false);
        metaDataPort.listMetadata(null, null);
        metaDataPort.describeMetadata(null);
        metaDataPort.checkRetrieveStatus(null);
        metaDataPort.deploy(null, null);
        metaDataPort.checkDeployStatus(null, false);
        metaDataPort.updateMetadata(null);
        metaDataPort.renameMetadata(null, null, null);
        metaDataPort.cancelDeploy(null);
    }

    @IsTest
    private static void coverGeneratedCodeFileBasedOperations2()
    {       
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataServiceVer2 MetadataServiceVer2 = new MetadataServiceVer2();
        // Invoke operations         
        MetadataServiceVer2.MetadataWebSvc metaDataPort = new MetadataServiceVer2.MetadataWebSvc();
        metaDataPort.deleteMetadata(null, null);
        metaDataPort.upsertMetadata(null);
        metaDataPort.createMetadata(null);
    }
        
    @IsTest
    private static void coverGeneratedCodeTypes()
    {              
        // Reference types
        new MetadataServiceVer2();
        new MetadataServiceVer2.listMetadataResponse_element();
        new MetadataServiceVer2.WorkflowRule();
        new MetadataServiceVer2.AccountOwnerSharingRule();
        new MetadataServiceVer2.RecordTypeTranslation();
        new MetadataServiceVer2.checkDeployStatus_element();
        new MetadataServiceVer2.CodeCoverageWarning();
        new MetadataServiceVer2.FlowApexPluginCall();
        new MetadataServiceVer2.FlowInputValidationRule();
        new MetadataServiceVer2.FlowFormula();
        new MetadataServiceVer2.CustomObjectCriteriaBasedSharingRule();
        new MetadataServiceVer2.PasswordPolicies();
        new MetadataServiceVer2.QueueSobject();
        new MetadataServiceVer2.CaseSharingRules();
        new MetadataServiceVer2.PicklistValueTranslation();
        new MetadataServiceVer2.OpportunityOwnerSharingRule();
        new MetadataServiceVer2.ContactOwnerSharingRule();
        new MetadataServiceVer2.CustomDataType();
        new MetadataServiceVer2.PrimaryTabComponents();
        new MetadataServiceVer2.WorkflowEmailRecipient();
        new MetadataServiceVer2.DescribeMetadataResult();
        new MetadataServiceVer2.RecordType();
        new MetadataServiceVer2.Scontrol();
        new MetadataServiceVer2.DashboardComponent();
        new MetadataServiceVer2.ContactCriteriaBasedSharingRule();
        new MetadataServiceVer2.FilterItem();
        new MetadataServiceVer2.Profile();
        new MetadataServiceVer2.ReportFilter();
        new MetadataServiceVer2.PermissionSetApexClassAccess();
        new MetadataServiceVer2.LogInfo();
        new MetadataServiceVer2.Layout();
        new MetadataServiceVer2.WebLink();
        new MetadataServiceVer2.WorkflowTaskTranslation();
        new MetadataServiceVer2.FlowElement();
        new MetadataServiceVer2.ObjectNameCaseValue();
        new MetadataServiceVer2.FlowInputFieldAssignment();
        new MetadataServiceVer2.CustomDataTypeTranslation();
        new MetadataServiceVer2.DashboardComponentSection();
        new MetadataServiceVer2.ReportTypeColumn();
        new MetadataServiceVer2.CallOptions_element();
        new MetadataServiceVer2.CustomObjectOwnerSharingRule();
        new MetadataServiceVer2.CustomFieldTranslation();
        new MetadataServiceVer2.AnalyticSnapshot();
        new MetadataServiceVer2.FlowRule();
        new MetadataServiceVer2.FlowRecordUpdate();
        new MetadataServiceVer2.CustomSite();
        new MetadataServiceVer2.ReportBlockInfo();
        new MetadataServiceVer2.describeMetadataResponse_element();
        new MetadataServiceVer2.CaseOwnerSharingRule();
        new MetadataServiceVer2.ScontrolTranslation();
        new MetadataServiceVer2.DeployMessage();
        new MetadataServiceVer2.FlowSubflowInputAssignment();
        new MetadataServiceVer2.Group_x();
        new MetadataServiceVer2.ReportColumn();
        new MetadataServiceVer2.ReportType();
        new MetadataServiceVer2.CustomPageWebLink();
        new MetadataServiceVer2.CodeCoverageResult();
        new MetadataServiceVer2.ApexComponent();
        new MetadataServiceVer2.BaseSharingRule();
        new MetadataServiceVer2.WorkflowKnowledgePublish();
        new MetadataServiceVer2.NetworkAccess();
        new MetadataServiceVer2.Workflow();
        new MetadataServiceVer2.RecordTypePicklistValue();
        new MetadataServiceVer2.describeMetadata_element();
        new MetadataServiceVer2.DashboardFilterColumn();
        new MetadataServiceVer2.FlowChoice();
        new MetadataServiceVer2.ReportParam();
        new MetadataServiceVer2.RoleOrTerritory();
        new MetadataServiceVer2.FlowStep();
        new MetadataServiceVer2.FlowApexPluginCallInputParameter();
        new MetadataServiceVer2.WorkflowActionReference();
        new MetadataServiceVer2.ProfileObjectPermissions();
        new MetadataServiceVer2.Role();
        new MetadataServiceVer2.RetrieveResult();
        new MetadataServiceVer2.SecuritySettings();
        new MetadataServiceVer2.WorkflowTimeTrigger();
        new MetadataServiceVer2.CustomObjectSharingRules();
        new MetadataServiceVer2.retrieve_element();
        new MetadataServiceVer2.DescribeMetadataObject();
        new MetadataServiceVer2.DashboardFilterOption();
        new MetadataServiceVer2.LayoutColumn();
        new MetadataServiceVer2.WorkflowOutboundMessage();
        new MetadataServiceVer2.RunTestSuccess();
        new MetadataServiceVer2.Queue();
        new MetadataServiceVer2.LeadSharingRules();
        new MetadataServiceVer2.ListViewFilter();
        new MetadataServiceVer2.CampaignOwnerSharingRule();
        new MetadataServiceVer2.CustomField();
        new MetadataServiceVer2.WorkflowTask();
        new MetadataServiceVer2.deployResponse_element();
        new MetadataServiceVer2.DataCategory();
        new MetadataServiceVer2.FlowOutputFieldAssignment();
        new MetadataServiceVer2.EmailTemplate();
        new MetadataServiceVer2.ReportAggregateReference();
        new MetadataServiceVer2.ObjectUsage();
        new MetadataServiceVer2.FileProperties();
        new MetadataServiceVer2.CustomTabTranslation();
        new MetadataServiceVer2.BusinessProcess();
        new MetadataServiceVer2.Flow();
        new MetadataServiceVer2.PermissionSet();
        new MetadataServiceVer2.PermissionSetObjectPermissions();
        new MetadataServiceVer2.ReportCrossFilter();
        new MetadataServiceVer2.Report();
        new MetadataServiceVer2.FlowSubflowOutputAssignment();
        new MetadataServiceVer2.ListView();
        new MetadataServiceVer2.FlowRecordCreate();
        new MetadataServiceVer2.DashboardTableColumn();
        new MetadataServiceVer2.ContactSharingRules();
        new MetadataServiceVer2.AccountTerritorySharingRules();
        new MetadataServiceVer2.AsyncResult();
        new MetadataServiceVer2.ArticleTypeChannelDisplay();
        new MetadataServiceVer2.checkRetrieveStatus_element();
        new MetadataServiceVer2.ProfileLayoutAssignment();
        new MetadataServiceVer2.ReportFolder();
        new MetadataServiceVer2.FlowTextTemplate();
        new MetadataServiceVer2.RelatedListItem();
        new MetadataServiceVer2.FlowNode();
        new MetadataServiceVer2.RetrieveRequest();
        new MetadataServiceVer2.ListMetadataQuery();
        new MetadataServiceVer2.FlowConnector();
        new MetadataServiceVer2.CustomApplicationComponent();
        new MetadataServiceVer2.FlowRecordLookup();
        new MetadataServiceVer2.FieldSet();
        new MetadataServiceVer2.ProfileApexClassAccess();
        new MetadataServiceVer2.AccountCriteriaBasedSharingRule();
        new MetadataServiceVer2.DebuggingHeader_element();
        new MetadataServiceVer2.CustomDataTypeComponentTranslation();
        new MetadataServiceVer2.FlowRecordDelete();
        new MetadataServiceVer2.FlowDecision();
        new MetadataServiceVer2.ReportTypeSectionTranslation();
        new MetadataServiceVer2.IpRange();
        new MetadataServiceVer2.FlowApexPluginCallOutputParameter();
        new MetadataServiceVer2.ReportBucketField();
        new MetadataServiceVer2.CaseCriteriaBasedSharingRule();
        new MetadataServiceVer2.CustomLabel();
        new MetadataServiceVer2.Attachment();
        new MetadataServiceVer2.SharingRules();
        new MetadataServiceVer2.CustomConsoleComponents();
        new MetadataServiceVer2.Portal();
        new MetadataServiceVer2.DomainWhitelist();
        new MetadataServiceVer2.ChartSummary();
        new MetadataServiceVer2.RunTestFailure();
        new MetadataServiceVer2.Territory();
        new MetadataServiceVer2.SharedTo();
        new MetadataServiceVer2.FlowRecordFilter();
        new MetadataServiceVer2.SubtabComponents();
        new MetadataServiceVer2.FlowScreen();
        new MetadataServiceVer2.WorkflowAlert();
        new MetadataServiceVer2.Picklist();
        new MetadataServiceVer2.ReportLayoutSection();
        new MetadataServiceVer2.SummaryLayoutItem();
        new MetadataServiceVer2.LayoutSection();
        new MetadataServiceVer2.ReportTimeFrameFilter();
        new MetadataServiceVer2.LayoutSectionTranslation();
        new MetadataServiceVer2.DataCategoryGroup();
        new MetadataServiceVer2.listMetadata_element();
        new MetadataServiceVer2.ValidationRule();
        new MetadataServiceVer2.WorkspaceMapping();
        new MetadataServiceVer2.MetadataWithContent();
        new MetadataServiceVer2.ValidationRuleTranslation();
        new MetadataServiceVer2.AccountTerritorySharingRule();
        new MetadataServiceVer2.Metadata();
        new MetadataServiceVer2.ReportBucketFieldValue();
        new MetadataServiceVer2.OpportunitySharingRules();
        new MetadataServiceVer2.HomePageLayout();
        new MetadataServiceVer2.FlowSubflow();
        new MetadataServiceVer2.FlowScreenField();
        new MetadataServiceVer2.SiteWebAddress();
        new MetadataServiceVer2.RetrieveMessage();
        new MetadataServiceVer2.Dashboard();
        new MetadataServiceVer2.EmailFolder();
        new MetadataServiceVer2.SessionHeader_element();
        new MetadataServiceVer2.SummaryLayout();
        new MetadataServiceVer2.FlowCondition();
        new MetadataServiceVer2.DeployOptions();
        new MetadataServiceVer2.FlowAssignment();
        new MetadataServiceVer2.ProfileApplicationVisibility();
        new MetadataServiceVer2.UpdateMetadata();
        new MetadataServiceVer2.CustomApplicationComponents();
        new MetadataServiceVer2.FlowElementReferenceOrValue();
        new MetadataServiceVer2.EntitlementTemplate();
        new MetadataServiceVer2.ProfileTabVisibility();
        new MetadataServiceVer2.ActionOverride();
        new MetadataServiceVer2.WorkspaceMappings();
        new MetadataServiceVer2.WorkflowAction();
        new MetadataServiceVer2.DashboardFolder();
        new MetadataServiceVer2.PermissionSetApexPageAccess();
        new MetadataServiceVer2.LayoutTranslation();
        new MetadataServiceVer2.CustomObject();
        new MetadataServiceVer2.Translations();
        new MetadataServiceVer2.ApexTrigger();
        new MetadataServiceVer2.ReportTypeTranslation();
        new MetadataServiceVer2.FlowAssignmentItem();
        new MetadataServiceVer2.CustomApplicationTranslation();
        new MetadataServiceVer2.CustomLabels();
        new MetadataServiceVer2.PackageTypeMembers();
        new MetadataServiceVer2.PicklistValue();
        new MetadataServiceVer2.RemoteSiteSetting();
        new MetadataServiceVer2.deploy_element();
        new MetadataServiceVer2.retrieveResponse_element();
        new MetadataServiceVer2.ArticleTypeTemplate();
        new MetadataServiceVer2.ReportGrouping();
        new MetadataServiceVer2.PermissionSetFieldPermissions();
        new MetadataServiceVer2.AnalyticSnapshotMapping();
        new MetadataServiceVer2.LeadCriteriaBasedSharingRule();
        new MetadataServiceVer2.SharingRecalculation();
        new MetadataServiceVer2.ProfileLoginIpRange();
        new MetadataServiceVer2.WebLinkTranslation();
        new MetadataServiceVer2.ObjectRelationship();
        new MetadataServiceVer2.ListPlacement();
        new MetadataServiceVer2.SiteRedirectMapping();
        new MetadataServiceVer2.OwnerSharingRule();
        new MetadataServiceVer2.WorkflowFieldUpdate();
        new MetadataServiceVer2.LetterheadLine();
        new MetadataServiceVer2.OpportunityCriteriaBasedSharingRule();
        new MetadataServiceVer2.CustomTab();
        new MetadataServiceVer2.FlowChoiceUserInput();
        new MetadataServiceVer2.Letterhead();
        new MetadataServiceVer2.ReportTypeColumnTranslation();
        new MetadataServiceVer2.CustomPageWebLinkTranslation();
        new MetadataServiceVer2.DocumentFolder();
        new MetadataServiceVer2.FlowConstant();
        new MetadataServiceVer2.ProfileRecordTypeVisibility();
        new MetadataServiceVer2.PackageVersion();
        new MetadataServiceVer2.CustomLabelTranslation();
        new MetadataServiceVer2.ReportChart();
        new MetadataServiceVer2.checkRetrieveStatusResponse_element();
        new MetadataServiceVer2.LeadOwnerSharingRule();
        new MetadataServiceVer2.ProfileFieldLevelSecurity();
        new MetadataServiceVer2.SharingReason();
        new MetadataServiceVer2.RunTestsResult();
        new MetadataServiceVer2.PermissionSetUserPermission();
        new MetadataServiceVer2.MiniLayout();
        new MetadataServiceVer2.FlowVariable();
        new MetadataServiceVer2.ProfileLoginHours();
        new MetadataServiceVer2.DashboardFilter();
        new MetadataServiceVer2.CodeLocation();
        new MetadataServiceVer2.ReportBucketFieldSourceValue();
        new MetadataServiceVer2.FieldSetItem();
        new MetadataServiceVer2.ReportFilterItem();
        new MetadataServiceVer2.FlowDynamicChoiceSet();
        new MetadataServiceVer2.CustomDataTypeComponent();
        new MetadataServiceVer2.CustomObjectTranslation();
        new MetadataServiceVer2.CustomApplication();
        new MetadataServiceVer2.ReportAggregate();
        new MetadataServiceVer2.ApexClass();
        new MetadataServiceVer2.CampaignSharingRules();
        new MetadataServiceVer2.DebuggingInfo_element();
        new MetadataServiceVer2.Package_x();
        new MetadataServiceVer2.SessionSettings();
        new MetadataServiceVer2.Document();
        new MetadataServiceVer2.Folder();
        new MetadataServiceVer2.DeployResult();
        new MetadataServiceVer2.CampaignCriteriaBasedSharingRule();
        new MetadataServiceVer2.LayoutItem();
        new MetadataServiceVer2.ProfileApexPageAccess();
        new MetadataServiceVer2.SharingReasonTranslation();
        new MetadataServiceVer2.checkDeployStatusResponse_element();
        new MetadataServiceVer2.ReportColorRange();
        new MetadataServiceVer2.SearchLayouts();
        new MetadataServiceVer2.LetterheadHeaderFooter();
        new MetadataServiceVer2.HomePageComponent();
        new MetadataServiceVer2.AccountSharingRules();
        new MetadataServiceVer2.MobileSettings();
        new MetadataServiceVer2.EscalationRules();
        new MetadataServiceVer2.KnowledgeAnswerSettings();
        new MetadataServiceVer2.ExternalDataSource();
        new MetadataServiceVer2.EntitlementProcess();
        new MetadataServiceVer2.IdeasSettings();
        new MetadataServiceVer2.Country();
        new MetadataServiceVer2.ReputationLevels();
        new MetadataServiceVer2.KnowledgeSitesSettings();
        new MetadataServiceVer2.AddressSettings();
        new MetadataServiceVer2.ProfileExternalDataSourceAccess();
        new MetadataServiceVer2.CallCenterItem();
        new MetadataServiceVer2.CallCenter();
        new MetadataServiceVer2.PermissionSetExternalDataSourceAccess();
        new MetadataServiceVer2.PermissionSetTabSetting();
        new MetadataServiceVer2.AuthProvider();
        new MetadataServiceVer2.EmailToCaseSettings();
        new MetadataServiceVer2.EscalationAction();
        new MetadataServiceVer2.State();
        new MetadataServiceVer2.AssignmentRule();
        new MetadataServiceVer2.AutoResponseRule();
        new MetadataServiceVer2.CaseSettings();
        new MetadataServiceVer2.ChatterAnswersSettings();
        new MetadataServiceVer2.CountriesAndStates();
        new MetadataServiceVer2.SFDCMobileSettings();
        new MetadataServiceVer2.EntitlementProcessMilestoneItem();
        new MetadataServiceVer2.TouchMobileSettings();
        new MetadataServiceVer2.AssignmentRules();
        new MetadataServiceVer2.ContractSettings();
        new MetadataServiceVer2.KnowledgeCaseSettings();
        new MetadataServiceVer2.ChatterAnswersReputationLevel();
        new MetadataServiceVer2.KnowledgeSettings();
        new MetadataServiceVer2.Community();
        new MetadataServiceVer2.AutoResponseRules();
        new MetadataServiceVer2.EmailToCaseRoutingAddress();
        new MetadataServiceVer2.RuleEntry();
        new MetadataServiceVer2.EntitlementSettings();
        new MetadataServiceVer2.CriteriaBasedSharingRule();
        new MetadataServiceVer2.ApexPage();
        new MetadataServiceVer2.WorkflowSend();
        new MetadataServiceVer2.ChatterMobileSettings();
        new MetadataServiceVer2.CallCenterSection();
        new MetadataServiceVer2.EntitlementProcessMilestoneTimeTrigger();
        new MetadataServiceVer2.StaticResource();
        new MetadataServiceVer2.MilestoneType();
        new MetadataServiceVer2.FiscalYearSettings();
        new MetadataServiceVer2.CompanySettings();
        new MetadataServiceVer2.WebToCaseSettings();
        new MetadataServiceVer2.EscalationRule();
        new MetadataServiceVer2.DashboardMobileSettings();
        new MetadataServiceVer2.FieldOverride();
        new MetadataServiceVer2.QuotasSettings();
        new MetadataServiceVer2.Skill();
        new MetadataServiceVer2.AgentConfigProfileAssignments();
        new MetadataServiceVer2.LiveAgentSettings();
        new MetadataServiceVer2.SkillAssignments();
        new MetadataServiceVer2.ActivitiesSettings();
        new MetadataServiceVer2.LiveAgentConfig();
        new MetadataServiceVer2.ApprovalPageField();
        new MetadataServiceVer2.QuickActionList();
        new MetadataServiceVer2.LiveChatButtonDeployments();
        new MetadataServiceVer2.InstalledPackage();
        new MetadataServiceVer2.PushNotification();
        new MetadataServiceVer2.LiveChatAgentConfig();
        new MetadataServiceVer2.AdjustmentsSettings();                               
        new MetadataServiceVer2.ForecastingSettings();                                
        new MetadataServiceVer2.QuickActionListItem();           
        new MetadataServiceVer2.Branding();          
        new MetadataServiceVer2.QuickActionLayoutItem();                     
        new MetadataServiceVer2.OpportunityListFieldsSelectedSettings();        
        new MetadataServiceVer2.ApprovalStepRejectBehavior();
        new MetadataServiceVer2.FolderShare();   
        new MetadataServiceVer2.ApprovalEntryCriteria();                                
        new MetadataServiceVer2.ProductSettings();                                
        new MetadataServiceVer2.OpportunitySettings();              
        new MetadataServiceVer2.LiveChatDeployment();                                
        new MetadataServiceVer2.QuickActionLayoutColumn();           
        new MetadataServiceVer2.GlobalQuickActionTranslation();      
        new MetadataServiceVer2.ApprovalStepApprover();                                
        new MetadataServiceVer2.QuoteSettings();         
        new MetadataServiceVer2.LiveChatButton();                                
        new MetadataServiceVer2.Network();
        new MetadataServiceVer2.LiveChatDeploymentDomainWhitelist();
        new MetadataServiceVer2.KnowledgeLanguageSettings();
        new MetadataServiceVer2.Approver();
        new MetadataServiceVer2.SamlSsoConfig();
        new MetadataServiceVer2.ApprovalSubmitter();
        new MetadataServiceVer2.KeyboardShortcuts();
        new MetadataServiceVer2.ApprovalStep();
        new MetadataServiceVer2.AgentConfigAssignments();
        new MetadataServiceVer2.QuickAction();
        new MetadataServiceVer2.DefaultShortcut();
        new MetadataServiceVer2.ApprovalAction();
        new MetadataServiceVer2.KnowledgeLanguage();
        new MetadataServiceVer2.LiveChatButtonSkills();
        new MetadataServiceVer2.SkillUserAssignments();
        new MetadataServiceVer2.NextAutomatedApprover();
        new MetadataServiceVer2.ApprovalProcess();
        new MetadataServiceVer2.QuickActionLayout();
        new MetadataServiceVer2.PushNotifications();
        new MetadataServiceVer2.ForecastRangeSettings();
        new MetadataServiceVer2.IdeaReputationLevel();
        new MetadataServiceVer2.NetworkTabSet();
        new MetadataServiceVer2.SkillProfileAssignments();
        new MetadataServiceVer2.CustomShortcut();
        new MetadataServiceVer2.PagesToOpen();
        new MetadataServiceVer2.AgentConfigUserAssignments();
        new MetadataServiceVer2.NetworkMemberGroup();
        new MetadataServiceVer2.FindSimilarOppFilter();
        new MetadataServiceVer2.QuickActionTranslation();               
        new MetadataServiceVer2.WorkflowFlowActionParameter();
        new MetadataServiceVer2.ConnectedAppOauthConfig();
        new MetadataServiceVer2.FlowLoop();
        new MetadataServiceVer2.UserSharingRules();
        new MetadataServiceVer2.renameMetadata_element();
        new MetadataServiceVer2.ForecastingTypeSettings();
        new MetadataServiceVer2.PermissionSetApplicationVisibility();
        new MetadataServiceVer2.FeedLayout();
        new MetadataServiceVer2.AppMenuItem();
        new MetadataServiceVer2.deleteMetadataResponse_element();
        new MetadataServiceVer2.ConnectedAppAttribute();
        new MetadataServiceVer2.ReportChartComponentLayoutItem();
        new MetadataServiceVer2.AppMenu();
        new MetadataServiceVer2.ConnectedAppIpRange();
        new MetadataServiceVer2.Error();
        new MetadataServiceVer2.ComponentInstanceProperty();
        new MetadataServiceVer2.BusinessHoursEntry();
        new MetadataServiceVer2.RelatedContent();
        new MetadataServiceVer2.SupervisorAgentConfigSkills();
        new MetadataServiceVer2.ComponentInstance();
        new MetadataServiceVer2.SidebarComponent();
        new MetadataServiceVer2.Holiday();
        new MetadataServiceVer2.SaveResult();
        new MetadataServiceVer2.readMetadataResponse_element();
        new MetadataServiceVer2.FlexiPageRegion();
        new MetadataServiceVer2.deleteMetadata_element();
        new MetadataServiceVer2.ConnectedAppMobileDetailConfig();
        new MetadataServiceVer2.AccountSettings();
        new MetadataServiceVer2.PermissionSetRecordTypeVisibility();
        new MetadataServiceVer2.OrderSettings();
        new MetadataServiceVer2.ProfileUserPermission();
        new MetadataServiceVer2.UserCriteriaBasedSharingRule();
        new MetadataServiceVer2.LookupFilterTranslation();
        new MetadataServiceVer2.WorkflowFlowAction();
        new MetadataServiceVer2.ConnectedApp();
        new MetadataServiceVer2.SiteDotCom();
        new MetadataServiceVer2.createMetadataResponse_element();
        new MetadataServiceVer2.updateMetadata_element();
        new MetadataServiceVer2.LookupFilter();
        new MetadataServiceVer2.updateMetadataResponse_element();
        new MetadataServiceVer2.FlexiPage();
        new MetadataServiceVer2.ConnectedAppSamlConfig();
        new MetadataServiceVer2.createMetadata_element();
        new MetadataServiceVer2.FeedLayoutComponent();
        new MetadataServiceVer2.PostTemplate();
        new MetadataServiceVer2.RelatedContentItem();
        new MetadataServiceVer2.readMetadata_element();
        new MetadataServiceVer2.ReadResult();
        new MetadataServiceVer2.UserMembershipSharingRule();
        new MetadataServiceVer2.BusinessHoursSettings();
        new MetadataServiceVer2.FeedLayoutFilter();
        new MetadataServiceVer2.ReportHistoricalSelector();
        new MetadataServiceVer2.ConnectedAppCanvasConfig();
        new MetadataServiceVer2.DeployDetails();
        new MetadataServiceVer2.ReportDataCategoryFilter();
        new MetadataServiceVer2.SynonymGroup();
        new MetadataServiceVer2.renameMetadataResponse_element();
        new MetadataServiceVer2.cancelDeploy_element();
        new MetadataServiceVer2.CancelDeployResult();
        new MetadataServiceVer2.SynonymDictionary();
        new MetadataServiceVer2.cancelDeployResponse_element();
        new MetadataServiceVer2.CompactLayout();
        new MetadataServiceVer2.AccessMapping();
        new MetadataServiceVer2.Container();
        new MetadataServiceVer2.DeleteResult();
        new MetadataServiceVer2.SharingSet();
        new MetadataServiceVer2.ReputationPointsRule();
        new MetadataServiceVer2.FlowActionCallInputParameter();
        new MetadataServiceVer2.CustomMetadata();
        new MetadataServiceVer2.VisualizationPlugin();
        new MetadataServiceVer2.RelatedList();
        new MetadataServiceVer2.FlowActionCallOutputParameter();
        new MetadataServiceVer2.FlowActionCall();
        new MetadataServiceVer2.CustomPermission();
        new MetadataServiceVer2.ReputationLevelDefinitions();
        new MetadataServiceVer2.PermissionSetCustomPermissions();
        new MetadataServiceVer2.upsertMetadata_element();
        new MetadataServiceVer2.ProfileCustomPermissions();
        new MetadataServiceVer2.AgentConfigButtons();
        new MetadataServiceVer2.AgentConfigSkills();
        new MetadataServiceVer2.upsertMetadataResponse_element();
        new MetadataServiceVer2.ReputationLevel();
        new MetadataServiceVer2.NameSettings();
        new MetadataServiceVer2.ReputationPointsRules();
        new MetadataServiceVer2.FlowMetadataValue();
        new MetadataServiceVer2.VisualizationResource();
        new MetadataServiceVer2.MarketingActionSettings();
        new MetadataServiceVer2.VisualizationType();
        new MetadataServiceVer2.CustomMetadataValue();
        new MetadataServiceVer2.HistoryRetentionPolicy();
        new MetadataServiceVer2.UpsertResult();
    }

    
}