public class AccountRatingTriggerHandler {

    public static void updateRating(List<Account> accList){
        for(Account acc:accList){
            if(acc.Industry=='Energy' || acc.Industry=='Agriculture'){
                acc.Rating='Hot';
            }
        }
    }
}