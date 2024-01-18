import promptAction from '@ohos.promptAction'
import {provinceCityAreaMaps} from '../models/ProvinceCityMap'

// xxx.ets
@CustomDialog
struct CustomDialogExample {
  @Link candidates: string[]
  @Link selectedCandidate: string
  controller: CustomDialogController

  build() {
    Column(){
        ForEach(this.candidates, (candidate)=>{
          Text(candidate).onClick(()=>{
            this.selectedCandidate = candidate
          })
        })
    }
  }
}




@Preview
@Entry
@Component
struct CustomDialogUser {
  @State provinces: string[] = []
  @State cities: string[] = []
  @State areas: string[] =[]

  @State selectedProvince: string = ""
  @State selectedCity: string = ""
  @State selectedArea: string = ""

  provinceDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $provinces,
      selectedCandidate: $selectedProvince
    })
  })

  cityDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $cities,
      selectedCandidate: $selectedCity
    })
  })

  areaDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $areas,
      selectedCandidate: $selectedArea
    })
  })

  setProvinceList(){
    this.provinces = provinceCityAreaMaps.map(province => {return province.name})
  }

  setCityList() {
    this.cities = provinceCityAreaMaps.filter(item => item.name === this.selectedProvince)[0].city
      .map(item=>{return item.name})
  }

  setAreaList(){
    this.areas = provinceCityAreaMaps.filter(item => item.name === this.selectedProvince)[0].city
      .filter(city => city.name === this.selectedCity)[0].area
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }


  build() {
    Column({space:20}) {
      Button("请选择省份")
        .onClick(() => {
          this.setProvinceList()
          if (this.provinceDialogController != undefined) {
            this.provinceDialogController.open()
          }
        }).backgroundColor(Color.Blue)


      Button("请选择城市")
        .onClick(() => {
          this.setCityList()
          if (this.cityDialogController != undefined) {
            this.cityDialogController.open()
          }
        }).backgroundColor(Color.Blue)


      Button("请选择区县")
        .onClick(() => {
          this.setAreaList()
          if (this.areaDialogController != undefined) {
            this.areaDialogController.open()
          }
        }).backgroundColor(Color.Blue)

    }.width('100%').margin({ top: 5 })



  }


  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.provinceDialogController = undefined // 将dialogController置空
    this.cityDialogController = undefined
    this.areaDialogController = undefined

  }
}