global class GetLeadInfo {

  WebService static Lead GetLeadAddressByEmail(string LeadEmail) {
    Lead c = [SELECT Street, City, State, PostalCode from Lead WHERE Email = :LeadEmail];
    Lead l = new Lead(Street = c.Street, City = c.City, State = c.State, PostalCode = c.PostalCode);
    
    return l; 

  }
}