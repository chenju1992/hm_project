import {IProgressBarState} from '../models/IProgressBarState'
import { ProgressBarData } from './ProgressBarData'
import {ProgressBarStateEnum} from '../models/ProgressBarStateEnum'

export class IdleProgressBarState implements IProgressBarState{
  progressBarData : ProgressBarData
  progressBarState: ProgressBarStateEnum = ProgressBarStateEnum.IDLE

  constructor(progressBarData:ProgressBarData) {
    this.progressBarData = progressBarData
  }

  getTotalProgress(){
    return this.progressBarData.getTotalProgress()
  }

  getCurrentProgress(){
    return this.progressBarData.getCurrentProgress()
  }


  getProgressBarStateEnum(){
    return this.progressBarState
  }

  setTotalProgress(totalProgress:number){
    this.progressBarData.totalProgress = totalProgress
  }

  setCurrentProgress(currentProgress:number){
    this.progressBarData.currentProgress = currentProgress
  }


  calculateProgressSpeed():number{
    return 0
  }

  calculateEstimateRemainingTime():number{
    return NaN
  }
}