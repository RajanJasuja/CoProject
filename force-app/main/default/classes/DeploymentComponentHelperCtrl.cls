/**
 * @Company     : PwC.
 * @Description : 
 * *****************************************************************************************************
 * This controller take care of "manage deployment component" button feature on work task record.
 * *****************************************************************************************************
 * @History     : 
 * [19.Sept.2014] Ushank Khanna - Code Creation 
 */

public with sharing class DeploymentComponentHelperCtrl {
    
    //final varibales
    public final Integer listLimit = 20;
    public final String SELECT_OPTION_VALUE = 'SelectOption';
    public final String SELECT_OPTION_LABEL = '--Select Option--'; 
    // Should be defined in custom setting. These contain list of component which are associated to parent.
    private final String COMPONENT_WITH_PARENT_SOBJECT = 'CustomField,FieldSet,RecordType,ValidationRule,WebLink,WorkflowAlert,WorkflowFieldUpdate,WorkflowOutboundMessage,WorkflowRule,WorkflowTask,Layout'; 
    // Should be defined in label
    public final String SYSTEM_ERROR_MSG_PREFIX = 'Error Fetching Information';
    private final String QUERY_STRING = 'Select Id, Name, CRI_Unique_ID__c, Requestor__c, Component_Type__c, Full_Name__c, Label_Name__c, API_Name__c, Parent_Component__c, Folder_Name__c, Work_Task__c, Sprint__c From Deployment_Component__c'; 
    private final String ORDER_BY = ' Order By Component_Type__c, Label_Name__c ';
    // current page number
    private Integer currentPageNbr = 1;
    // page size
    public Integer pageSize = 30;
    
    
    
    public String sMetaDataType = '';
    private List<String> listMetadataItems;
    public Id changeRequestId;
    public String sDevInstanceName;
    public String crItemsQueryStr;
    
    private Set<String> setComponentUniqueId = new Set<String>();
    public String crItemsDefaultQueryStr;
    List<Connected_Instance__c> listConnectedInstance;
    
    
    // Valiables - Controller Binding
    public Deployment_Component__c oDComponent {get;set;}
    public Deployment_Component__c crItemForUpdate {get;set;}
    public boolean bHasParent {get;set;}
    public List<SelectOption> listParentItemsOptions {get;set;}
    public String sParentName {get;set;}
    public boolean bHasResults {get;set;}
    public String componentSearchString {get;set;}
    public Boolean bShowSearchSection {get;set;}
    public Boolean bOverLimit {get;set;}
    public List<WrapperComponentList> listAvailableComponents{get;set;}
    public List<WrapperComponentList> listSelectedCRItems {get;set;}
    public String selectedField {get;set;}
    public List<SelectOption> selectOptionsFields {get;set;}
    public Deployment_Component__c crItemFilterObj {get;set;}
    public String selectedFieldUpdate {get;set;}
    public List<SelectOption> selectOptionsFieldsUpdate {get;set;}
    private final Map<String, String> mapFields = new Map<String, String> {'Type'=>'Component_Type__c', 'User Story'=>'User_Story__c', 'Status'=>'Status__c', 'Source'=>'Source__c', 'Requestor'=>'Requestor__c', 'Project'=>'Project__c', 'Code Check In Ids'=>'Checkin_Id__c'};
    private final Map<String, String> mapFieldsForUpdate = new Map<String, String> {'User Story'=>'User_Story__c', 'Status'=>'Status__c', 'Source'=>'Source__c', 'Requestor'=>'Requestor__c', 'Project'=>'Project__c', 'Code Check In Ids'=>'Checkin_Id__c'};
    
    
    
    
    public String componentSearchCriteria {get;set;}
    public String operatorString {get;set;}
    public Integer totalPages {get; private set;}
    public Integer totalRowCount {get; private set;}
    public Boolean bShowFilters {get;private set;}
    String username = null;
     String password = null;
    
    private Map<String, WrapperFields> mapFieldFullName;
    private ApexPages.StandardSetController criSetSetController = null;
    
    
    public DeploymentComponentHelperCtrl() {
        listConnectedInstance = new List<Connected_Instance__c>();
        oDComponent = new Deployment_Component__c();
        changeRequestId = ApexPages.currentPage().getParameters().get('Id'); 
        sDevInstanceName = ApexPages.currentPage().getParameters().get('Instance'); 
        
        if(String.isBlank(sDevInstanceName)) {
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, 'Please populate value of "Dev Instance Name" on sprint record');
            ApexPages.addMessage(myMsg);
        }
        else {
            listConnectedInstance = [Select Id, Login_Id__c, Password__c, Security_Token__c from Connected_Instance__c where Name =:sDevInstanceName Limit 1];
            
            if(listConnectedInstance != null && listConnectedInstance.size() >0) {
                username = listConnectedInstance[0].Login_Id__c;
                password = listConnectedInstance[0].Password__c;
                if(String.isNotBlank(listConnectedInstance[0].Security_Token__c)) {
                    password += listConnectedInstance[0].Security_Token__c;
                }
            } else if(listConnectedInstance != null && listConnectedInstance.size() ==0) {
                ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, 'Please populate Connected_Instance__c record for "Dev Instance Name" specified at sprint level!!');
                ApexPages.addMessage(myMsg);
            } else if (listConnectedInstance != null && listConnectedInstance.size() > 0 && ( String.isBlank(listConnectedInstance[0].Login_Id__c) || String.isBlank(listConnectedInstance[0].Password__c)))  {
                ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, 'Please validate login credentials of Connected_Instance__c record');
                ApexPages.addMessage(myMsg);
            }
        }

        
        
        crItemsDefaultQueryStr = QUERY_STRING + ' Where Work_Task__c = \'' + changeRequestId + '\'' + ORDER_BY;
        System.debug(LoggingLevel.INFO, 'ManageCRItemsCtrl() crItemsDefaultQueryStr: ' + crItemsDefaultQueryStr);
        retrieveCRItemsList(crItemsDefaultQueryStr);
        createOptionsFields();
    }
    
    /**
     * @Desc:   Positions the cursor to the first page in the resultset
     * @Param:  
     * @Return: 
     */     

    public void firstPage() {
        
        // reset current page
        currentPageNbr = 1;
        buildResultList();
    }

