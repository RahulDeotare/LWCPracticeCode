public class RegistrationForm_CX {
    
    public Student__c objStudent{get; set;}
    public string selectedLang{get;set;}
    
    public RegistrationForm_CX(ApexPages.StandardController controller) {
        objStudent=(Student__c) controller.getRecord();
        selectedLang='en';
        
    }
        public void Save(){
            insert objStudent;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your admission application has been submitted successfully'));
        }
        public List<selectoption> getAvailableLanguages(){
    
        List<selectOption> options = new List<selectOption>();
        options.add(new selectOption('en','English'));
        options.add(new selectOption('es','Spanish'));
        options.add(new selectOption('fr','French'));
        return options;
        }
}