public class BubbleSort{
	static final Integer[] myArray=new Integer[]{3,60,35,2,45,320,5}; 
		public static void myBubbleSortMethod(){
			System.debug('My Original Array'+myArray);
			Integer temp = 0;  
				for(Integer i=0; i < myArray.size(); i++){  
					 for(Integer j=1; j < (myArray.size()-i); j++){  
							  if(myArray[j-1] > myArray[j]){  
									 //swap elements  
									 temp = myArray[j-1];  
									 myArray[j-1] = myArray[j];  
									 myArray[j] = temp;  
									 System.debug('Array After Bubble Sort'+myArray);
									 
							 }  
							  
					 }  
			}
			
		}
		}