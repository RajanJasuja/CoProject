public with sharing class BuildPackageXMLCtrl {
    Work_Package__c mysObject;
    List<Deployment_Component__c> listComponents;
    public String redirectUrl {get; private set;}
    public String sXML{get; private set;}
    public String sMessage{get; private set;}



    
    public BuildPackageXMLCtrl(ApexPages.StandardController controller) {
        mysObject = new Work_Package__c();
        listComponents = new List<Deployment_Component__c> ();
        
        if(!Test.isRunningTest()) {
            controller.addFields(new LIST<String>{'Name'});
            controller.reset();
        }
        this.mysObject = (Work_Package__c)controller.getRecord();

        if(String.isNotBlank(this.mysObject.Name)) {
            listComponents = [Select Id, Component_Type__c, Full_Name__c,Label_Name__c From Deployment_Component__c Where Sprint__c =: this.mysObject.Name ORDER BY Component_Type__c,Full_Name__c];
        }
        redirectUrl = controller.view().getUrl();

        system.debug('listComponents::'+listComponents);
        system.debug(' BuildPackageXMLCtrl controller ::::object data:::'+this.mysObject);
    }

    public void init() {
        createPackageXml(listComponents);
    }
    
    private void createPackageXml(List<Deployment_Component__c> listComponents) {

        Map<String, Set<String>> mapPackage = readChangeRequestItems(listComponents);
        sXML = createXmlString(mapPackage);
        system.debug('sXML ::'+sXML);
        Blob oBlob = Blob.valueOf(sXML); //Convert it to a blob
        system.debug('txtBlob ::'+oBlob);
        
        Attachment oAttachment = new Attachment(); //Make an attachment
        oAttachment.Name ='Package.xml';  
        oAttachment.Body = oBlob;
        oAttachment.ContentType = 'application/xml'; //Signal what the file's MIME type is
        oAttachment.ParentID = this.mysObject.Id;
        try {
            insert oAttachment;
            sMessage = 'Package.xml Attached Sucessfully';
            //Apexpages.addMessage(new ApexPages.Message(Apexpages.severity.INFO,'));
            } catch(Exception ex) {
            sMessage = 'Package.xml Attached Failed: '+ ex.getMessage();
            //Apexpages.addMessage(new ApexPages.Message(Apexpages.severity.error,sMessage));
            system.debug(ex.getMessage() + ex.getStackTraceString());
        }
    }
    
   /**
    * @Desc:    
    * @Param:   
    * @Return:  
    */  

    private static Map<String, Set<String>> readChangeRequestItems(List<Deployment_Component__c> listComponents) {

        Map<String, Set<String>> mapPackage = new Map<String, Set<String>>();

        for(Deployment_Component__c crItem : listComponents) {  
           
            String memberType = crItem.Component_Type__c;
            String fullName = crItem.Full_Name__c;

            if(null != memberType && null != fullName) {

                Set<String> listMembers = new Set<String>();
                if(mapPackage.containsKey(memberType)) {
                    listMembers = mapPackage.get(memberType);
                }
                listMembers.add(fullName);
                mapPackage.put(memberType, listMembers);
            }
        }
        System.debug(LoggingLevel.INFO, 'mapPackage: ' + mapPackage);
        return mapPackage;
    }
    
    /**
    * @Desc:    
    * @Param:   
    * @Return:  
    */  

    private String createXmlString(Map<String, Set<String>> mapPackage) {
       Xmlstreamwriter xmlW = new Xmlstreamwriter();
        // XML Begin
       xmlW.writeStartDocument(null,'1.0');
       xmlW.writeStartElement(null,'Package', null);
       xmlW.writeAttribute(null,null,'xmlns','http://soap.sforce.com/2006/04/metadata');

        List<String> listComponent = new List<String>(mapPackage.keySet());
        // sort the list
        listComponent.sort();
        System.debug(LoggingLevel.INFO, 'listComponent: ' + listComponent);
        for(String mapKey : listComponent) {
            // types elements
            xmlW.writeStartElement(null,'types',null);

            List<String> listMember = new List<String>(mapPackage.get(mapKey));
            listMember.sort();
            
            for(String memberStr : listMember) {
                // members elements
                xmlW.writeStartElement(null,'members',null);
                xmlW.writeCharacters(memberStr);
                xmlW.writeEndElement();
            }

            // typesElement elements
            xmlW.writeStartElement(null,'name',null);
            xmlW.writeCharacters(mapKey);
            xmlW.writeEndElement();

            xmlW.writeEndElement();
        }   
        
        //xmlW.writeEndElement();
        xmlW.writeEndDocument(); //Close XML document
        String xmlStringxmlRes = xmlW.getXmlString();
        xmlW.close();
        System.debug(LoggingLevel.INFO, 'xmlStringxmlRes: ' + xmlStringxmlRes);
        return xmlStringxmlRes;
    }
}