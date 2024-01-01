public class showAccountTableEx_CX {

     public List<Account> accountList {get; set;}
     public Integer totalRecords {get; set;}
     public Account objAcc {get; set;}
     public string accId {get; set;}
     public list <Account> acc {get;set;}
     public String searchKey {get;set;}
     
     public String alphaSearchConct{get;set;}
     
     public list<Account> accList= [select id, Name,Type,Email__c,Site,Phone,Website from Account];
   
     
    public showAccountTableEx_CX(ApexPages.StandardController controller) {
        objAcc =  (Account) controller.getRecord();
        getAccounts();
    }
    public void getAccounts(){
        accountList = [select id, Name,Type,Email__c,Site,Phone,Website from Account];
        totalRecords=accountList.size();
      }
      public PageReference redirectToAccountDetailPage(){
          PageReference pf = new PageReference('/'+Apexpages.currentPage().getParameters().get('id'));
            pf.setRedirect(true);
            return pf;
      }
    
    public void search(){
        string searchquery='select Name,id from account where name like \'%'+searchKey+'%\' Limit 1';
        acc= Database.query(searchquery);
    }
    public void clear(){
        acc.clear();
    }
       
      public list<String> alphabet{
    get{                                                                                                                    //To display a list of alphabets on vf page 
        alphabet = new list<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Others','All'};
            return alphabet;         
            }
    set;
}
public Pagereference getalphaSearch(){                                                              //To update contact list as per the alphabet selected by the user

    if (alphaSearchConct=='All'){
        accList= [select id, Name,Type,Email__c,Site,Phone,Website from Account];
    }
    else{
            accList= [SELECT id, Name,Type,Email__c,Site,Phone,Website from Account WHERE Name Like:alphaSearchConct+'%'];
    }
    ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(accList);
    
    return null;
}   
       public void deleteAcc(){
           List<Account> attachToDelete=[Select Id from Account where id=:accId];
           delete attachToDelete;
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Selected Account has been Deleted Successfully...!!!'));
                  }
                  public void sizeOfRecords(){
                    string searchquery='select Name,id from account where name like \'%'+searchKey+'%\' Limit 10';
                    acc= Database.query(searchquery);
                    totalRecords=acc.size();
                  }
}