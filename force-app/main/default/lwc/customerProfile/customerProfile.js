import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getFieldDisplayMetadata from '@salesforce/apex/CustomerProfileController.getFieldDisplayMetadata';

// Import standard fields
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHOTO_URL_FIELD from '@salesforce/schema/Account.PhotoUrl';

export default class CustomerProfile extends LightningElement {
    @api recordId;
    @track infoFields = [];
    @track metricFields = [];
    @track isLoading = true;
    @track hasError = false;
    @track errorMessage = '';
    
    accountName = '';
    location = '';
    avatarUrl = '/img/social/svg/avatar.svg'; // Default avatar
    metadataConfig = [];
    accountData = {};
    
    // Wire to get account record data
    @wire(getRecord, { 
        recordId: '$recordId', 
        fields: '$dynamicFields'
    })
    wiredAccount({ error, data }) {
        if (data) {
            this.accountData = data;
            this.accountName = getFieldValue(data, NAME_FIELD);
            
            // Set avatar if PhotoUrl exists
            //const photoUrl = getFieldValue(data, PHOTO_URL_FIELD);
            const photoUrl='https://rajanjasuja-dev-ed.file.force.com/profilephoto/729Ke000000KzER/T'
            if (photoUrl) {
                this.avatarUrl = photoUrl;
            }
            
            // Process fields based on metadata config
            this.processFieldsDisplay();
        } else if (error) {
            this.handleError(error);
        }
    }
    
    // Computed property for dynamic fields to fetch
    get dynamicFields() {
        const fields = [NAME_FIELD, PHOTO_URL_FIELD];
        
        if (this.metadataConfig && this.metadataConfig.length > 0) {
            this.metadataConfig.forEach(config => {
                const fieldName = `Account.${config.API_Name__c}`;
                fields.push(fieldName);
            });
        }
        
        return fields;
    }
    
    get hasMetrics() {
        return this.metricFields && this.metricFields.length > 0;
    }
    
    connectedCallback() {
        this.loadMetadataConfiguration();
    }
    
    async loadMetadataConfiguration() {
        try {
            this.isLoading = true;
            // Fetch Custom Metadata configuration
            const result = await getFieldDisplayMetadata();
            
            if (result) {
                this.metadataConfig = result;
                // Trigger wire service to refetch with new fields
                this.recordId = this.recordId;
            }
        } catch (error) {
            this.handleError(error);
        } finally {
            this.isLoading = false;
        }
    }
    
