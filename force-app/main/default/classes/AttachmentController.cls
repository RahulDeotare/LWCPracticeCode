public class AttachmentController{
    public String Id;
   // public Account myacc;
    public ApexPages.StandardController stdCtrl;
    public String  AccountSaveId;
    //public String recordId{get; set;}
    //public Account acc{get; set;}
    public String Name{get; set;}
    public String attachid{get; set;}
    public Id recId{get;set;}
    public String fileName{get;set;}
    public Blob fileBody{get;set;}
    
    public AttachmentController(ApexPages.StandardController controller){
        recId = controller.getRecord().Id;
        //System.debug('Account ID' + recId);
        this.AccountSaveId = controller.getId();
        stdCtrl = controller;
    }
    
     
    
    
    public PageReference uploadFile(){
        PageReference pr;
        //System.debug('fileBody' + fileBody );
        //System.debug('fileName' + fileName );
        if(fileBody != null && fileName != null){
            Attachment myAttachment  = new Attachment();  
            myAttachment.Body = fileBody;  
            myAttachment.Name = fileName;  
            myAttachment.ParentId = recId;  
            //System.debug('Parent ID' + recId );
            insert myAttachment;
            PageReference currentPage = ApexPages.currentPage();
            currentPage.setRedirect(true);
            return currentPage;
        }
        return null;
    }
    
    public PageReference move(){
        Id = System.currentPageReference().getParameters().get('Id');
        PageReference traverseToEditPage = new PageReference('/apex/AssignmentVFPage2?Id='+Id);
        traverseToEditPage.setRedirect(true);
        return traverseToEditPage;
    }
    
    public PageReference detailPageOfAccount(){
        Id = System.currentPageReference().getParameters().get('Id');
        PageReference attachPage = new PageReference('/apex/ManagingAttachmentsVF2?Id='+Id);
        attachPage.setRedirect(true);
        return attachPage;
    }
    
    public PageReference next(){
        Id = System.currentPageReference().getParameters().get('Id');
        PageReference traverseToAttachementPage = new PageReference('/apex/AssignmentVFPage3?Id='+Id);
        traverseToAttachementPage.setRedirect(true);
        return traverseToAttachementPage;
    }
    
    
    
    public void  deleteAttach(){
        System.debug('attach id'+attachid); // for debug process
        list<Attachment> attachmentToDel =[SELECT id FROM Attachment where id =: attachid];
        delete attachmentToDel;
        
    }
    public PageReference GoTo(){
        Id = System.currentPageReference().getParameters().get('Id');
        PageReference DetailPage = new PageReference('/apex/ManagingAttachments?Id='+Id);
        DetailPage.setRedirect(true);
        return DetailPage;
        }
}