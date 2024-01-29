import { ProgressBarStateEnum } from '../models/ProgressBarStateEnum';
export class OngoingProgressBarState {
    constructor(progressBarData) {
        this.progressBarState = ProgressBarStateEnum.ONGOING;
        this.previousProgress = 0;
        this.currentSpeed = 0;
        this.previousTimeStamp = new Date().valueOf();
        this.progressBarData = progressBarData;
    }
    getTotalProgress() {
        return this.progressBarData.getTotalProgress();
    }
    getCurrentProgress() {
        return this.progressBarData.getCurrentProgress();
    }
    getProgressBarStateEnum() {
        return this.progressBarState;
    }
    setTotalProgress(totalProgress) {
        this.progressBarData.totalProgress = totalProgress;
    }
    setCurrentProgress(currentProgress) {
        this.progressBarData.currentProgress = currentProgress;
    }
    calculateProgressSpeed() {
        let currentProgress = this.getCurrentProgress();
        let currentTime = new Date().valueOf();
        let result = (currentProgress - this.previousProgress) / (currentTime - this.previousTimeStamp);
        this.previousProgress = currentProgress;
        this.previousTimeStamp = currentTime;
        this.currentSpeed = result * 1000;
        console.log((currentTime - this.previousTimeStamp).toString());
        return this.currentSpeed;
    }
    calculateEstimateRemainingTime() {
        return (this.getTotalProgress() - this.getCurrentProgress()) / this.currentSpeed;
    }
}
//# sourceMappingURL=OnGoingProgressBarState.js.map