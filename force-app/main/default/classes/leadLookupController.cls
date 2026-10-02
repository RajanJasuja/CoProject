public class leadLookupController {
private String emailString;

public void setSearchString(String val) {
emailString = val;
}

public String getSearchString() {
return emailString ;
}

    public Lead getLead() {
    Lead lead = GetLeadInfo.GetLeadAddressByEmail(emailString);
    return lead;
    }

    public PageReference step2() {
    return Page.leadLookup2;
    }
}