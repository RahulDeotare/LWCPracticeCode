public class SearchAccountContactVFPage_CX {
	
    //public string SelectedAccountRecords{get;set;}
    //public string SelectedContactRecords{get;set;}
    public string SearchKey{get;set;}
    
    
    public List<Account> accountList{get;set;}
    public List<Contact> contactList{get;set;}
    public List<Account> deleteAccountList{get;set;}
    public List<Contact> deleteContactList{get;set;}
    public List<WrapperClass1> wrapList1{get;set;}
    public List<WrapperClass2> wrapList2{get;set;}
    
    public class WrapperClass1{
        public boolean check_Box{get;set;}
        public Account acc{get;set;}
        public WrapperClass1(Account acc,boolean check_Box){
            this.acc=acc;
            this.check_Box=check_Box;
        }
    }
    public class WrapperClass2{
        public boolean check_BoxCon{get;set;}
        public Contact con{get;set;}
        public WrapperClass2(Contact con,boolean check_BoxCon){
            this.con=con;
            this.check_BoxCon=check_BoxCon;
        }
    }
    
    public SearchAccountContactVFPage_CX(){
        wrapList1=new List<WrapperClass1>();
        wrapList2=new List<WrapperClass2>();
    }
    public void SearchRecords(){
        string searchQuery1='Select Id,Name from Account where Name Like \'%'+SearchKey+'%\' LIMIT 5';
            accountList=Database.query(searchQuery1);
        for(Account acc:accountList){
            wrapList1.add(new WrapperClass1(acc,false));
        }
        string searchQuery2='Select Id,Name from Contact where Name Like \'%'+SearchKey+'%\' LIMIT 5';
            contactList=Database.query(searchQuery2);
        for(Contact con:contactList){
            wrapList2.add(new WrapperClass2(con,false));
        }
    }
    public PageReference DeleteSelectedAccount(){
        deleteAccountList=new List<Account>();
        for(WrapperClass1 wc1:wrapList1){
            if(wc1.check_Box){
                deleteAccountList.add(wc1.acc);
            }
        }
        delete deleteAccountList;
        PageReference pr=new PageReference(system.currentPageReference().getURL());
        pr.setRedirect(true);
        return pr;
    }
    public PageReference DeleteSelectedContact(){
        deleteContactList=new List<Contact>();
        for(WrapperClass2 wc2:wrapList2){
            if(wc2.check_BoxCon){
                deleteContactList.add(wc2.con);
            }
        }
        delete deleteContactList;
        PageReference pr=new PageReference(system.currentPageReference().getURL());
        pr.setRedirect(true);
        return pr;
    }
}