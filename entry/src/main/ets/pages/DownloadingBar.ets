import { FinishedProgressBarState } from '../models/FinishedProgressBarState'
import { IdleProgressBarState } from '../models/IdleProgressBarState'
import { IProgressBarState } from '../models/IProgressBarState'
import { OngoingProgressBarState } from '../models/OnGoingProgressBarState'
import { PausedProgressBarState } from '../models/PausedProgressBarState'
import { ProgressBarData } from '../models/ProgressBarData'
import { ProgressBarStateEnum } from '../models/ProgressBarStateEnum'
import { ProgressBarStateManager } from '../models/ProgressBarStateManager'


@Preview
@Entry
@Component
struct DownloadingBar {

  @State currentProgress: number = 0
  @State currentProgressSpeed : number = 0
  @State estimateTimeRemaining : number = NaN
  @State progressBarState : ProgressBarStateEnum = ProgressBarStateEnum.IDLE

  progressBarData : ProgressBarData = new ProgressBarData()
  idleProgressBarState : IProgressBarState = new IdleProgressBarState(this.progressBarData)
  onGoingProgressBarState : IProgressBarState = new OngoingProgressBarState(this.progressBarData)
  pausedProgressBarState : IProgressBarState = new PausedProgressBarState(this.progressBarData)
  finishedProgressBarState : IProgressBarState = new FinishedProgressBarState(this.progressBarData)
  manager : ProgressBarStateManager = new ProgressBarStateManager(this.progressBarData)

  timer : number = -1

  aboutToAppear(){
    this.progressBarData.setCurrentProgress(0)
    this.progressBarData.setTotalProgress(200)
    this.manager.setProgressBarState(this.idleProgressBarState)
  }


  build() {
    Column({ space: 15 }) {
      Text('Linear Progress').textAlign(TextAlign.Center).fontSize(20).fontColor(Color.Blue).width("100%")
      Progress({value:0, total:this.manager.getTotalProgress(),type:ProgressType.Linear}).color(Color.Gray).value(this.currentProgress).width(200)
      Text(`下载进度${this.currentProgress === this.manager.getTotalProgress() ? this.manager.getTotalProgress() : this.currentProgress.toFixed(2)}/${this.manager.getTotalProgress()}`)
      Text(`当前前下载速度${this.currentProgressSpeed.toFixed(2)}/秒`)

      if(this.currentProgress === this.manager.getTotalProgress()){
            Text("已完成")
            Button('完成').onAppear(()=>{
              this.manager.setProgressBarState(this.finishedProgressBarState)
              this.progressBarState = this.manager.getProgressBarStateEnum()
              clearInterval(this.timer)
            })
      }

      if(this.progressBarState === ProgressBarStateEnum.IDLE) {
            Button('开始下载').onClick(() => {
              this.manager.setProgressBarState(this.onGoingProgressBarState)
              this.progressBarState = this.manager.getProgressBarStateEnum()

              this.simulateEvolving(0.1)
              this.getProgressSpeedEveryPeriod(3)
              this.getRemainingTimeEstimationEveryPeriod(3)
            })
      }

      if(this.progressBarState === ProgressBarStateEnum.ONGOING){
            Text(`剩余完成时间${this.estimateTimeRemaining.toFixed(2)}秒`)
            Button('暂停').onClick(()=>{
              clearInterval(this.timer)
              this.manager.setProgressBarState(this.pausedProgressBarState)
              this.progressBarState = this.manager.getProgressBarStateEnum()
            }
            )
      }

      if(this.progressBarState === ProgressBarStateEnum.PAUSED){
            Text("已暂停")
            Button('继续').onClick(()=>{
              this.manager.setProgressBarState(this.onGoingProgressBarState)
              this.progressBarState = this.manager.getProgressBarStateEnum()

              this.simulateEvolving(0.1)
              this.getProgressSpeedEveryPeriod(2)
              this.getRemainingTimeEstimationEveryPeriod(2)
              })
      }
    }
  }

  getProgressSpeedEveryPeriod(periodInSecond:number){
        setInterval(()=>{
          this.currentProgressSpeed = this.manager.calculateProgressSpeed()},
          periodInSecond * 1000)
      }


  getRemainingTimeEstimationEveryPeriod(periodInSecond:number){
        setInterval(()=>{this.estimateTimeRemaining = this.manager.calculateEstimateRemainingTime()},periodInSecond * 1000)
      }

  simulateEvolving(periodInSecond:number){
        this.timer = setInterval(()=>{
          if(this.manager.getCurrentProgress() < this.manager.getTotalProgress()){
            this.manager.setCurrentProgress(this.manager.getCurrentProgress() + Math.random())
            this.currentProgress = this.manager.getCurrentProgress()
            if(this.manager.getCurrentProgress() > this.manager.getTotalProgress()){
              this.manager.setCurrentProgress(this.manager.getTotalProgress())
              this.currentProgress = this.manager.getTotalProgress()
            }
          }
        }, periodInSecond * 1000)
    }
}

