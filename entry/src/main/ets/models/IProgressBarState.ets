import { ProgressBarStateEnum } from './ProgressBarStateEnum';
export interface  IProgressBarState{

  calculateProgressSpeed():number

  calculateEstimateRemainingTime():number

  getProgressBarStateEnum():ProgressBarStateEnum

}