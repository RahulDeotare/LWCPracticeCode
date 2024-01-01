import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import submitXMLFile from '@salesforce/apex/IntegratinXMLDeserializeFile.deserializeXMLFile';
export default class FileUploadComponentXMLDeser extends LightningElement {


    xmlFile;

    handleFileUpload(event) {
        const file = event.target.files[0];
        const reader = new FileReader();
        
        reader.onload = () => {
            this.xmlFile = reader.result.split(',')[1]; // Extracting the base64 content
        };

        reader.readAsDataURL(file);
    }

    uploadFile() {
        if (this.xmlFile) {
            submitXMLFile({ xmlFile: this.xmlFile })
                .then(result => {
                    // Handle the result after the file is processed on the server
                    console.log('File uploaded and processed successfully:', result);
                })
                .catch(error => {
                    // Handle any errors during the upload process
                    console.error('Error uploading file:', error);
                });
        }
    }
}