//------------------------------------------------------------------------------------------------
    /**
     * @Desc:   Positions the cursor to the last page in the resultset
     * @Param:  
     * @Return: 
     */     
    public void lastPage() {
        
        // reset current page
        currentPageNbr = totalPages;
        buildResultList();
    }
    
        /**
     * @Desc:   Positions the cursor to the previous page in the resultset
     * @Param:  
     * @Return: 
     */         

    public void previousPage() {

        // adjust current page
        currentPageNbr --;
        buildResultList();
    }
    
 
    
    
    /**
     * @Description:   
     * @param:  
     */  
    public PageReference refreshSearchField() {
        System.debug(LoggingLevel.INFO, 'refreshSearchField: ');
        try {
            crItemFilterObj = new Deployment_Component__c();
        } catch(Exception ex) {
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, SYSTEM_ERROR_MSG_PREFIX + ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    } 
    
     /**
     * @Desc:   Positions the cursor to the next page in the resultset
     * @Param:  
     * @Return: 
     */         

    public void nextPage() {

        // adjust current page
        currentPageNbr ++;
        buildResultList();
    }
    
      /**
     * @Desc:   Build Agreement wrapper list with the document for UI
     * @Param:  
     * @Return: 
     */     

    private void retrieveCRItemsList(String queryStr) {
        System.debug(LoggingLevel.INFO, 'retrieveCRItemsList() queryStr: ' + queryStr);
        // execute the query
        criSetSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryStr));
        System.debug(LoggingLevel.INFO, 'criSetSetController: ' + criSetSetController);
        if (criSetSetController != null) { 
            // set the page size
            criSetSetController.setPageSize(pageSize);
            
            totalRowCount = criSetSetController.getResultSize();
            
            totalPages = totalRowCount/pageSize;
            Integer remainder = Math.mod(totalRowCount, pageSize);
            
            if (remainder > 0) {
                totalPages ++;
            }
            
            // build wrapper list
            buildResultList();            
        } else {
            totalPages = 0;
            currentPageNbr = 0;
        }
    }
    
        /**
     * @Description:   
     * @param:  
     */  
    public void createOptionsFields() {
        
        selectOptionsFields = new List<SelectOption>();
        selectOptionsFields.add(new SelectOption(SELECT_OPTION_VALUE, SELECT_OPTION_LABEL));
        for(String fieldName : mapFields.keySet()) {
            selectOptionsFields.add(new SelectOption(mapFields.get(fieldName), fieldName));
        }
        
        selectOptionsFieldsUpdate = new List<SelectOption>();
        selectOptionsFieldsUpdate.add(new SelectOption(SELECT_OPTION_VALUE, SELECT_OPTION_LABEL));
        for(String fieldName : mapFieldsForUpdate.keySet()) {
            selectOptionsFieldsUpdate.add(new SelectOption(mapFieldsForUpdate.get(fieldName), fieldName));
        }
    } 
    
     /**
     * @Description:   
     * @param:  
     */  
    public PageReference selectFilterOwner() {
        System.debug(LoggingLevel.INFO, 'selectFilterUser()');
        crItemFilterObj.Requestor__c = UserInfo.getUserId();
        return null; 
    }
    
     /**
     * @Description:   
     * @param:  
     */  
    public PageReference filterRecords() {

        System.debug(LoggingLevel.INFO, 'selectedField: ' + selectedField);
        System.debug(LoggingLevel.INFO, 'crItemFilterObj: ' + crItemFilterObj);
        String whereStr = ' Where Work_Task__c = \'' + changeRequestId + '\'';
        Boolean isFilterValid = FALSE;
        if(!SELECT_OPTION_LABEL.equalsIgnoreCase(selectedField)) {
            if('Component_Type__c'.equalsIgnoreCase(selectedField) && crItemFilterObj.Component_Type__c != null) {
                whereStr += ' And Component_Type__c = \'' + crItemFilterObj.Component_Type__c + '\'';
                isFilterValid = TRUE;
            } else if('Requestor__c'.equalsIgnoreCase(selectedField) && crItemFilterObj.Requestor__c != null) {
                whereStr += ' And Requestor__c = \'' + crItemFilterObj.Requestor__c + '\'';
                isFilterValid = TRUE;
            } else if('Sprint__c'.equalsIgnoreCase(selectedField) && crItemFilterObj.Sprint__c != null) {
                whereStr += ' And Sprint__c = \'' + crItemFilterObj.Sprint__c + '\'';
                isFilterValid = TRUE;
            } 
        }

        crItemsQueryStr = QUERY_STRING + whereStr + ORDER_BY;

        System.debug(LoggingLevel.INFO, 'filterRecords() crItemsQueryStr: ' + crItemsQueryStr);
        retrieveCRItemsList(crItemsQueryStr);
        /*
        if(isFilterValid) {
            retrieveCRItemsList(queryStr);
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Please select the field and the value and then click on Filter Records.'));
        }
        */

        return null; 
    } 
    
    /**
     * @Description:   
     * @param:  
     */  
    public PageReference refreshMassUpdateField() {
        System.debug(LoggingLevel.INFO, 'refreshMassUpdateField: ');
        try {
            crItemForUpdate = new Deployment_Component__c();
        } catch(Exception ex) {
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, SYSTEM_ERROR_MSG_PREFIX + ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    }  
    
     /**
     * @Description:   
     * @param:  
     */  
    public PageReference massUpdateSelected() {

        try {
            
            List<Deployment_Component__c> listCRItemsForUpdate = new List<Deployment_Component__c>();

            for(WrapperComponentList cwItem : listSelectedCRItems) {
                if(cwItem.isSelected == TRUE) {
                    listCRItemsForUpdate.add(cwItem.item);
                }
            }

            if(listCRItemsForUpdate != null && !listCRItemsForUpdate.isEmpty()) {
                massUpdateCRItems(listCRItemsForUpdate);
            } else {
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Please select at least one component and then click on Mass Update Selected.'));
            }

        } catch (Exception ex){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, SYSTEM_ERROR_MSG_PREFIX + ex.getMessage()));
        }
        
        return null;
    }
