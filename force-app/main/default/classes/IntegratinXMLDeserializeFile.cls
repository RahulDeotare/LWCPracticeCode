public with sharing class IntegratinXMLDeserializeFile {
    @AuraEnabled
    public static void deserializeXMLFile(String xmlFile) {
        // Convert the base64 string back to Blob
        Blob xmlBlob = EncodingUtil.base64Decode(xmlFile);
        
        List<Account> accList = new List<Account>();

        String xmlString = xmlBlob.toString();
        xmlBlob= null;
        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);
        Dom.XmlNode root = doc.getRootElement();
        List<Dom.XmlNode> childs = root.getChildElements();
        for (Dom.XmlNode child : childs) {
            Account acc = new Account();
            acc.Name = child.getAttributeValue('Name', null);
            acc.Phone = child.getAttributeValue('Phone', null);
            acc.Rating = child.getAttributeValue('Rating', null);
            accList.add(acc);
        }
        insert accList;
    }
}
