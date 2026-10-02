import { LightningElement, api } from 'lwc';

export default class ProgressBar extends LightningElement {
    @api Score;  
    @api title;

    get computedStyle() {
        const score = this.Score || 0;
        
        // Handle zero or negative scores
        if (score <= 0) {
            return `
                width: 100%;
                background-color: #808080;
            `;
        }
        
        const percent = Math.max(0, Math.min(score, 100));

        let color = '#27AE60'; // Green for Excellent
        if (percent <= 30) {
            color = '#E74C3C'; // Red for Fair
        } else if (percent <= 60) {
            color = '#F39C12'; // Orange for Good
        }

        return `
            width: ${percent}%;
            background-color: ${color};
        `;
    }

    get labelClass() {
        const score = this.Score || 0;
        return score <= 0 ? 'progress-label-gray' : 'progress-label';
    }
}