//------------------------------------------------------------------------------------------------
    /**
     * @Description:   
     * @param:  
     */  
    public PageReference massUpdateAllCRItems() {
        
        try {
            massUpdateCRItems(database.query(crItemsQueryStr.trim()));
            retrieveCRItemsList(crItemsQueryStr);
        } catch (Exception ex){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, SYSTEM_ERROR_MSG_PREFIX + ex.getMessage()));
        }
        return null; 
    } 
    
     /**
     * @Description:   
     * @param:  
     */
    // TODO: redesign this method to be dynamic/Generic
    private void massUpdateCRItems(List<Deployment_Component__c> listCRItemsForUpdate) {

        
        Boolean isValidMassUpdate = FALSE;
        if(!(('Requestor__c'.equalsIgnoreCase(selectedFieldUpdate) && crItemForUpdate.Requestor__c != null) || ('Work_Task__c'.equalsIgnoreCase(selectedFieldUpdate) && crItemForUpdate.Work_Task__c != null))) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Please select the field and the value and then click on Mass Update Selected or Mass Update All Components.'));
            return;
        } 

        if(listCRItemsForUpdate != null && !listCRItemsForUpdate.isEmpty()) {
            for(Deployment_Component__c crItem : listCRItemsForUpdate) {
                if('Requestor__c'.equalsIgnoreCase(selectedFieldUpdate) && crItemForUpdate.Requestor__c != null) {
                    crItem.Requestor__c = crItemForUpdate.Requestor__c;
                }  else  if('Work_Task__c'.equalsIgnoreCase(selectedFieldUpdate) && crItemForUpdate.Work_Task__c != null) {
                    crItem.Work_Task__c = crItemForUpdate.Work_Task__c;
                } 
            }

            update listCRItemsForUpdate;

            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Updated Successfully ' + listCRItemsForUpdate.size() + ' Records.'));
        }
    }   
    
     /**
     * @Description:   
     * @param:  
     */  
    public PageReference deleteSelected() {
        System.debug(LoggingLevel.INFO, 'deleteSelected listSelectedCRItems:' + listSelectedCRItems);
        List<Deployment_Component__c> listCRItemsDelete = new List<Deployment_Component__c>();

        for(WrapperComponentList cwItem : listSelectedCRItems) {
            if(cwItem.isSelected == TRUE) {
                if(cwItem.item.Id != null) {
                    listCRItemsDelete.add(cwItem.item);
                }
                setComponentUniqueId.remove(cwItem.item.CRI_Unique_ID__c);
            }
        }
        
        System.debug(LoggingLevel.INFO, 'deleteSelected listCRItemsDelete:' + listCRItemsDelete);

        if(listCRItemsDelete != null) {
            delete listCRItemsDelete;
            retrieveCRItemsList(crItemsDefaultQueryStr);
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Please select at least one component and then click on Add Selected.'));
        }

        return null; 
    }  
    
    /**
     * @Description:   
     * @param:  
     */ 

    public PageReference save() {
        System.debug(LoggingLevel.INFO, 'save listSelectedCRItems:' + listSelectedCRItems);
        try {

            List<Deployment_Component__c> listCRItemsUpdate = new List<Deployment_Component__c>();
            for(WrapperComponentList cwItem : listSelectedCRItems) {
                listCRItemsUpdate.add(cwItem.item);
            }
            
            if(listCRItemsUpdate != null && listCRItemsUpdate.size() > 0) {
                upsert listCRItemsUpdate;
            }

            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.Info, 'Record Saved Sucessfully'); //show confirmation message on save
            ApexPages.addMessage(myMsg);
        } catch(DmlException ex) {
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
        }

        return null;
    }   
    
     /**
     * @Description:   
     * @param:  
     */  
    public PageReference selectAll() {
        System.debug(LoggingLevel.INFO, 'selectAll listSelectedCRItems:' + listSelectedCRItems);

        for(WrapperComponentList cwItem : listSelectedCRItems) {
            cwItem.isSelected = TRUE;
        }
        return null; 
    }

