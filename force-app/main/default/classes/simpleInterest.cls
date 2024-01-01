public class simpleInterest {

    public static void calculateSimpleInterest(){
        Decimal p,r,t, SI;
        p=1000;r=12;t=2;
        SI=(p*r*t)/100;
        System.debug('Simple Interest is:'+SI);
    }
}