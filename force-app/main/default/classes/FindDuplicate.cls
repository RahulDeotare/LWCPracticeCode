public class FindDuplicate {
    public static void countDuplicate(){
        List<Integer> numList = new List<Integer>{2, 2, 3, 4, 4, 5};
        Map<Integer, Integer> countDuplicateMAp = new Map<Integer, Integer>();
        for(Integer each : numList){
            countDuplicateMAp.put(each, countNumber(each, numList));
        }
        system.debug('countDuplicateMAp : '+ countDuplicateMAp);
    }
    public static Integer countNumber(Integer DigNum, List<Integer>numerList){
        Integer countNum = 0;
        system.debug('DigNum : '+ DigNum);
        
        for(Integer val : numerList){
            system.debug('value : '+ val);
            if(val == DigNum){
                ++countNum;
            }
        }
        return countNum;
    }
}