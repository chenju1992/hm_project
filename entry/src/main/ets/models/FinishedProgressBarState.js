import { ProgressBarStateEnum } from '../models/ProgressBarStateEnum';
export class FinishedProgressBarState {
    constructor(progressBarData) {
        this.progressBarState = ProgressBarStateEnum.FINISHED;
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
        return 0;
    }
    calculateEstimateRemainingTime() {
        return NaN;
    }
}
//# sourceMappingURL=FinishedProgressBarState.js.map