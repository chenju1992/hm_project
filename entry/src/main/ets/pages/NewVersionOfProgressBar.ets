import {ProgressBarStateEnum} from '../models/ProgressBarStateEnum'

@Entry
@Component
@Preview
struct NewVersionOfProgressBar {

  @State currentProgress: number = 0
  @State currentProgressSpeed : number = 0
  @State estimateTimeRemaining : number = NaN
  @State progressBarState : ProgressBarStateEnum = ProgressBarStateEnum.IDLE

  previousProgress: number = 0
  total : number = 100
  timer : number = -1

  build(){
    Column({space:15}) {
      Text('Linear Progress').textAlign(TextAlign.Center).fontSize(20).fontColor(Color.Blue).width("100%")
      Progress({value:0,total:this.total,type:ProgressType.Linear}).color(Color.Gray).value(this.currentProgress).width(200)
      Text(`下载进度${this.getCurrentProgress().toFixed(2)}/${this.getTotal()}`)
      Text(`当前前下载速度${this.getCurrentProgressSpeed().toFixed(2)}`)
      if(this.currentProgress === this.total){
        Button('完成').onAppear(()=>{this.progressBarState = ProgressBarStateEnum.FINISHED})
      }

      if(this.progressBarState === ProgressBarStateEnum.PROGRESSING){
        Text(`剩余完成时间${this.getEstimateTimeRemaining().toFixed(2)}秒`)
      }

      if(this.progressBarState === ProgressBarStateEnum.IDLE) {
        Button('开始下载').onClick(() => {
          this.simulateEvolving(0.1)
          this.progressBarState = ProgressBarStateEnum.PROGRESSING
          this.getProgressSpeedEveryPeriod(1)
          this.getRemainingTimeEstimationEveryPeriod(1)
        })
      }

      if(this.progressBarState === ProgressBarStateEnum.PROGRESSING){
        Button('暂停').onClick(()=>{
          clearInterval(this.timer)
          this.progressBarState = ProgressBarStateEnum.PAUSED}
        )
      }

      if(this.progressBarState === ProgressBarStateEnum.PAUSED){
        Button('继续').onClick(()=>{
          this.simulateEvolving(0.1)
          this.progressBarState = ProgressBarStateEnum.PROGRESSING})
      }
    }
  }

  getCurrentProgress(){
    return this.currentProgress
  }

  getTotal(){
    return this.total
  }

  getCurrentProgressSpeed(){
    return this.currentProgressSpeed
  }

  getEstimateTimeRemaining(){
    return this.estimateTimeRemaining
  }

  getProgressSpeed(periodInSecond:number){
    if(this.progressBarState === ProgressBarStateEnum.PROGRESSING){
        this.currentProgressSpeed = (this.currentProgress - this.previousProgress ) / periodInSecond
        this.previousProgress = this.currentProgress
    }else{
      this.currentProgressSpeed = 0
    }
  }

  getProgressSpeedEveryPeriod(periodInSecond:number){
    setInterval(()=>{this.getProgressSpeed(periodInSecond)},
      periodInSecond * 1000)
  }

  getRemainingTimeEstimation(){
    if(this.progressBarState === ProgressBarStateEnum.PROGRESSING){
      this.estimateTimeRemaining = (this.total - this.currentProgress) / this.currentProgressSpeed
    }else{
      this.estimateTimeRemaining = NaN
    }
  }

  getRemainingTimeEstimationEveryPeriod(periodInSecond:number){
    setInterval(()=>{this.getRemainingTimeEstimation()},periodInSecond * 1000)
  }

  simulateEvolving(periodInSecond:number){
    this.timer = setInterval(()=>{
      if(this.currentProgress < this.total){
        this.currentProgress = this.currentProgress + Math.random()
        if(this.currentProgress > this.total){
          this.currentProgress = this.total
        }
      }
    },periodInSecond * 1000)
  }

}