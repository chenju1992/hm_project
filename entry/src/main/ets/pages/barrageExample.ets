@Preview
@Entry
@Component
struct BarrageExample {
  @State flag: boolean = false
  @State show: string = "弹幕"

  build() {
    Column() {
      Button(this.show).width(80).height(30).margin(30).onClick(
        ()=>{
          this.flag = !this.flag
        }
      )

          // Image的显示和消失配置为不同的过渡效果
      if(this.flag){
        Text("hahaha").width("100%")
          .translate({x : '0%'})
          .animation({duration:1000})

        // Text("hehe").width('100%')
        //   .transition({ type: TransitionType.Insert, translate: { x: "-100%" } })
        //   .transition({ type: TransitionType.Delete, translate: { x: "100%" } })
        //   .animation({duration:1000})
      }

    }.width('100%')

  }

}