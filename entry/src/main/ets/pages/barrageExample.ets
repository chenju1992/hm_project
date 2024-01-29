@Preview
@Entry
@Component
struct BarrageExample {

  comments: string[] = ["哈哈","呵呵","好高兴啊","好开心啊","好爽啊","太爽啦",'太高兴啦',"太开心啦"]
  scroller : Scroller = new Scroller()
  timer : number = -1
  xOffset : number = 0

  startScroll(){
    this.timer = setInterval(()=>{
      this.xOffset = this.xOffset + 0.4
      this.scroller.scrollTo({xOffset:this.xOffset,yOffset:0})
    }, 1000/60)
  }

  handleScrollIndex(start:number){
    if(start === this.comments.length){
      this.xOffset = 0;
      this.scroller.scrollTo({xOffset:this.xOffset,yOffset:0})
    }
  }

  stopScroll(){
    clearInterval(this.timer)
  }



  build() {
    Column() {
      List({scroller:this.scroller}){
        if(this.comments.length){
          ForEach([...this.comments,...this.comments],(item:string,index:number)=>{
            ListItem(){
              Row({space:5}){
                Text(item)
              }.height(36).padding({
                left:6,
                top:6,
                bottom:6,
                right:10
              }).borderRadius(42).backgroundColor("#CDFFD9").margin({right:20})
            }
          })
        }

      }.listDirection(Axis.Horizontal).height(36)
       .onScrollIndex((start:number)=>{this.handleScrollIndex(start)}).onAppear(()=>{
        this.startScroll()
      })
    }.width('100%')

  }

}