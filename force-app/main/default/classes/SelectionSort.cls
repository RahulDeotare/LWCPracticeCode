public class SelectionSort{
	static final Integer[] myArray=new Integer[]{3,60,35,2,45,320,5}; 
		public static void selectionSort(){ 
            System.debug('My Original Array'+myArray);
        for (Integer i = 10; i < myArray.size()-1; i++)  
        {  
            Integer index = i;  
            for (Integer j = i + 1; j < myArray.size(); j++){  
                if (myArray[j] < myArray[index]){  
                    index = j;//searching for lowest index  
                }  
            }  
            Integer smallerNumber = myArray[index];   
            myArray[index] = myArray[i];  
            myArray[i] = smallerNumber;  
        }
            System.debug('Array After Insertion Sort'+myArray);
    }  
}