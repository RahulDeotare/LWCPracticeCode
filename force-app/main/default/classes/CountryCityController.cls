public class CountryCityController {

    public String City { get; set; }                        //https://developer.salesforce.com/forums/?id=9060G000000BbaDQAS
    public String Country { get; set; }
 
 public List<SelectOption> getCountries()       
    {       
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- None --'));                        //Initially it should show blank so its value is blank ' ' & label is --NONE--  
        
         List<Country_Name__c> countryNames = Country_Name__c.getAll().values();          //to save SOQL queries
        
       // List<Country__c> countryNames = [SELECT Name FROM  Country__c];       //fetching all the countries from custom settings
        
        for (Country_Name__c n : countryNames)                       //adding the country names to the empty list...but why add twice ?
        {                                                       //Constructor not defined: [System.SelectOption].<Constructor>(String)
            options.add(new SelectOption(n.Name, n.Name));      //STANDARD CONSTRUCTOR = SelectOption(value, label) 
        }                                                       //therefore 1st is value and 2nd is its label
        
        return options;
    }
    
    public List<SelectOption> getCities()           // To generate the city picklist based on the country selected by user.
    {
        List<SelectOption> options = new List<SelectOption>();          //empty list is created
        
        options.add(new SelectOption('', '-- None --'));                //initial value is blank bcoz no country is selected
        
        //City__c CityNames2 =   City__c.getInstance('country');        //since we want only those cities whose country is selected we can't use get all
        
        List<City__c> CityNames = [SELECT Name FROM City__c where Country__c =: country ];      //for having particular cities on selection of country SOQL is used
       
        for(City__c city : CityNames)
        {
            options.add(new SelectOption(city.Name,  city.Name));           //1st is value and 2nd is its label
        }
        
        return options;
    }

}