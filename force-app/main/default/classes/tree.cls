public class tree {

List<grouping__c> grouping;

public class Groups {
Grouping__c g;
List<Category__c> cats;
public Groups(Grouping__c gin) { g = gin;
cats = [Select c.Name, c.Grouping__r.GroupingID__c, c.Grouping__r.Name,
c.Grouping__c, c.Description__c, (Select Name, Directions__c,
Priority__c From Topics__r) From Category__c c 
where c.Grouping__c = :gin.id order by c.Name];
system.debug(cats);
}
public List<Category__c> getCategories() { return cats; }
public string getName() { return g.name; }
}

public List<Groups> getgrouping() {
if(grouping == null)
grouping = [select name,id from Grouping__c
where application__r.name like 'A%'];
List<Groups> ret = new List<Groups>{};
for ( Grouping__c g:grouping) {
ret.add( new Groups( g ) );
}
return ret;
}


}