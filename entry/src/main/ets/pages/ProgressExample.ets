@Preview
@Entry
@Component
struct ProgressExample {
  @State currentProgress: number = 0
  total: number = 100
  timer : number = -1

  refresh(){
    this.timer = setInterval(()=>{
      if(this.currentProgress < 100){
        this.currentProgress = this.currentProgress + Math.random()
        if(this.currentProgress > 100){
          this.currentProgress = 100
        }
      }
    },100)
  }

  build() {
    Column({space:15}){
      Text('Linear Progress').textAlign(TextAlign.Center).fontSize(20).fontColor(Color.Blue).width("100%")
      Progress({value:0,total:this.total,type:ProgressType.Linear}).color(Color.Gray).value(this.currentProgress).width(200)
      Text(`下载进度 ${this.currentProgress.toFixed(2)}/${this.total}`)
      Button('开始下载').onClick(()=>{this.refresh()})
    }
  }

  aboutToDisappear(){
    clearInterval(this.timer)
  }



}