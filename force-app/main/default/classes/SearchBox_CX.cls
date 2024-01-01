public class SearchBox_CX {
    
    private apexpages.standardController controller {get; set; }
            private Account objAcc;
            public List<Account> searchResults {get; set;}
            public string searchText{
            get
            {
            if (searchText==null) searchText ='';
            return searchText;
            }
            set;
            }
    
    public SearchBox_CX(ApexPages.StandardController controller) {
            this.controller = controller;
            this.objAcc = (Account) controller.getRecord();
}

public PageReference Search()
{
if(SearchResults == null)
{
SearchResults = new List<Account>();
}
else
{
SearchResults.Clear();
}

String qry = 'Select Id, Name from Account where name like \'%'+searchText+'%\') Order By Name';
SearchResults = Database.query(qry);
return null;
    }
}