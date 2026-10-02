public class EinsteinVision_Admin {
    
    @AuraEnabled
    public static void createDatasetFromUrl(String zipUrl) {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        service.createDatasetFromUrlAsync(zipUrl);
    }
    
    @AuraEnabled
    public static List<EinsteinVision_Dataset> getDatasets() {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        EinsteinVision_Dataset[] datasets = service.getDatasets();
        return datasets;
    }
    
    @AuraEnabled
    public static String trainDataset(Decimal datasetId) {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        EinsteinVision_Model model = service.trainDataset(Long.valueOf(String.valueOf(datasetId)), 'Training', 0, 0, '');
        return model.modelId;
    }
    
    @AuraEnabled
    public static void deleteDataset(Long datasetId) {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        service.deleteDataset(datasetId);
    }
    
    @AuraEnabled
    public static List<EinsteinVision_Model> getModels(Long datasetId) {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        EinsteinVision_Model[] models = service.getModels(datasetId);
        return models;
    }
    
    @AuraEnabled
    public static void getCatPrediction(Id carId, String fileName, String base64) {
        Blob fileBlob = EncodingUtil.base64Decode(base64);
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        EinsteinVision_Dataset[] datasets = service.getDatasets();
        for (EinsteinVision_Dataset dataset : datasets) {
            if (dataset.Name.equals('Car')) {
                EinsteinVision_Model[] models = service.getModels(dataset);
                EinsteinVision_Model model = models.get(0);
                EinsteinVision_PredictionResult result = service.predictBlob(model.modelId, fileBlob, '');
                EinsteinVision_Probability probability = result.probabilities.get(0);
                
                Car__c car = [SELECT Id,Name,Account__r.Name FROM Car__C WHERE Id=:carId];
                car.Car_Damage__c = probability.label;
                update car;
                PriceBookEntry PBE=[select id,name,UnitPrice,Pricebook2Id,Product2Id from PriceBookEntry where name=:car.Car_Damage__c AND IsActive=true Limit 1];
                Item_To_Rpair__c itm = new Item_To_Rpair__c();
                itm.Name= car.Car_Damage__c;
                itm.Car__c=car.Id;
                itm.Item_Name__c=PBE.Product2Id;
                itm.Unit_Price__c=PBE.UnitPrice;
                insert itm;
               
                
                
                

                Attachment[] attsOld = [SELECT Id FROM Attachment WHERE ParentId=:carId];
                delete attsOld;
                Attachment att = new Attachment();
                att.Body = fileBlob;
                att.ParentId = car.Id;
                att.Name = fileName;
                insert att;
            }
        }
    }
    
    @AuraEnabled
    public static void cerateQuote(String itemId) {
        List<Item_To_Rpair__c>repairList = new List<Item_To_Rpair__c>();
        set<String>productName= new set<String>();
        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard'];
		repairList=[Select id,Name,Car__c,Item_Name__c,Car__r.Account__r.Name,Car__r.Name,Car__r.Account__c,Unit_Price__c from Item_To_Rpair__c where Car__c=:itemId Order By CreatedDate];
        for(Item_To_Rpair__c itm :repairList){
            productName.add(itm.name);
            System.debug('ProductName Set--->'+productName);
        }
        string oppname =repairList[0].Car__r.Account__r.Name+' '+repairList[0].Car__r.Name;
        //system.debug('asdad--->'+itm);
        //PriceBookEntry PBE=[select id,name,UnitPrice,Pricebook2Id,Product2Id from PriceBookEntry where name=:itm.Name AND IsActive=true Limit 1];
         Opportunity Opp = new Opportunity();
                Opp.Name= oppname;
                Opp.CloseDate=system.today()+30;
        		Opp.Pricebook2Id=pb.id;	
                Opp.StageName='Negotiation/Review';
                Opp.AccountId= repairList[0].Car__r.Account__c;
                Insert Opp;
        system.debug('Oppp--->'+Opp.id);
        
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
			List<PriceBookEntry> pbeList = [SELECT Id, PriceBook2Id, Product2Id, Product2.Id,UnitPrice,Product2.Name FROM 
                                            PriceBookEntry WHERE Name IN:productName AND PriceBook2Id=:pb.id AND
                                            PriceBook2.isActive=true ];
			
				for(PriceBookEntry pbe: pbeList) {
					if(opp.PriceBook2Id == pbe.PriceBook2Id) {
                        system.debug('INSIDE PRICEBOOK COMPARISON');
						OpportunityLineItem oli = new OpportunityLineItem(OpportunityId= opp.Id, PricebookEntryId = pbe.Id, Quantity = 1,UnitPrice=pbe.UnitPrice);
						oliList.add(oli);
						//break;
						
					}
				}
        insert oliList;
       
        Quote q = new Quote();
				q.name = 'Quote-' + OPP.name;
				q.opportunityId = Opp.id;
        		q.Pricebook2Id=pb.id;
				insert q;
        system.debug('Qoute--->'+q.id);
        
        List<QuoteLineItem> qliList = new List<QuoteLineItem>();
        for(PriceBookEntry pbe: pbeList) {
					if(q.PriceBook2Id == pbe.PriceBook2Id) {
                        system.debug('INSIDE PRICEBOOK COMPARISON');
						QuoteLineItem qli = new QuoteLineItem(QuoteId= q.Id, PricebookEntryId = pbe.Id, Quantity = 1,UnitPrice=pbe.UnitPrice);
						qliList.add(qli);
						//break;
						
					}
				}
        insert qliList;
        
        /*QuoteLineItem qli = new QuoteLineItem();
        	qli.QuoteId = q.Id;
            qli.PricebookEntryId = PBE.Id; 
            qli.Quantity = 1;
       qli.UnitPrice = PBE.UnitPrice;
        insert qli;*/
    }
    
    @AuraEnabled
    public static List<EinsteinVision_Label> getCatLabels() {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        EinsteinVision_Dataset[] datasets = service.getDatasets();
        for (EinsteinVision_Dataset dataset : datasets) {
            if (dataset.Name.equals('Car')) {
                return dataset.labelSummary.labels;
            }
        }
        return null;
    }

    @AuraEnabled
    public static String getImageUrlFromAttachment(Id carId) {
        List<Attachment> atts = [SELECT Id FROM Attachment WHERE ParentId=:carId];
        if (atts.size()>0) {
            return atts.get(0).Id;
        }
        return '';
    }
    
}