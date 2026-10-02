public class testController_Rajan {
        
    public String SelectProjectOffices {get;set;}
    public String selectBuilding{get;set;}
    public boolean EnabledBuilding{get;set;}
    public String output{get;set;}
    List<SelectOption> optionBuliding= new List<SelectOption>();
    
    public testController_Rajan  (){
    //setSelectProjectOffices('Select One');
    
    	optionBuliding.add(new SelectOption('Select One','Select One'));//set default value
    	selectBuilding='Select One';
    	EnabledBuilding=true;
    
      }
    public PageReference test(){ return null;}
  
  /*Getting values of Status picklist  of Case Object*/
            public List<SelectOption> getTestProjectOffices()
            {
                 
               List<SelectOption> options = new List<SelectOption>();
               
               options.add(new SelectOption('Select One','Select One'));//set default value
               for(ProjectOfficeCusList__c poff : ProjectOfficeCusList__c.getAll().values())  
               options.add(new SelectOption(poff.name,poff.name));
               return options;
           }
           
           
           public void BuildingListVisibilty()
           {
           output = SelectProjectOffices;
               //getSelectProjectOffices(); 
               System.Debug('Rajan Testing***********' + SelectProjectOffices); 
                optionBuliding.add(new SelectOption('Kick','Kick'));

               /*
               if(SelectProjectOffices!=NULL)
                {
                  for(Product2 p :[select Building__c from Product2 p where p.Project_Office__c=:SelectProjectOffices])
                  optionBuliding.add(new SelectOption(p.Building__c, p.Building__c));
                }
                */
                EnabledBuilding=false;
           }
           
           
           
           public List<SelectOption> getBuilding()
           {
               return optionBuliding;
           }
           /*
            public String getSelectProjectOffices() {
            return SelectProjectOffices;
            }
         
            public void setSelectProjectOffices(String SelectProjectOffices) {
                this.SelectProjectOffices= SelectProjectOffices;
            }*/
           
   
 }