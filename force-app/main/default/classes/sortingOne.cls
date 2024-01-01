public class sortingOne{
	static final Integer[] A=new Integer[]{3,60,35,2,45,320,5};
    static final Integer[] B=new Integer[]{};    
    	 Integer n1 = 1;
        Integer[] L = new Integer[]{n1};
    public Static void myMethod(Integer low, Integer high,Integer[] arr){
        
       
        Integer	mid = (low + high) /2;
        Integer    i = low;
         Integer   j = mid + 1;
         Integer   k = low;

    while (i <= mid && j <= high)
    {
        if (A[i] < A[j])
        {
            B[k] = A[i];
            i++;
            k++;
        }
        else
        {
            B[k] = A[j];
            j++;
            k++;
        }
    }
    while (i <= mid)
    {
        B[k] = A[i];
        k++;
        i++;
    }
    while (j <= high)
    {
        B[k] = A[j];
        k++;
        j++;
    }
        A[i] = B[i];
   
        }  
}