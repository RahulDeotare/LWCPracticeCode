public class Testing{

public String Country {get;set;}
  public String city {get;set;}

    public List<SelectOption> getCountries() {
    List<SelectOption> options = new List<SelectOption>();
    Map<String, Country_Name__c> countryMap= Country_Name__c.getAll();
    options.add(new SelectOption('','--None--'));
    for(String countryName: countryMap.keySet()){
          String cLabel =countryName;
          String value= countryMap.get(countryName).Name__c;
           
            options.add(new SelectOption(value,cLabel )); //1.Value, 2.Lable
        }

        
       
        
 
        return options;
    }

    
    //options.add(new SelectOption('None','--- None ---'));        
    //options.add(new SelectOption('RJ','Rajasthan'));
    //options.add(new SelectOption('MH','Maharastra'));
      //  return options;
    //}

public List<SelectOption> getCities(){
    List<SelectOption> options = new List<SelectOption>();
    if(Country == 'RJ')
    {       
        options.add(new SelectOption('AJM','AJMER'));
        options.add(new SelectOption('JAI','JAIPUR'));
        options.add(new SelectOption('JOD','JODHPUR'));
    }
    else if(Country == 'MH') {       
        options.add(new SelectOption('Mub','Mumbai'));
        options.add(new SelectOption('PUN','Pune'));
    }
    else {
        options.add(new SelectOption('None','--- None ---'));
    }      
    return options;
}       
}