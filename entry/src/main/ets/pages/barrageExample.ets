@Preview
@Entry
@Component
struct BarrageExample {

  comments: string[] = ["哈哈","呵呵","好高兴啊","好开心啊","好爽啊"]
  scroller : Scroller = new Scroller()

  build() {
    Column() {
      List({space: 20, scroller:this.scroller}){
        if(this.comments.length){
          ForEach(this.comments,(item:string,index:number)=>{
            ListItem(){
              Row({space:5}){
                Text(item)
              }.height(36).padding({
                left:6,
                top:6,
                bottom:6,
                right:10
              }).borderRadius(42).backgroundColor("#CDFFD9")
            }
          })
        }

      }.listDirection(Axis.Horizontal).height(36)
    }.width('100%')

  }

}