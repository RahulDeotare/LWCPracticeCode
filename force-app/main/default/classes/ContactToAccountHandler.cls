public class ContactToAccountHandler {
	
    public static void beforeInsert(List<Contact> conList){
        if(!conList.isEmpty())
            ContactToAccountHelper.assigningContactToAccountMethod(conList);
    }
}