//------------------------------------------------------------------------------------------------
    /**
     * @Description:   
     * @param:  
     */  
    public PageReference deSelectAll() {
        System.debug(LoggingLevel.INFO, 'deSelectAll listSelectedCRItems:' + listSelectedCRItems);

        for(WrapperComponentList cwItem : listSelectedCRItems) {
            cwItem.isSelected = FALSE;
        }
        return null; 
    }  
    
    /**
     * @Desc:   Gets current page start asset count
     * @Param:  
     * @Return: 
     */ 
         
    public Integer getPageStartIndex() {
        if (currentPageNbr == 1) {
            return 1;
        } 
        if (!listSelectedCRItems.isEmpty()) {
            return ((pageSize * (currentPageNbr - 1)) + 1);
        }
        return 0;
    }
    
    /**
     * @Desc:   Gets current page end asset count
     * @Param:  
     * @Return: 
     */     
 
    public Integer getPageEndIndex() {
        if (!listSelectedCRItems.isEmpty()) {
            return (getPageStartIndex() + (listSelectedCRItems.size() - 1));
        }
        return 0;
    }
     
    
    
    
    
    
        /**
     * @Description:   
     * @param:  
     */  
    public PageReference selectAllSearchSection() {
        System.debug(LoggingLevel.INFO, 'selectAllSearchSection listAvailableCRItems:' + listAvailableComponents);

        for(WrapperComponentList cwItem : listAvailableComponents) {
            cwItem.isSelected = TRUE;
        }
        return null; 
    }
    
    
    

