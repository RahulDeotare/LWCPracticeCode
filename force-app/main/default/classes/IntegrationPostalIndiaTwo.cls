public with sharing class IntegrationPostalIndiaTwo {
    
    public List<String> places{get; set;}
    public string pincode{get; set;}

    public void getPincodeDetailAddress(){
        
        places = new List<String>();
        String enpt = 'https://api.postalpincode.in/pincode/'+pincode;
        Http p = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(enpt);
        request.setMethod('GET');

        HttpResponse response = p.send(request);
        String body = response.getBody();

        System.JSONParser jp = JSON.createParser(body);
        while(jp.nextToken()!=null){
            if(jp.getText() == 'Name'){
                jp.nextToken();
                places.add(jp.getText());

            }
        }
    }
}