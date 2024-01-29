import { FinishedProgressBarState } from '../models/FinishedProgressBarState';
import { IdleProgressBarState } from '../models/IdleProgressBarState';
import { OngoingProgressBarState } from '../models/OnGoingProgressBarState';
import { PausedProgressBarState } from '../models/PausedProgressBarState';
import { ProgressBarData } from '../models/ProgressBarData';
import { ProgressBarStateEnum } from '../models/ProgressBarStateEnum';
import { ProgressBarStateManager } from '../models/ProgressBarStateManager';
struct DownloadingBar extends   {
    constructor() { }
    aboutToAppear() {
        this.progressBarData.setCurrentProgress(0);
        this.progressBarData.setTotalProgress(200);
        this.manager.setProgressBarState(this.idleProgressBarState);
    }
    aboutToDisappear() {
        this.progressBarData = undefined;
        this.idleProgressBarState = undefined;
        this.onGoingProgressBarState = undefined;
        this.pausedProgressBarState = undefined;
        this.finishedProgressBarState = undefined;
        this.manager = undefined;
    }
    build() {
        ;
    }
    getProgressSpeedEveryPeriod(periodInSecond) {
        setInterval(() => {
            this.currentProgressSpeed = this.manager.calculateProgressSpeed();
        }, periodInSecond * 1000);
    }
    getRemainingTimeEstimationEveryPeriod(periodInSecond) {
        setInterval(() => { this.estimateTimeRemaining = this.manager.calculateEstimateRemainingTime(); }, periodInSecond * 1000);
    }
    simulateEvolving(periodInSecond) {
        this.timer = setInterval(() => {
            if (this.manager.getCurrentProgress() < this.manager.getTotalProgress()) {
                this.manager.setCurrentProgress(this.manager.getCurrentProgress() + Math.random());
                this.currentProgress = this.manager.getCurrentProgress();
                if (this.manager.getCurrentProgress() > this.manager.getTotalProgress()) {
                    this.manager.setCurrentProgress(this.manager.getTotalProgress());
                    this.currentProgress = this.manager.getTotalProgress();
                }
            }
        }, periodInSecond * 1000);
    }
}
//# sourceMappingURL=DownloadingBar.js.map