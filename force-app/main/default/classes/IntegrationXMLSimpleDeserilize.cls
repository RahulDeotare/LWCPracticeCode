public class IntegrationXMLSimpleDeserilize {
    public string xmlString{get; set;}
    public string parsedData{get; set;}

    public void convertMe(){
        Dom.Document doc = new Dom.Document();  //Step1:Create XML Document
        doc.load(xmlString);                    //Step2:Load XML Document
        Dom.XmlNode root = doc.getRootElement(); //Step3:Get Root

        List<Dom.XmlNode> childs = root.getChildElements(); //Step4:Get Childs
        for(Dom.XmlNode child : childs){                    //Step5:Iterate Childs
            parsedData = parsedData+'\n'+child.getName();    //Step6:Parse Childs
            parsedData = parsedData+':'+child.getText();

        }
    }
}