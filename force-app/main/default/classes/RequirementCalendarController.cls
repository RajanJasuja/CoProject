public class RequirementCalendarController {
        //Color Definition
        static String requirementColor = 'red';
        static String bizProcessColor = 'green';
        static String technicalColor = 'purple';
        static String configurationColor = 'indigo';
        static String developmentColor = 'blue';
        static String other = 'orange';
        
        Requirement__c requirement;
        String eventLsitString;
      
        //Work Task
        List<Work_Task__c> workTaskList;
        //Event Class
        public class WorkTaskEvent{
                //Uniquely identifies the given event. Different instances of repeating events should all have the same id.
                String Id;
                //The text on an event's element
                String Title;
                //Whether an event occurs at a specific time-of-day. This property affects whether an event's time is shown. 
                //Also, in the agenda views, determines if it is displayed in the "all-day" section.
                Boolean allDay;
                //The date/time an event begins.
                String start;
                //The date/time an event ends.
                String enddate;
                //A URL that will be visited when this event is clicked by the user. 
                //For more information on controlling this behavior, 
                String url;
                //A CSS class (or array of classes) that will be attached to this event's element.
                String className;
                //Overrides the master editable option for this single event.
                Boolean editable;
                //Sets an event's background and border color just like the calendar-wide eventColor option.
                String color;
                //Sets an event's background color just like the calendar-wide eventBackgroundColor option.
                String backgroundColor;
                //Sets an event's background color just like the calendar-wide eventBackgroundColor option.
                String borderColor;
                //Sets an event's text color just like the calendar-wide eventTextColor option.
                String textColor;
                //String requirementType for 6 type
                String requirementType;
                //Estimate hours
                String estimateHours;
                //Requirement reference
                String requirementId;
                
                public workTaskEvent(){
                }
                
                public String getId(){
                        return Id;
                }
                public void setId(String Id){
                        this.Id = Id;
                }
                
                public String getTitle(){
                        return Title;
                }
                public void setTitle(String Title){
                        this.Title = Title;
                }
                
                public Boolean getallDay(){
                        return allDay;
                }
                public void setallDay(Boolean allDay){
                        this.allDay = allDay;
                }
                
                public String getstart(){
                        return start;
                }
                public void setstart(String start){
                        this.start = start;
                }
                 
                public String getenddate(){
                        return enddate;
                }
                public void setenddate(String enddate){
                        this.enddate = enddate;
                }
                
                public String geturl(){
                        return url;
                }
                public void seturl(String url){
                        this.url = url;
                }
                
                public String getclassName(){
                        return className;
                }
                public void setclassName(String className){
                        this.className = className;
                }
                
                public Boolean geteditable(){
                        return editable;
                }
                public void seteditable(Boolean editable){
                        this.editable = editable;
                }
                
                public String getcolor(){
                        return color;
                }
                public void setcolor(String color){
                        this.color = color;
                }
                
                public String getbackgroundColor(){
                        return backgroundColor;
                }
                public void setbackgroundColor(String backgroundColor){
                        this.backgroundColor = backgroundColor;
                }
                
                public String getborderColor(){
                        return borderColor;
                }
                public void setborderColor(String borderColor){
                        this.borderColor = borderColor;
                }
                
                public String gettextColor(){
                        return textColor;
                }
                public void settextColor(String textColor){
                        this.textColor = textColor;
                }
                
                public String getrequirementType(){
                        return requirementType;
                }
                public void setrequirementType(String requirementType){
                        this.requirementType = requirementType;
                }
                
                public String getestimateHours(){
                        return estimateHours;
                }
                public void setestimateHours(String estimateHours){
                        this.estimateHours = estimateHours;
                }
                
                public String getrequirementId(){
                        return requirementId;
                }
                public void setrequirementId(String requirementId){
                        this.requirementId = requirementId;
                }
        }
        //Event List
        List<WorkTaskEvent> workTaskEventList;
       
        public String geteventLsitString(){
               return eventLsitString;
        }
        public void seteventLsitString(String eventLsitString){
               this.eventLsitString = eventLsitString;
        }
        
        
        public List<WorkTaskEvent> getworkTaskEventList(){
                return this.workTaskEventList;
        }
        
        //Connstructor
        public RequirementCalendarController(){
                workTaskList = new List<Work_Task__c>();
                workTaskEventList = new List<WorkTaskEvent>();
                eventLsitString = '';
        }
        public RequirementCalendarController(ApexPages.StandardController controller){
                this.requirement=(Requirement__c)controller.getRecord();
                
                workTaskList = new List<Work_Task__c>();
                workTaskEventList = new List<WorkTaskEvent>();
                
                eventLsitString = '';
                convertWorkTaskToEvent(getAllWorkTasks(this.requirement.Id));
        }
        
        //Method
        /**----------Get-----------------------------*/
        public List<Work_Task__c> getAllWorkTasks(String requirementJS){
                
                workTaskList = [Select w.Work_Start_Time__c, w.Work_End_Time__c, w.Type__c, w.Task_Summary__c, w.Status__c, w.Start_Date__c, 
                                                w.Requirement__c, w.Priority__c, w.Name, w.Id, w.Estimate_Hours__c, w.End_Date__c, w.Completed__c, w.Block__c, 
                                                w.Balance_Hours__c, w.Assigned_To__c, w.Actual_Hours__c 
                                                From Work_Task__c w
                                                Where w.Requirement__c = :requirementJS];
                                                
                return workTaskList;
        }
        
        public void convertWorkTaskToEvent(List<Work_Task__c> workTaskList){
                User currentUser = [Select TimeZoneSidKey from User where id =: USerInfo.getUserId()];
                String timeZone = currentUser.TimeZoneSidKey;
            
                for(Work_Task__c tempWorkTask : workTaskList){
                        WorkTaskEvent tempEvent = new WorkTaskEvent();
                        tempEvent.setId(tempWorkTask.Id);
                        tempEvent.setTitle(tempWorkTask.Task_Summary__c);
                        tempEvent.setallDay(false);
                        String startDate = tempWorkTask.Start_Date__c.format('yyyy-MM-dd hh:mm:ss a', timeZone);
                        String endDate = tempWorkTask.End_Date__c.format('yyyy-MM-dd hh:mm:ss a', timeZone);
                        //System.debug('***-------------******startDate   ' + startDate);
                        //System.debug('***-------------******SDate   ' + tempWorkTask.Start_Date__c);
                        //System.debug('***-------------******endDat   ' + endDate);
                        //System.debug('***-------------******EDate   ' + tempWorkTask.End_Date__c);
                        tempEvent.setstart(startDate);
                        tempEvent.setenddate(endDate);
                        tempEvent.seturl('/'+tempWorkTask.Id);
                        tempEvent.seteditable(true);
                        tempEvent.setcolor(convertTypetoColor(tempWorkTask.Type__c));
                        tempEvent.setrequirementType(tempWorkTask.Type__c);
                        tempEvent.setestimateHours(String.valueOf(tempWorkTask.Estimate_Hours__c));
                        tempEvent.setrequirementId(tempWorkTask.Requirement__c);
                        workTaskEventList.add(tempEvent);
                }
                 
                convertEventToOutput();
                
                //Clear the workTaskList and eventList to prevent duplicate search
                workTaskList.clear();
                workTaskEventList.clear();
                
        }
        
        private void convertEventToOutput(){
                eventLsitString = '';
                eventLsitString = eventLsitString + '[';
                
                for(WorkTaskEvent event : workTaskEventList){
                        eventLsitString = eventLsitString + '{"id":"'    + event.getId()   + '",';
                        eventLsitString = eventLsitString + '"title":"'  + event.getTitle() + '",';
                        eventLsitString = eventLsitString + '"allDay":"false",';
                        eventLsitString = eventLsitString + '"start":"'  + event.getstart() + '",';
                        eventLsitString = eventLsitString + '"end":"'    + event.getenddate() + '",';
                        eventLsitString = eventLsitString + '"color":"'  + event.getcolor() + '"},';
                }
                
                eventLsitString = eventLsitString.substring(0, eventLsitString.length()-1); 
                
                eventLsitString = eventLsitString + ']';
        }
        
        public String convertTypetoColor(String requirementType){
                String color = '';
                
                if(requirementType == 'Requirement Analysis'){
                        color = requirementColor;
                }
                
                if(requirementType == 'Biz Process Design'){
                        color = bizProcessColor;
                }
                
                if(requirementType == 'Technical Design'){
                        color = technicalColor;
                }
                
                if(requirementType == 'Configuration'){
                        color = configurationColor;
                }
                
                if(requirementType == 'Development'){
                        color = developmentColor;
                }
                
                if(requirementType == 'Other'){
                        color = other;
                }       
                return color;
        }
        
        //For JavaScript to Call
        public PageReference getEventListFromRequirementJS(){
                //System.debug('***-------------******requirementJS' + requirementJS);
                eventLsitString = '';
                //convertWorkTaskToEvent(getAllWorkTasks(requirementJS));
                return null; 
        }
}