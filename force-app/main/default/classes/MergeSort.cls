public class MergeSort {
    public static void doQuickSort(){
    List<Integer> myNumbList=new List<Integer>{3,60,35,2,45,320,5};
        for(Integer d:myNumbList){
            system.debug(d);
        }
    quickSort(myNumbList,0,myNumbList.size()-1);
    for(Integer d:myNumbList){
        system.debug(d);
    }
    }
    public static void quickSort(Integer[] a, Integer low, Integer high){
        Integer lo=low;
        Integer hi=high;
        if (lo >= hi) {
            return;
        }else 
            if( lo == hi - 1 ) {
            if (a[lo] > a[hi]) {
                Integer T = a[lo];
                a[lo] = a[hi];
                a[hi] = T;
            }
            return;
        }
        Integer pivot = a[(lo + hi) / 2];
        a[(lo + hi) / 2] = a[hi];
        a[hi] = pivot;

        while( lo < hi ) {
            while (a[lo] <= pivot && lo < hi){
                lo++;
            }

            while (pivot <= a[hi] && lo < hi ){
                hi--;
            }
            
            if( lo < hi ){
                Integer T = a[lo];
                a[lo] = a[hi];
                a[hi] = T;
            }
        }
        
        a[high] = a[hi];
        a[hi] = pivot;
        
        quicksort(a, low, lo-1);
        quicksort(a, hi+1, high);
    }
}