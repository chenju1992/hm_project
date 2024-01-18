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
    }),
    cancel: ()=>{this.setCityList()}
  })

  cityDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $cities,
      selectedCandidate: $selectedCity
    }),
    cancel:()=>{this.setAreaList()}
  })

  areaDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $areas,
      selectedCandidate: $selectedArea
    }),
    cancel:()=>{this.displayResult()}
  })

  setProvinceList(){
    this.provinces = provinceCityAreaMaps.map(province => {return province.name})
  }

  setCityList() {
    if(!!(this.selectedProvince)){
      this.cities = provinceCityAreaMaps.filter(item => item.name === this.selectedProvince)[0].city
        .map(item=>{return item.name})
    }
  }

  setAreaList(){
    console.log(this.selectedCity);
    if(!!(this.selectedCity && this.selectedProvince)){
      this.areas = provinceCityAreaMaps.filter(item => item.name === this.selectedProvince)[0].city
        .filter(city => city.name === this.selectedCity)[0].area
    }
  }

  displayResult(){
    if(!!(this.selectedProvince && this.selectedCity && this.selectedArea)){
      promptAction.showToast({
        message: `${this.selectedProvince}-${this.selectedCity}-${this.selectedArea}`
      })
    }
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

  aboutToAppear(){
    this.setProvinceList()
  }


  build() {
    Column({space:20}) {
      Button("请选择省份")
        .onClick(() => {
          if (this.provinceDialogController != undefined) {
            this.provinceDialogController.open()
          }
        }).backgroundColor(Color.Blue).enabled(this.provinces.length > 0)


      Button("请选择城市")
        .onClick(() => {
          if (this.cityDialogController != undefined) {
            this.cityDialogController.open()
          }
        }).backgroundColor(Color.Blue).enabled(this.cities.length > 0)


      Button("请选择区县")
        .onClick(() => {
          if (this.areaDialogController != undefined) {
            this.areaDialogController.open()
          }
        }).backgroundColor(Color.Blue).enabled(this.areas.length > 0)

    }.width('100%').margin({ top: 5 })

  }


  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.provinceDialogController = undefined
    this.cityDialogController = undefined
    this.areaDialogController = undefined

  }
}