//------------------------------------------------------------------------------------------------
    /**
     * @Description:   
     * @param:  
     */  
    public PageReference deSelectAllSearchSection() {
        System.debug(LoggingLevel.INFO, 'deSelectAllSearchSection listAvailableCRItems:' + listAvailableComponents);

        for(WrapperComponentList cwItem : listAvailableComponents) {
            cwItem.isSelected = FALSE;
        }
        return null; 
    }
    
    /**
     * @Desc:   Build Agreement wrapper list with the document for UI
     * @Param:  
     * @Return: 
     */     

    private void buildResultList() {
        // set current page number
        criSetSetController.setPageNumber(currentPageNbr);
        listSelectedCRItems = new List <WrapperComponentList>();
            
        // read records from the current page in the recordset
        for (Deployment_Component__c crItem : (List<Deployment_Component__c>) criSetSetController.getRecords()) {            
            WrapperComponentList newCWItems = new WrapperComponentList(crItem);
            listSelectedCRItems.add(newCWItems);               
        }
    }
    
    /**
     * @Desc:   Checks if there are more records before the current page in the resultset
     * @Param:  
     * @Return: <code>true</code> if there are more records, <code>false</code> otherwise
     */     
     
    public Boolean getHasPreviousPage() {
        return ((currentPageNbr != 1) && (currentPageNbr != 0));
    }
    /**
     * @Desc:   Checks if there are result to show
     * @Param:  
     * @Return: <code>true</code> if there are results, <code<false</code> otherwise
     */     

    public Boolean getHasResults() {
        return (!listSelectedCRItems.isEmpty());
    } 

