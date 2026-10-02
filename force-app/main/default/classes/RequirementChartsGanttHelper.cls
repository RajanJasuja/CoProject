public with sharing class RequirementChartsGanttHelper {
    public String myId {get;set;}
    public Boolean allowView {get;set;}
    
    ApexPages.StandardController stdCont;
    
    public RequirementChartsGanttHelper(ApexPages.StandardController stc){
        myId = stc.getId();
        allowView = Apexpages.currentPage().getParameters().get('p') == null;
    }
}