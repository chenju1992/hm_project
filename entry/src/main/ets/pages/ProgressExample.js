"use strict";
struct ProgressExample extends   {
    constructor() { }
    refresh() {
        this.timer = setInterval(() => {
            if (this.currentProgress < this.total) {
                this.currentProgress = this.currentProgress + this.getCurrentDownloadSpeed();
                if (this.currentProgress > this.total) {
                    this.currentProgress = this.total;
                }
            }
        }, 100);
    }
    getProgressString(isDisplayPercentage) {
        if (isDisplayPercentage) {
            return `${(this.currentProgress / this.total * 100).toFixed(2)}%`;
        }
        return `${this.currentProgress.toFixed(2)}/${this.total}`;
    }
    estimateRemainingTime() {
        if (this.currentProgress === this.total) {
            return 0;
        }
        if (!this.isDownloading || (this.isDownloading && this.isPaused)) {
            return NaN;
        }
        let currentProgress = this.currentProgress;
        let previousProgress = this.previousProgress;
        this.previousProgress = this.currentProgress;
        return (this.total - this.currentProgress) / (currentProgress - previousProgress);
    }
    estimateRemainingTimeEverySecond() {
        this.estimationTimer = setInterval(() => { this.estimateTimeRemaining = this.estimateRemainingTime(); }, 1000);
    }
    getCurrentDownloadSpeed() {
        if (!this.isDownloading || this.isPaused || this.currentProgress === this.total) {
            this.currentDownloadSpeed = 0;
        }
        else if (this.currentProgress < this.total) {
            this.currentDownloadSpeed = Math.random();
        }
        return this.currentDownloadSpeed;
    }
    build() {
        ;
    }
    aboutToDisappear() {
        clearInterval(this.timer);
        clearInterval(this.estimateTimeRemaining);
    }
}
//# sourceMappingURL=ProgressExample.js.map