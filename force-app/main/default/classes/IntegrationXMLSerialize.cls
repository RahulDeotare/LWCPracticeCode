public class IntegrationXMLSerialize {
    // @AuraEnabled
    // public String xmlString{get; set;}

    @AuraEnabled
    public static void methodIntegrationXMLSerialize() {

        Dom.Document doc = new Dom.Document(); //Step1:Create XML Document
        Dom.XmlNode root = doc.createRootElement('Employee', null, null); //Step2:Create Root
        IntegrationXMLSerialize instance = new IntegrationXMLSerialize();
        string xmlString = doc.toXmlString(); //Step3:Convert Document to String of XML
    }
}