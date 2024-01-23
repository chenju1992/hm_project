@Preview
@Entry
@Component
struct ProgressExample {
  @State currentProgress: number = 0
  @State previousProgress:number = 0
  @State isDownloading : boolean = false
  @State currentDownloadSpeed : number = -1
  @State isPaused : boolean = false
  @State estimateTimeRemaining : number = NaN

  total: number = 100
  timer : number = -1
  estimationTimer : number = -1

  refresh(){
    this.timer = setInterval(()=>{
      if(this.currentProgress < this.total){
        this.currentProgress = this.currentProgress + this.getCurrentDownloadSpeed()
        if(this.currentProgress > this.total){
          this.currentProgress = this.total
        }
      }
    },100)
  }

  getProgressString(isDisplayPercentage:boolean){

    if(isDisplayPercentage){
      return `${(this.currentProgress/this.total * 100).toFixed(2)}%`
    }
    return `${this.currentProgress.toFixed(2)}/${this.total}`
  }

  estimateRemainingTime(){
    if(this.currentProgress === this.total){
      return 0
    }
    if(!this.isDownloading || (this.isDownloading && this.isPaused)){
      return NaN
    }

    let currentProgress = this.currentProgress
    let previousProgress = this.previousProgress
    this.previousProgress = this.currentProgress

    return (this.total - this.currentProgress) / (currentProgress - previousProgress)
  }

  estimateRemainingTimeEverySecond(){
    this.estimationTimer = setInterval(()=>{this.estimateTimeRemaining = this.estimateRemainingTime()},1000)
  }

  getCurrentDownloadSpeed(){
    if(!this.isDownloading || this.isPaused || this.currentProgress === this.total){
      this.currentDownloadSpeed = 0
    }else if(this.currentProgress < this.total){
      this.currentDownloadSpeed = Math.random()
    }
    return this.currentDownloadSpeed
  }

  build() {
    Column({space:15}){
      Text('Linear Progress').textAlign(TextAlign.Center).fontSize(20).fontColor(Color.Blue).width("100%")
      Progress({value:0,total:this.total,type:ProgressType.Linear}).color(Color.Gray).value(this.currentProgress).width(200)
      Text(`下载进度` + this.getProgressString(false))
      Text('当前下载速度' + this.getCurrentDownloadSpeed().toFixed(2))
      if(this.isDownloading && !this.isPaused){
        Text("估计剩余时间" + this.estimateTimeRemaining.toFixed(2)).onAppear(()=>{this.estimateRemainingTimeEverySecond()})
      }
      if(!this.isDownloading){
        Button('开始下载').onClick(()=> {
          this.refresh()
          this.isDownloading = true
        })
      }

        if(this.isDownloading && this.currentProgress < this.total){
          Row({space:20}){
            Button('暂停').onClick(()=>{
              this.isPaused = true
              clearInterval(this.timer)
            })
            Button('继续').onClick(()=> {
              this.isPaused = false;
              this.refresh()
            })
          }
        }
      if(this.currentProgress === this.total){
        Button('完成')
      }
      }
    }


  aboutToDisappear(){
    clearInterval(this.timer)
    clearInterval(this.estimateTimeRemaining)
  }

}