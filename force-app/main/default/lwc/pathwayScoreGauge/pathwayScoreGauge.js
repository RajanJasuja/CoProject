import { LightningElement, api } from 'lwc';

export default class PathwayScoreGauge extends LightningElement {
    @api pathwayScore = 0;

    get scorePercentage() {
        return Math.min(Math.max(parseInt(this.pathwayScore, 10) || 0, 0), 100);
    }

    get scoreStatus() {
        const score = this.scorePercentage;
        if (score >= 0 && score <= 30) return 'Fair';
        if (score >= 31 && score <= 60) return 'Good';
        if (score >= 61 && score <= 100) return 'Excellent';
        return 'Fair';
    }

    get scoreColor() {
        const score = this.scorePercentage;
        if (score >= 0 && score <= 30) return '#E74C3C'; // Red for Fair
        if (score >= 31 && score <= 60) return '#F39C12'; // Orange for Good
        if (score >= 61 && score <= 100) return '#27AE60'; // Green for Excellent
        return '#E74C3C';
    }

    connectedCallback() {
        this.applyCircleStyles();
    }

    renderedCallback() {
        this.applyCircleStyles();
    }

    applyCircleStyles() {
        const circle = this.template.querySelector('.foreground-circle');
        const messageSpan = this.template.querySelector('.status-message');
        
        if (circle) {
            const radius = 80;
            const circumference = 2 * Math.PI * radius;
            const strokeDashoffset = circumference - (this.scorePercentage / 100) * circumference;
            
            circle.setAttribute('stroke', this.scoreColor);
            circle.setAttribute('stroke-dasharray', circumference);
            circle.setAttribute('stroke-dashoffset', strokeDashoffset);
        }

        if (messageSpan) {
            messageSpan.setAttribute('class', `status-message ${this.scoreStatus.toLowerCase()}`);
        }
    }
}