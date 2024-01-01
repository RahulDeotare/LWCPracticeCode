public class linearSearch {
	
    static final Integer[] myArray=new Integer[]{55, 29, 10, 40, 57, 41, 20, 24, 45};
    public static void doLinearSearch(){
        Integer x=40;  
        for(Integer i=0;i<myArray.size();i++){
            if(myArray[i] == x){
                system.debug(i);
            }
        }
    }
}