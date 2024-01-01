public with sharing class IntegrationFileAttachmentSer {
    
    public void createFileAttachmentJSON(){

        Document d = [SELECT Id, Body, ContentType, Name FROM Document WHERE Name = 'Green Logo'];

        String js1 = JSON.serialize(d); // simple approach
        System.debug(js1);
        //String jsonString = JSON.serialize(d);
        System.JSONGenerator js= JSON.createGenerator(True); // complex approach
        js.writeStartObject();
        
            js.writeBlobField('Attachment', d.Body);
           

        js.writeEndObject();
        string jsonString = js.getAsString();
        System.debug(jsonString);

        //------Deserialize the attachment------//
        // Blob jds1= (Blob)JSON.deserialize(js1, Blob.class); // simple approach
        // System.debug(jds1);

        System.JSONParser jp= JSON.createParser(jsonString); // complex approach
        
        while(jp.nextToken()!=null){
            if(jp.getText()=='Attachment'){
                jp.nextToken();
                Blob b = (Blob) jp.getBlobValue();
                System.debug(b);
                Document d1 = new Document();
                d1.Body = b;
                d1.FolderId = UserInfo.getUserId();
                d1.ContentType = 'image/png';
                d1.Name = 'Green Logo';
                insert d1;
            }
        }
    }
}