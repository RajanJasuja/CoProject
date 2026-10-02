import { api } from 'lwc';
import { LightningElement } from 'lwc';
import LightningModal from 'lightning/modal';

export default class FlowModal extends LightningModal {
    @api header = 'Start Flow';
    @api flowName;
    @api inputVariables = [];

    handleClose() {
        // close modal without result
        this.close();
    }

    handleStatusChange(event) {
        // event.detail.status can be 'FINISHED', 'FINISHED_SCREEN', etc.
        const status = event.detail?.status;
        if (status === 'FINISHED' || status === 'FINISHED_SCREEN') {
            const outputVariables = event.detail?.outputVariables || [];
            // close modal and return outputs (optional)
            this.close({ success: true, outputVariables });
        }
    }
}