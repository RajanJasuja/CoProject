public class TestPDQ {
    
    public static Boolean isFreezing(String celsiusTemp){
if(String.isNotBlank(celsiusTemp) && celsiusTemp.isNumeric()) return Decimal.valueof(celsiusTemp) <= 0;
return null;
}
}