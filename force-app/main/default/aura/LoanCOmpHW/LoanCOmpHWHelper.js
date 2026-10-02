({
	helperMethod : function() {
		
	},
    
    calculatePayment : function(component) {
        var principal = component.get("v.mortgagePrincipal");
        var annualRate = component.get("v.mortgageRate");
        var years = component.get("v.mortgageYears");

        if (!principal || !annualRate || !years) {
            component.set("v.monthlyPayment", 0.0);
            return;
        }

        var monthlyRate = annualRate / 12 / 100;
        var totalPayments = years * 12;

        var payment = 0.0;

        if (monthlyRate === 0) {
            payment = principal / totalPayments;
        } else {
            payment = principal * (monthlyRate * Math.pow(1 + monthlyRate, totalPayments)) /
                      (Math.pow(1 + monthlyRate, totalPayments) - 1);
        }

        component.set("v.monthlyPayment", payment.toFixed(2));
    }

    
})