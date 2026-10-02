public with sharing class RequirementsGanttChartController {
	 public String mytarget {get; 
    	set{
    		this.mytarget = value;
    		init();
    	}
    	}
    public String objectType {get;set;}
    public String startDateFieldName {get;set;}
    public String endDateFieldName {get;set;}
    public String idFieldName {get;set;}
    public String fullViewURL {get;set;}
 	public String projectGanttJson{get;set;}
 
    private String nameFieldName;
    private String completedFieldName;
    private String filterFieldName;
    
    
    private List<Sobject> sobjectList;
    private static final String REGEXP_QUOTES    = '(?<!\\\\)"';
    
    public static final String COLOR_COMPLETE = '#333333';//Grey
    public static final String COLOR_LATE = '#ee3322';//RED
    public static final String COLOR_FUTURE = '#3980F4';//Deep Bule
    public static final String COLOR_CURRENT = '#EEAA66';//orange
    
    public RequirementsGanttChartController()
    {
    	init();
    }
    
    private void init()
    {
    	if (myTarget != null)
    	{
         initFieldNames();
       	 retrieveData();
        projectGanttJson = toJSon();
        
    	}
    }
    
    public String getProjectGanttJson() {
        
        init();
        return projectGanttJson;
    }
    
    /*
    * 	Initialize the variables depending on the object type possible values: 
    * 	Requirement__c and Milestone1_Task__c
    */
    private void initFieldNames(){
    	if(mytarget != null){
    		if(mytarget.startsWith(Schema.SObjectType.Work_Package__c.getKeyPrefix())){
	    		/*startDateFieldName = 'Kickoff__c';
	    		endDateFieldName = 'Deadline__c';
	    		nameFieldName = 'NameClean__c';
	    		filterFieldName = 'Project__c';*/
	    		
	    		startDateFieldName = Requirement__c.Start_Date__c.getDescribe().getName();
				endDateFieldName = Requirement__c.End_Date__c.getDescribe().getName();
	    		nameFieldName = Requirement__c.NameClean__c.getDescribe().getName();
	    		filterFieldName = Requirement__c.Work_Package__c.getDescribe().getName();
	    			    		
	    		//objectType = 'Requirement__c';
	    		objectType = Schema.SObjectType.Requirement__c.getName();
	    	}else if(mytarget.startsWith(Schema.SObjectType.Requirement__c.getKeyPrefix())){

	    		/*startDateFieldName = Milestone1_Task__c.Start_Date__c.getDescribe().getName();
				endDateFieldName = Milestone1_Task__c.Due_Date__c.getDescribe().getName();
	    		nameFieldName = Milestone1_Task__c.Name.getDescribe().getName();
	    		filterFieldName = Milestone1_Task__c.Project_Milestone__c.getDescribe().getName();
	    			    		
	    		objectType = Schema.SObjectType.Milestone1_Task__c.getName();*/
	    	} else {
	    		throw new Milestone1_Exception('[initFieldNames] Unable to generate JSON for ' + mytarget);
	    	}
	    	idFieldName = 'Id';
	    	completedFieldName = 'Complete__c';	
    	}
    }
    
    /*
    * 	Retrieve the data doing a dynamic query by object type.
    */
    private void retrieveData(){
    	
    	String query = 'Select '+idFieldName+','+startDateFieldName+','+endDateFieldName+','+nameFieldName+','+completedFieldName+
    				   ' from '+objectType+ ' where '+filterFieldName+'=\''+mytarget+'\' order by Name';
    	sobjectList = Database.query(query);
    }
    
    /**
    *	Generate the output in json format to be rendered in the jquery gantt.
    */
    private String toJSon(){
    	
    	String ret = 'var ganttData' +mytarget + ' = [{id: 1, name: "", series: [';
    	Boolean addComma=false,completed;
    	Date startDate,endDate;
    	String name,id;
        for (Sobject current : sobjectList){ 
            
            if(current.get(startDateFieldName) == null){
            	startDate = Date.today();
            }else{
            	startDate = Date.valueOf(current.get(startDateFieldName));
            }
            if(current.get(endDateFieldName) == null){
            	endDate = startDate;
            }else{
            	endDate = Date.valueOf(current.get(endDateFieldName));
            }
            completed = Boolean.valueOf(current.get(completedFieldName));
            name = escapeDoubleQuotes(String.valueOf(current.get(nameFieldName)));
            id = String.valueOf(current.get(idFieldName));
            if (addComma) { ret += ','; }
            
            String color=COLOR_CURRENT;
            
            if (completed) {
                color=COLOR_COMPLETE;
            } else if (endDate < Date.today()) {
                color=COLOR_LATE;
            } else if (startDate > Date.today()) {
                color=COLOR_FUTURE;
            }
            
            ret += 	'{'+
            		'id:"'+id+'",'+ 
            		'name: "'+name+'",'+
            		'start: new Date(' +startDate.year() +',' + (startDate.month()-1) +',' + startDate.day() +'),'+
             		'end: new Date(' +endDate.year() +',' + (endDate.month()-1) + ',' + endDate.day() +'), ' +
                	'color: "' + color + '"'+
                	'}';
                	
            addComma=true;
            
        }
        
        ret+=']}];';
        return ret;   	
    }
    
    private String escapeDoubleQuotes(String word){
    	return word.replaceAll(REGEXP_QUOTES,'\\\\"');
    }
    
    class Milestone1_Exception extends Exception {}
}