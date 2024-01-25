import {IProgressBarState} from '../models/IProgressBarState'
import { ProgressBarData } from './ProgressBarData'
import {ProgressBarStateEnum} from '../models/ProgressBarStateEnum'

export class OngoingProgressBarState implements IProgressBarState{

  progressBarData : ProgressBarData
  progressBarState: ProgressBarStateEnum = ProgressBarStateEnum.ONGOING

  previousProgress: number = 0
  currentSpeed: number = 0

  previousTimeStamp: number = new Date().valueOf()



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
    let currentProgress: number  = this.getCurrentProgress()
    let currentTime = new Date().valueOf()
    let result : number = (currentProgress - this.previousProgress) / (currentTime - this.previousTimeStamp)

    this.previousProgress = currentProgress
    this.previousTimeStamp = currentTime

    this.currentSpeed = result * 1000
    console.log((currentTime - this.previousTimeStamp).toString())

    return this.currentSpeed
  }

  calculateEstimateRemainingTime():number{
    return (this.getTotalProgress() - this.getCurrentProgress()) / this.currentSpeed
  }
}