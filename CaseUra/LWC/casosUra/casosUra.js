/* eslint-disable no-undef */
/* eslint-disable no-console */
import { LightningElement, wire, track} from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import USER_ID from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';
import getCaseByID from '@salesforce/apex/CasoUraController.getCaseByID';

export default class CasosUra extends NavigationMixin(LightningElement) {


    @track columns = [{
        label: 'Caso',
        fieldName: 'nameUrl',
        type: 'url',
        cellAttributes: { iconName: 'utility:case'},
        typeAttributes: {label: { fieldName: 'caseNumber' }}
    }];

    @track error = '';
    @track payload = '';
    @track dataCase = [];
    @track caseID;
    @track userID;

    @wire(getRecord, {
        recordId: USER_ID,
        fields: [NAME_FIELD]
    }) wireuser({
        error,
        data
    }) {
        if (error) {
           this.error = error ; 
           console.log('error: '+this.error);
        } else if (data) {
            this.idUserSales = USER_ID;
        }
    }
 
    handleError(event){
        this.error = JSON.stringify(event.detail.error);
    }

    handleMessage(event){

            this.caseID = JSON.stringify(event.detail.payload.data.payload.CaseID__c).replace(/[^a-zA-Z0-9\s]/g, "").replace(/\s\s/g, " ");
            this.userID = JSON.stringify(event.detail.payload.data.payload.UserID__c).replace(/[^a-zA-Z0-9\s]/g, "").replace(/\s\s/g, " ");
            console.log('New event!');
            if(this.userID === this.idUserSales){
                getCaseByID({caseID: this.caseID}).then(result => {
                    this.dataCase=[...this.dataCase , result[0]];
                })
                .catch(error => {
                    this.error = error;
                    console.log('erro:'+this.error);
                });
            }
    }

    handleRowAction(event) {
        // const row = JSON.stringify(event.target.value);
         console.log('detal '+event.target.value);
        // const record = JSON.parse(row);
         this[NavigationMixin.Navigate]({
             type: 'standard__recordPage',
             attributes: {
                 recordId: event.target.value,
                 objectApiName: 'Case',
                 actionName: 'view'
             },
         });
         // delete item component
         this.dataCase.splice(this.dataCase.indexOf(event.target.value), 1);
     }    
}