public class Country {
    
    public String state {get;set;}
  public String city {get;set;}

public List<SelectOption> getStates() {
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('None','--- None ---'));        
    options.add(new SelectOption('RJ','Rajasthan'));
    options.add(new SelectOption('MH','Maharastra'));
    return options;
} 

public List<SelectOption> getCities(){
    List<SelectOption> options = new List<SelectOption>();
    if(state == 'RJ')
    {       
        options.add(new SelectOption('AJM','AJMER'));
        options.add(new SelectOption('JAI','JAIPUR'));
        options.add(new SelectOption('JOD','JODHPUR'));
    }
    else if(state == 'MH') {       
        options.add(new SelectOption('Mub','Mumbai'));
        options.add(new SelectOption('PUN','Pune'));
    }
    else {
        options.add(new SelectOption('None','--- None ---'));
    }      
    return options;
}
}