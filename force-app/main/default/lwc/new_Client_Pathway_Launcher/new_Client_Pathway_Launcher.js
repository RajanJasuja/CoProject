import { LightningElement } from 'lwc';
import FlowModal from 'c/flowModal';



export default class New_Client_Pathway_Launcher extends LightningElement {
    // Flow API name
    flowApiName = 'New_Client_Pathway';
    renderFlow=true;

    // open the modal and pass EntityType as a flow input variable
    async openFlowModal(entityTypeLabel) {
        const inputVariables = [
            { name: 'EntityType', type: 'String', value: entityTypeLabel }
        ];

        try {
            //alert("Open called");
            const result = await FlowModal.open({
                header: entityTypeLabel === 'PersonAccount' ? 'New Customer' : 'New Business',
                flowName: this.flowApiName,
                inputVariables
            });
            //alert(result);
            // result may contain { success: true, outputVariables: [...] } if modal closed after finish
            // You can handle result if you want (e.g., show toast, navigate, etc.)
            // console.log('Modal result', result);
        } catch (err) {
            //alert("Error"+err);
            // user may have cancelled modal or an error occurred
            // console.error(err);
        }
    }

    handleNewCustomer() {
        this.openFlowModal('PersonAccount');
    }

    handleNewBusiness() {
        this.openFlowModal('Business_Entity');
    }
}