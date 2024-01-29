export class ProgressBarStateManager {
    constructor(progressBarData) {
        this.progressBarData = progressBarData;
    }
    getProgressBarState() {
        return this.progressBarState;
    }
    getTotalProgress() {
        return this.progressBarData.getTotalProgress();
    }
    getProgressBarStateEnum() {
        return this.progressBarStateEnum;
    }
    getCurrentProgress() {
        return this.progressBarData.getCurrentProgress();
    }
    setProgressBarState(progressBarState) {
        this.progressBarState = progressBarState;
        this.progressBarStateEnum = progressBarState.getProgressBarStateEnum();
    }
    setTotalProgress(totalProgress) {
        return this.progressBarData.setTotalProgress(totalProgress);
    }
    setCurrentProgress(currentProgress) {
        return this.progressBarData.setCurrentProgress(currentProgress);
    }
    calculateProgressSpeed() {
        return this.progressBarState.calculateProgressSpeed();
    }
    calculateEstimateRemainingTime() {
        return this.progressBarState.calculateEstimateRemainingTime();
    }
}
//# sourceMappingURL=ProgressBarStateManager.js.map