public class largestElement {

    public static void getLargestElement(){
        //Initialize Array
        Integer[] myArray=new Integer[]{10,20,30,40,50};
            
         	//Initialize max with first element of array.
         	Integer max=myArray[0];
        
        //Loop Through the Array
        for(Integer i=0;i<myArray.size();i++){
            if(myArray[i]>max){
                max=myArray[i];
                
            }
        }
        system.debug('Largest Element is:'+max);
    }
}