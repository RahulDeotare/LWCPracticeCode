global class ScheduleBatchLead implements Schedulable {

    global void execute(SchedulableContext BC){
        Database.executeBatch(new BatchLead());
    }
}