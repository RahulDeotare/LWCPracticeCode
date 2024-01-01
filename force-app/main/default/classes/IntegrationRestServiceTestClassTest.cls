@isTest
public with sharing class IntegrationRestServiceTestClassTest {
    
    @isTest
    public static void testMe(){

        IntegrationForTestClassMockCallout data= new IntegrationForTestClassMockCallout();
        Test.setMock(HttpCalloutMock.class, data);

        IntegrationRestForTestClass obj = new IntegrationRestForTestClass();
        obj.invoke();

        Account acc = [SELECT Id, Name FROM Account];
        System.assertEquals('Rahul', acc.Name);

    }
}