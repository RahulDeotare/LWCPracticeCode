public class duplicateElement {
    public static void getDuplicateElement(){
        Integer[] myArray= new Integer[]{2,2,3,4,4,5};
            Integer count=0;
            for(Integer i=0;i<myArray.size();i++){
            System.debug('Elements of original array'+myArray[i]);
        }
        for(Integer i=0;i<myArray.size();i++){
            for(Integer j=i+1;j<myArray.size(); j++){
                if(myArray[i]==myArray[j]){
                    count++;
                    System.debug('Count of Number is:'+count);
                }
            }
        }
    }
}