//------------------------------------------------------------------------------------------------
    /**
     * @Desc:   Checks if there are more records after the current page in the resultset
     * @Param:  
     * @Return: <code>true</code> if there are more records, <code>false</code> otherwise
     */     

    public Boolean getHasNextPage() {
        System.debug(LoggingLevel.INFO, '\ntotalPages = ' + totalPages +'\ncurrentPageNbr = ' + currentPageNbr);
        return (totalPages > currentPageNbr);
    }
    
    
    /**
     * @Desc:   Gets the page number of the current page in the resultset
     * @Param:  
     * @Return: the page number
     */     

    public Integer getCurrentPageNumber() {
        return currentPageNbr;
    }
    
    /**
     * @Desc:   Sets the page number into the resultset
     * @Param:  
     * @Return: 
     */ 
         
    public void setCurrentPageNumber(Integer pageNumber) {
        if(pageNumber <= totalPages) {
            currentPageNbr = pageNumber;
            buildResultList();
        }
    }
     
     
    
    
    
    /**
     * @Description:   
     * @param:  
     */     
    private MetadataServiceVer2.MetadataWebSvc createService() { 
        MetadataServiceVer2.MetadataWebSvc service = new MetadataServiceVer2.MetadataWebSvc();
        service.SessionHeader = new MetadataServiceVer2.SessionHeader_element();
        service.SessionHeader.sessionId = manageSessionId();
        return service;     
    }

    private String manageSessionId() {
        
        // Fetch the session from object if it exist else call partner service to query the data.
        PartnerSoapSforceCom.Soap oPartnerService = new PartnerSoapSforceCom.Soap();
        PartnerSoapSforceCom.LoginResult oLoginResults = oPartnerService.login(username,password);  
        return oLoginResults.sessionId;
    }
    
    /**
     * @Description:   
     * @param:  
     */  
    public PageReference refreshParentComponentList() {
        try {
            getRefreshParentComponentList();
        } catch(Exception ex) {
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, SYSTEM_ERROR_MSG_PREFIX + ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    }
    
    /**
     * @Description:   
     * @param:  
     */  
    public PageReference refreshFilteredResult() {
        try {
            updateAvailableList(TRUE);
        } catch(Exception ex) {
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, SYSTEM_ERROR_MSG_PREFIX + ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    }
    private PartnerSoapSforceCom.Soap getPartnerConnection() {
        PartnerSoapSforceCom.Soap   oSoapObject =new PartnerSoapSforceCom.Soap ();

        PartnerSoapSforceCom.LoginResult oLoginResult = oSoapObject.login(username, password);
        PartnerSoapSforceCom.SessionHeader_element oSessionHeader =new PartnerSoapSforceCom.SessionHeader_element();
        oSessionHeader.sessionId = oLoginResult.sessionId;
        oSoapObject.SessionHeader = oSessionHeader;
        oSoapObject.endpoint_x = oLoginResult.serverUrl;
        return oSoapObject;
    }

    private void getRefreshParentComponentList() {
        System.debug(LoggingLevel.INFO, 'oDComponent:' + oDComponent);
        
        Map<String, String> mapParentComponent = new Map<String, String>();
        listParentItemsOptions = new List<SelectOption>();
        sMetaDataType = oDComponent.Component_Type__c;
        
        if(COMPONENT_WITH_PARENT_SOBJECT.containsIgnoreCase(sMetaDataType)) {
            bHasParent = TRUE;
            Boolean isParentMatch = FALSE;
            List<String> listSObject = new List<String>();
            PartnerSoapSforceCom.DescribeGlobalResult schemaSObjectType = getPartnerConnection().describeGlobal();
        
            // Search every object in the getGlobalDescribe() map to check key prefixes
            for( PartnerSoapSforceCom.DescribeGlobalSObjectResult t :  schemaSObjectType.sobjects) {
                String sObjectAPIName = t.name;
                
                if(!(sObjectAPIName.toLowerCase().endsWith('tag') || 
                    sObjectAPIName.toLowerCase().endsWith('history') || 
                    sObjectAPIName.toLowerCase().endsWith('feed') || 
                    sObjectAPIName.toLowerCase().endsWith('share'))
                ) {
                    String fullName = t.label + ' (' + sObjectAPIName + ')';
                    listSObject.add(fullName);
                    mapParentComponent.put(fullName, sObjectAPIName);
                    if(sObjectAPIName.equalsIgnoreCase(sParentName)) {
                        isParentMatch = TRUE;
                    }
                }
            }

            listSObject.sort();
            
            listParentItemsOptions.add(new SelectOption(SELECT_OPTION_VALUE, SELECT_OPTION_LABEL));
            for(String sObjectName : listSObject) {
                listParentItemsOptions.add(new SelectOption(mapParentComponent.get(sObjectName), sObjectName));
            }
           
            if(isParentMatch) {
                getRefreshComponentList();
            }
        } else if('EmailTemplate'.equalsIgnoreCase(sMetaDataType)) {
            bHasParent = TRUE;
            sParentName = null;
            listParentItemsOptions.add(new SelectOption(SELECT_OPTION_VALUE, SELECT_OPTION_LABEL));
            List<String> listString = getListMetaDataItems('EmailFolder', null);
            system.debug('listString::'+listString);
            for(String s : listString) {
                listParentItemsOptions.add(new SelectOption(s, s));
            }
        } else if('Report'.equalsIgnoreCase(sMetaDataType)) {
            bHasParent = TRUE;
            sParentName = null;
            listParentItemsOptions.add(new SelectOption(SELECT_OPTION_VALUE, SELECT_OPTION_LABEL));
            List<String> listString = getListMetaDataItems('ReportFolder', null);
            system.debug('listString::'+listString);
            for(String s : listString) {
                listParentItemsOptions.add(new SelectOption(s, s));
            }        
        } else {
            bHasParent = FALSE;
            sParentName = null;
            getRefreshComponentList();
        }
            
    }

    /**
     * @Description:   
     * @param:  
     */  
    public PageReference refreshComponentList() {
        try {
            getRefreshComponentList();
        } catch(Exception ex) {
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.Severity.ERROR, SYSTEM_ERROR_MSG_PREFIX + ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    } 
    
    /**
     * @Description:   
     * @param:  
     */  
    public void getRefreshComponentList() {
        componentSearchString = null;
        bShowSearchSection  = TRUE;
        listAvailableComponents = new List<WrapperComponentList> ();
        listMetadataItems = getListMetadataItem(sMetaDataType);
        updateAvailableList(false);
        
   }
   
       /**
     * @Description:   
     * @param:  
     */  
    public PageReference addSelected() {
     
        List<Deployment_Component__c> listCRItemsAdd = new List<Deployment_Component__c>();

        for(WrapperComponentList cwItem : listAvailableComponents) {
            if(cwItem.isSelected ==TRUE) {
                 listCRItemsAdd.add(cwItem.item);
                setComponentUniqueId.add(cwItem.item.CRI_Unique_ID__c);
            }
        }
        
        if(listCRItemsAdd != null && !listCRItemsAdd.isEmpty()) {
            insert listCRItemsAdd;
            retrieveCRItemsList(crItemsDefaultQueryStr);
            updateAvailableList(TRUE);
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Please select at least one component and then click on Add Selected.'));
        }
        
        return null; 
    }
    
   
   /**
     * @Description:   
     * @param:  
     */ 
    public List<String> getListMetadataItem(String metaDataType) {
        System.debug(LoggingLevel.INFO, 'inside getListMetadataItem:metaDataType::' + metaDataType);
        System.debug(LoggingLevel.INFO, 'inside getListMetadataItem:sMetaDataType::' + sMetaDataType);

        List<String> listFullNames = new List<String>();
        mapFieldFullName = new Map<String, WrapperFields>();
        
        if(sMetaDataType.equalsIgnoreCase('CustomField')) {
            PartnerSoapSforceCom.DescribeSObjectResult  theObjectType = getPartnerConnection().describeSObject(sParentName);

            if(Null != theObjectType) {
                
                for(PartnerSoapSforceCom.Field theFieldName : theObjectType.fields) {
                    String fullName = theFieldName.label + ' (' + theFieldName.name + ')';
                    listFullNames.add(fullName);

                    WrapperFields wrapperField = new WrapperFields();
                    wrapperField.fieldName = theFieldName.label;
                    wrapperField.fieldLabel = theFieldName.name;
                    mapFieldFullName.put(fullName, wrapperField);
                }
            } 
        } else {
                if(sParentName != null && 'EmailTemplate'.equalsIgnoreCase(sMetaDataType) || 'Report'.equalsIgnoreCase(sMetaDataType)) {
                    listFullNames = getListMetaDataItems(metaDataType, sParentName);
                } else {
                    listFullNames = getListMetaDataItems(metaDataType, null);
                }
            }
        listFullNames.sort();
        return listFullNames;  
    }
  
    /**
     * @Description:   
     * @param:  
     */ 
    public List<String> getListMetaDataItemsQuery(String metaDataTypeName) {
        List<String> listFullNames = new List<String>();
        MetadataServiceVer2.MetadataWebSvc service = createService();             
        String queryStr = 'SELECT Id, Name FROM ' +  metaDataTypeName; 
        queryStr += ' Where NamespacePrefix = null ';

        System.debug(LoggingLevel.INFO, 'queryStr:' + queryStr);

        List<SObject> listQueryResult = database.query(queryStr.trim()); 
        for(SObject record :listQueryResult) {
            listFullNames.add(String.valueOf(record.get('Name')));
        }
        // Sort
        listFullNames.sort();
        return listFullNames;
    }
    
   
    /**
     * @Description:  
     * 
     * @Param:
     * 
     * @Return:
     */     
    public void updateAvailableList(Boolean isFilter) {
        bOverLimit = FALSE;
        listAvailableComponents = new List<WrapperComponentList>();
          System.debug(LoggingLevel.INFO, 'listMetadataItems:' + listMetadataItems);
        if(listMetadataItems != null && listMetadataItems.size() > 0) {
            Integer index = 0;
            for(String mdItem : listMetadataItems) {

                if((isFilter == FALSE) ||
                    ('Contains'.equalsIgnoreCase(operatorString) && mdItem.containsIgnoreCase(componentSearchString)) ||
                    ('Equals'.equalsIgnoreCase(operatorString) && mdItem.equalsIgnoreCase(componentSearchString)) ||
                    ('StartsWith'.equalsIgnoreCase(operatorString) && mdItem.startsWithIgnoreCase(componentSearchString))
                ) {
                    WrapperComponentList newCWItem = wrapCRItem(mdItem);
                    newCWItem.displayName = mdItem;
                    if(newCWItem != null && !setComponentUniqueId.contains(newCWItem.item.CRI_Unique_ID__c)) {
                        index ++;
                        listAvailableComponents.add(newCWItem); 
                        if(index == listLimit + 1) {
                            bOverLimit = TRUE;
                            listAvailableComponents.remove(listLimit);
                            break;    
                        }
                    }
                }
            }
        } 
        
        bHasResults = listAvailableComponents != null && listAvailableComponents.size() > 0 ? TRUE : FALSE;

        System.debug(LoggingLevel.INFO, 'listAvailableComponents:' + listAvailableComponents);

    }
    
   

    
    
    private String calculateHashCriUniqueId(String crParentName, Deployment_Component__c crItem) {
        return hashString(crParentName + '-' + crItem.Component_Type__c + '-' + crItem.Full_Name__c);
    }
    
      /**
     * @Description:   
     * @param:  
     */  
    private String hashString(String stringToHash) {
        Blob input = Blob.valueOf(stringToHash);
        Blob bob = Crypto.generateDigest('MD5', input);
        return EncodingUtil.convertToHex(bob);
    }
    
    
     /**
     * @Description:   
     * @param:  
     */ 
    public List<String> getListMetaDataItems(String metaDataType, String metaDataFolder) {
        List<String> listFullNames = new List<String>();
        // List Metadata items for the selected Metadata Type      
        MetadataServiceVer2.MetadataWebSvc service = createService();             
        List<MetadataServiceVer2.ListMetadataQuery> queries = new List<MetadataServiceVer2.ListMetadataQuery>();        
        MetadataServiceVer2.ListMetadataQuery queryLayout = new MetadataServiceVer2.ListMetadataQuery();
        queryLayout.folder = metaDataFolder;
        queryLayout.type_x = metaDataType;
        queries.add(queryLayout);       
        MetadataServiceVer2.FileProperties[] fileProperties = service.listMetadata(queries, 31);
        system.debug('fileProperties::'+fileProperties);
        if(fileProperties != null) {
            for(MetadataServiceVer2.FileProperties fileProperty : fileProperties) {
                String fullName = fileProperty.fullName;
                listFullNames.add(fullName);
            }
        }
        system.debug('listFullNames::'+listFullNames);
        return listFullNames;
    }
    
    /**
     * @Description:   
     * @param:  
     */ 
    public WrapperComponentList wrapCRItem(String fullName) {
        
        if('CustomField'.equalsIgnoreCase(sMetaDataType)) {
            WrapperFields cwField = mapFieldFullName.get(fullName);
            if(cwField != null) {
                Deployment_Component__c crItem  = new Deployment_Component__c(Full_Name__c = sParentName + '.' + cwField.fieldName, Work_Task__c = changeRequestId, Label_Name__c = cwField.fieldName, API_Name__c = cwField.fieldLabel, Component_Type__c = sMetaDataType, Parent_Component__c = sParentName);
                crItem.Requestor__c = UserInfo.getUserId();
                crItem.CRI_Unique_ID__c = calculateHashCriUniqueId('Name', crItem);
                return (new WrapperComponentList(crItem));
            }
                                
        } else {
            String componentName = fullName;
            if(sParentName != null) {
                String seperator = sMetaDataType.equalsIgnoreCase('EmailTemplate') ? '/' : (sMetaDataType.equalsIgnoreCase('Layout') ? '-' : '.');
                componentName = componentName.replace(sParentName + seperator, '');
            }

            Deployment_Component__c crItem  = new Deployment_Component__c(Work_Task__c = changeRequestId, Label_Name__c = componentName, Full_Name__c = fullName, API_Name__c = componentName, Component_Type__c = sMetaDataType, Parent_Component__c = sParentName);
            crItem.Requestor__c = UserInfo.getUserId();
            crItem.CRI_Unique_ID__c = calculateHashCriUniqueId('Name', crItem);
            return (new WrapperComponentList(crItem));
        }
        return null;
    }
    
    
    // Wrapper Classes 
    
    /**
     * @Desc:   Wrapper class for holding CR_Items__c
     * @Param:
     */
    public class WrapperFields{
        public String fieldName;
        public String fieldLabel;
        public String value {get; set;}
    }
    
    
    /**
     * @Desc:   Wrapper class for compoment list.
     * @Param:
     */
    public class WrapperComponentList {
        public Deployment_Component__c item {get; private set;}
        public String uniqueKey {get; private set;}
        public String displayName {get; private set;}
        public Boolean isSelected {get; set;}
        public String uniqueKeyHash {get; private set;}
      
        public WrapperComponentList(Deployment_Component__c item) {
            this.item = item;
            this.isSelected = FALSE;
            this.uniqueKey = item.Component_Type__c + '-' + item.Full_Name__c;
        }
        /**
         * @Desc:   Class Constructor specifying initial values
         * @Param:  item the CR_Items__c sobject
         */
        public WrapperComponentList(Deployment_Component__c item, String crName) {
            this.item = item;
            this.isSelected = FALSE;
            this.uniqueKey = item.Component_Type__c + '-' + item.Full_Name__c;

            Blob input = Blob.valueOf(crName = item.Component_Type__c + '-' + item.Full_Name__c);
            Blob bob = Crypto.generateDigest('MD5', input);
            this.uniqueKeyHash =  EncodingUtil.convertToHex(bob);
        }
        
    }
    
    
}