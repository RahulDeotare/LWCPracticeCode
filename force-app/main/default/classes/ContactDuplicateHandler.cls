public class ContactDuplicateHandler {

    public static void beforeInsert(List<Contact> conList){
        if(!conList.isEmpty())
            ContactDuplicateHelper.preventDuplicate(conList);
    }
    public static void beforeUpdate(List<Contact> conList){
       if(!conList.isEmpty()) 
           ContactDuplicateHelper.preventDuplicate(conList);
    }
    public static void afterUndelete(List<Contact> conList){
        if(!conList.isEmpty())
            ContactDuplicateHelper.preventDuplicate(conList);
    }
}