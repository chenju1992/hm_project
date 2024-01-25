import {ProgressBarData} from '../models/ProgressBarData'
import {IProgressBarState} from '../models/IProgressBarState'
import { ProgressBarStateEnum } from '../models/ProgressBarStateEnum'

export class ProgressBarStateManager{

  progressBarData : ProgressBarData
  progressBarState: IProgressBarState
  progressBarStateEnum : ProgressBarStateEnum

  constructor(progressBarData:ProgressBarData) {
    this.progressBarData = progressBarData
  }

  getProgressBarState(){
    return this.progressBarState
  }

  getTotalProgress(){
    return this.progressBarData.getTotalProgress()
  }

  getProgressBarStateEnum(){
    return this.progressBarStateEnum
  }

  getCurrentProgress(){
    return this.progressBarData.getCurrentProgress()
  }

  setProgressBarState(progressBarState:IProgressBarState){
    this.progressBarState = progressBarState
    this.progressBarStateEnum = progressBarState.getProgressBarStateEnum()
  }

  setTotalProgress(totalProgress : number){
    return this.progressBarData.setTotalProgress(totalProgress)
  }

  setCurrentProgress(currentProgress: number){
    return this.progressBarData.setCurrentProgress(currentProgress)
  }

  calculateProgressSpeed():number{
    return this.progressBarState.calculateProgressSpeed()
  }

  calculateEstimateRemainingTime():number{
    return this.progressBarState.calculateEstimateRemainingTime()
  }



}