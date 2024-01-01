public class BinaryTree{
    static final List<Integer> IntegerList = new List<integer>{9,4,10,12};
        public static void myTree(){
        Integer T = 10;
        Integer L = 0;
        Integer R = IntegerList.size() - 1;
        Integer m =0;
        Integer mid;
        while(L <= R){
            system.debug(m);    
            mid=(L+R)/2;
            if(IntegerList[mid] == T){
                   system.debug(IntegerList[mid]);
                break;
            }     
            else if(T < IntegerList[mid]){
                R = mid - 1;
            }    
            else{
                L = mid + 1;
            }
               
           m = m + 1;
        }
            }
            }