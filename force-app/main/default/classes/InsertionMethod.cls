public class InsertionMethod {
	static final Integer[] myArray=new Integer[]{3,60,35,2,45,320,5}; 
		public static void myInsertionSortMethod(){
			System.debug('My Original Array'+myArray);
			Integer temp = 0;  
				for(Integer j=1; j < myArray.size(); j++){ 
                    Integer key = myArray[j];
                     Integer i = j-1;
                    while((i>-1) && ( myArray[i] > key )) {
                        myArray[i+1] = myArray[i];  
                		i--;  
                    }
                    myArray[i+1] = key;
					System.debug('Array After Insertion Sort'+myArray);
									 
							 }  
							  
					 }  
}