import { ProgressBarStateEnum } from '../models/ProgressBarStateEnum';
struct NewVersionOfProgressBar extends   {
    constructor() { }
    build() {
        ;
    }
    getCurrentProgress() {
        return this.currentProgress;
    }
    getTotal() {
        return this.total;
    }
    getCurrentProgressSpeed() {
        return this.currentProgressSpeed;
    }
    getEstimateTimeRemaining() {
        return this.estimateTimeRemaining;
    }
    getProgressSpeed(periodInSecond) {
        if (this.progressBarState === ProgressBarStateEnum.ONGOING) {
            this.currentProgressSpeed = (this.currentProgress - this.previousProgress) / periodInSecond;
            this.previousProgress = this.currentProgress;
        }
        else {
            this.currentProgressSpeed = 0;
        }
    }
    getProgressSpeedEveryPeriod(periodInSecond) {
        setInterval(() => { this.getProgressSpeed(periodInSecond); }, periodInSecond * 1000);
    }
    getRemainingTimeEstimation() {
        if (this.progressBarState === ProgressBarStateEnum.ONGOING) {
            this.estimateTimeRemaining = (this.total - this.currentProgress) / this.currentProgressSpeed;
        }
        else {
            this.estimateTimeRemaining = NaN;
        }
    }
    getRemainingTimeEstimationEveryPeriod(periodInSecond) {
        setInterval(() => { this.getRemainingTimeEstimation(); }, periodInSecond * 1000);
    }
    simulateEvolving(periodInSecond) {
        this.timer = setInterval(() => {
            if (this.currentProgress < this.total) {
                this.currentProgress = this.currentProgress + Math.random();
                if (this.currentProgress > this.total) {
                    this.currentProgress = this.total;
                }
            }
        }, periodInSecond * 1000);
    }
}
//# sourceMappingURL=NewVersionOfProgressBar.js.map