public class smallestNumber {
	
    public static void getSmallestNumber(){
        //Initialize Array
        Integer[] myArray=new Integer[]{10,20,30,40,50};
            
         	//Initialize max with first element of array.
         	Integer min=myArray[0];
        
        //Loop Through the Array
        for(Integer i=0;i<myArray.size();i++){
            if(myArray[i]<min){
                min=myArray[i];
    }
}
        system.debug('Largest Element is:'+min);
    }
}