    processFieldsDisplay() {
        if (!this.accountData || !this.metadataConfig) return;
        
        const infoFieldsTemp = [];
        const metricFieldsTemp = [];
        
        this.metadataConfig.forEach(config => {
            try {
                const fieldName = `Account.${config.API_Name__c}`;
                const fieldValue = getFieldValue(this.accountData, fieldName);
                
                // Skip if field is blank and Hide_If_Blank__c is true
                if (config.Hide_If_Blank__c && !fieldValue) {
                    return;
                }
                
                const fieldDisplay = {
                    apiName: config.API_Name__c,
                    label: config.MasterLabel,
                    iconName: config.Icon_Name__c || 'utility:info',
                    value: fieldValue || 'N/A',
                    order: config.Order__c || 999
                };
                
                if (config.Section__c === 'Info') {
                    // Handle special field types
                    if (config.API_Name__c.toLowerCase().includes('email')) {
                        fieldDisplay.isEmail = true;
                        fieldDisplay.emailLink = `mailto:${fieldValue}`;
                    } else if (config.API_Name__c.toLowerCase().includes('phone')) {
                        fieldDisplay.isPhone = true;
                        fieldDisplay.phoneLink = `tel:${fieldValue}`;
                        fieldDisplay.value = this.formatPhone(fieldValue);
                    } else if (config.API_Name__c.toLowerCase().includes('address') || 
                               config.API_Name__c.toLowerCase().includes('street')) {
                        // Handle address fields
                        fieldDisplay.value = this.formatAddress(fieldValue);
                    }
                    
                    // Apply formatting
                    fieldDisplay.value = this.formatFieldValue(fieldValue, config.Format__c);
                    
                    infoFieldsTemp.push(fieldDisplay);
                    
                } else if (config.Section__c === 'Metric') {
                    const maxValue = config.Max_Value__c || 100;
                    const numericValue = this.parseNumericValue(fieldValue);
                    const percentage = Math.min((numericValue / maxValue) * 100, 100);
                    
                    fieldDisplay.rawValue = numericValue;
                    fieldDisplay.maxValue = maxValue;
                    fieldDisplay.percentage = percentage;
                    fieldDisplay.progressStyle = `width: ${percentage}%`;
                    fieldDisplay.formattedValue = this.formatFieldValue(fieldValue, config.Format__c);
                    
                    metricFieldsTemp.push(fieldDisplay);
                }
                
                // Special handling for location fields
                if (config.API_Name__c === 'BillingCity' || config.API_Name__c === 'BillingState') {
                    const city = getFieldValue(this.accountData, 'Account.BillingCity');
                    const state = getFieldValue(this.accountData, 'Account.BillingState');
                    if (city || state) {
                        this.location = `${city || ''}${city && state ? ', ' : ''}${state || ''}`;
                    }
                }
                
            } catch (err) {
                console.error(`Error processing field ${config.API_Name__c}:`, err);
            }
        });
        
        // Sort fields by order
        this.infoFields = infoFieldsTemp.sort((a, b) => a.order - b.order);
        this.metricFields = metricFieldsTemp.sort((a, b) => a.order - b.order);
    }
    
    formatFieldValue(value, format) {
        if (!value) return 'N/A';
        
        switch (format) {
            case 'currency':
                return this.formatCurrency(value);
            case 'percent':
                return this.formatPercent(value);
            case 'date':
                return this.formatDate(value);
            default:
                return value.toString();
        }
    }
    
    formatCurrency(value) {
        const num = this.parseNumericValue(value);
        if (num >= 1000000) {
            return `$${(num / 1000000).toFixed(2)}M`;
        } else if (num >= 1000) {
            return `$${(num / 1000).toFixed(0)}K`;
        }
        return `$${num.toFixed(2)}`;
    }
    
    formatPercent(value) {
        const num = this.parseNumericValue(value);
        return `${num}%`;
    }
    
    formatDate(value) {
        if (!value) return 'N/A';
        const date = new Date(value);
        return new Intl.DateTimeFormat('en-US', { 
            month: 'long', 
            year: 'numeric' 
        }).format(date);
    }
    
    formatPhone(phone) {
        if (!phone) return 'N/A';
        const cleaned = phone.replace(/\D/g, '');
        const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
        if (match) {
            return `(${match[1]}) ${match[2]}-${match[3]}`;
        }
        return phone;
    }
    
    formatAddress(value) {
        if (!value) return 'N/A';
        // If it's a compound address field, format it nicely
        if (typeof value === 'object') {
            const parts = [];
            if (value.street) parts.push(value.street);
            if (value.city) parts.push(value.city);
            if (value.state) parts.push(value.state);
            if (value.postalCode) parts.push(value.postalCode);
            return parts.join(', ');
        }
        return value;
    }
    
    parseNumericValue(value) {
        if (typeof value === 'number') return value;
        if (typeof value === 'string') {
            const cleaned = value.replace(/[^0-9.-]/g, '');
            return parseFloat(cleaned) || 0;
        }
        return 0;
    }
    
    handleImageError(event) {
        // Fallback to default avatar if image fails to load
        event.target.src = '/img/social/svg/avatar.svg';
    }
    
    handleError(error) {
        this.hasError = true;
        this.errorMessage = error?.body?.message || error?.message || 'An error occurred';
        this.showToast('Error', this.errorMessage, 'error');
        console.error('CustomerProfile Error:', error);
    }
    
    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(evt);
    }
}