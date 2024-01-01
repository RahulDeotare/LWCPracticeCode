public class  Mycontroller{
 public string recid{get;set;}
    public List<Account> listofaccountattachments { get; set; }

public Mycontroller()
{
 
     
listofaccountattachments =[SELECT Id,Name,(select id,Name from Account.attachments) From Account Limit 5];
}
 public PageReference doRemove() {
    account ac=[select id,name from account where id=:recid];
       delete ac;
      return null;
   } 
}