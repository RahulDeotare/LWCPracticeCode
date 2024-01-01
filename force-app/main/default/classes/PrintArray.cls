public class PrintArray {
    
    public static String[] printNumbers(Integer n)
    {
        List<String> myArray = new List<String>();
        for(Integer i=0;i<n;i++)
        {
            myArray.add('Test '+i);
            System.debug(myArray[i]);
        }
        return myArray;
    }
}