public with sharing class IntegrationXMLComplexSerializeTwo {
    
    public string xmlString{get; set;}

    public void methodXMLComplexSerialize(){
        List<Account> accList = [SELECT Id, Name, Phone, Rating, (Select LastName,FirstName from Contacts
        where FirstName != null)  FROM Account where Phone != null AND 
        Rating != null LIMIT 5]; //AccountRating
        DOM.Document doc = new DOM.Document();
        DOM.XmlNode root = doc.createRootElement('Accounts', null, null);
        List<DOM.XmlNode> childs = new List<DOM.XmlNode>();
        for(Account child : accList){
            DOM.XmlNode branch = root.addChildElement('Account', null, null);
            branch.setAttribute('Name', child.Name);
            branch.setAttribute('Phone', child.Phone);
            branch.setAttribute('Rating', child.Rating);
                if(child.Contacts.size()>0){
                    DOM.XmlNode branch2 = branch.addChildElement('Contacts', null, null);
                    for(Contact conChild : child.Contacts){
                        DOM.XmlNode conBranch = branch2.addChildElement('Contact', null, null);
                        conBranch.setAttribute('FirstName', conChild.FirstName);
                        conBranch.setAttribute('LastName', conChild.LastName);
                    }

                }
        }
        xmlString = doc.toXmlString();
    }
}