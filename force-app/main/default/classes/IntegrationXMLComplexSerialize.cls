public class IntegrationXMLComplexSerialize {

    public string xmlString{get; set;}

    public IntegrationXMLComplexSerialize() {

        List<Account> accList = [SELECT Id, Name, Phone, Rating FROM Account where Phone != null AND 
        Rating != null LIMIT 5];
        DOM.Document doc = new DOM.Document();
        DOM.XmlNode root = doc.createRootElement('Accounts', null, null);

        for(Account acc : accList){
            DOM.XmlNode branch = root.addChildElement('Account', null, null);
            branch.setAttribute('Name', acc.Name);
            branch.setAttribute('Phone', acc.Phone);
            branch.setAttribute('Rating', acc.Rating);

        }
        xmlString = doc.toXmlString();
    }
}