public class descendingOrder {
	
    public static void getDescendingOrder(Integer[] myArray){
        
            Integer temp=0;
        for(Integer i=0;i<myArray.size();i++){
            for(Integer j=i+1;j<myArray.size();j++){
                if(myArray[i]<myArray[j]){
                    temp=myArray[i];
                    myArray[i]=myArray[j];
                    myArray[j]=temp;
                }
            }
        }
        for(Integer i=0;i<myArray.size();i++){
            System.debug('Elements of Array in Descending order:'+myArray[i]);
        }
    }
}