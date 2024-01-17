import HashMap from '@ohos.util.HashMap'

@Preview
@Entry
@Component
struct DialogControllerPractice {
  @State  currentProvince: string = ''
  @State  currentCity: string = ''
  hashMap = new HashMap<string,Array<string>>()
  onPageShow(){
    this.hashMap.set("hunan",["changsha","zhuzhou","xiangtan"])
    this.hashMap.set("guangdong",["guangzhou","shenzhen","zhuhai"])
  }

  build() {
    Row() {
      Column() {
        Button("请点击").onClick(()=>{

        })
      }
      .width('100%')
    }
    .height('100%')
  }

  onPageHide(){
    this.hashMap = null
  }
}




