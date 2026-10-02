import { LightningElement, api, track } from 'lwc';
import { subscribe } from 'lightning/empApi';
import { NavigationMixin } from 'lightning/navigation';

export default class PlatformEventDemo extends NavigationMixin(LightningElement) {

    @track data = [];
    @track columns = [
        { label: 'Id', fieldName: 'Detail_Record_ID__c' },
        { label: 'Object Name', fieldName: 'Object_Name__c' }
    ];

    subscription = {};
    @api channelName = '/event/Launch_Recommendation_Flow__e';

    connectedCallback() {
        this.handleSubscribe();
    }

    proxyToObj(obj) {
        return JSON.parse(JSON.stringify(obj));
    }

    handleSubscribe() {
        const self = this;
        const messageCallback = function (response) {
            console.log('New message received 1: ', JSON.stringify(response));
            console.log('New message received 2: ', response);

            const obj = JSON.parse(JSON.stringify(response));
            const payload = obj.data.payload;

            self.data = self.proxyToObj(self.data);
            self.data.push({
                Detail_Record_ID__c: payload.Detail_Record_ID__c,
                Object_Name__c: payload.Object_Name__c
            });
            console.log('this.data -> ' + JSON.stringify(self.data));

            // Launch the flow
            self.launchFlow('Platform_Event_FInal_FLow_to_Show');
            //self.launchFlow('https://rajanjasuja-dev-ed.lightning.force.com/lightning/o/Lead/list?filterName=__Recent');
        };

        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
        });
    }

    launchFlow(flowApiName) {
        this[NavigationMixin.Navigate]({
            type: 'standard__flow',
            attributes: {
                flowApiName: flowApiName
            }
        });
    }
}