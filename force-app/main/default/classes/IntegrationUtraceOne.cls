public class IntegrationUtraceOne {
    
    public string ipAddress{get; set;}
    public string body{get; set;}
    public string data{get; set;}
    public Map<String,Object> resMap{get; set;}

    public void callUtrace(){

        resMap = new Map<String,Object>();
        String endPoint = 'www.example.com'+ipAddress; //Step1:Create Endpoint
            //need to add above endpoint in Remote Site Setting in Salesforce
        Http p = new Http(); //Step2:Create Http, Initialize Http protocol
        HttpRequest request = new HttpRequest(); //Step3:Create HttpRequest structure
        request.setEndpoint(endPoint);           //Step4:Set Endpoint
        request.setMethod('GET');                //Step5:Set Method
                        
        HttpResponse response = p.send(request); //Step6:Send HttpRequest
        body = response.getBody();              //Step7:Get Body
       
        //Deserialize XML
        DOM.Document doc = new DOM.Document();
        doc.load(body);
        DOM.XmlNode root = doc.getRootElement();
        List<DOM.XmlNode> result = root.getChildElements();
        DOM.XmlNode parent = result[0]; //if more than one result is there then we are taking 1st one only
        List<DOM.XmlNode> data = parent.getChildElements();
        for(DOM.XmlNode child : data){
            resMap.put(child.getName(),child.getText());
        }
    }
}