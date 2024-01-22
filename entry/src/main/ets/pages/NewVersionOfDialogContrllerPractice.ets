import promptAction from '@ohos.promptAction'
import {CustomDialogExample} from '../views/CustomDialogExample'
import {ProvinceCityMapClass} from '../models/ProvinceCityMapClass'
import { CityAreaMapClass } from '../models/CityAreaMapClass'
import {MapManager} from '../models/MapManager'

@Preview
@Entry
@Component
struct CustomDialogUser {
  @State provinces: string[] = []
  @State cities: string[] = []
  @State areas: string[] = []

  @State selectedProvince: string = ""
  @State selectedCity: string = ""
  @State selectedArea: string = ""

  mapManager:MapManager

  provinceDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $provinces,
      selectedCandidate: $selectedProvince
    }),
    cancel: ()=>{
      this.cities = this.mapManager.getNextLayer("provinceCityMap",this.selectedProvince)
    }
  })

  cityDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $cities,
      selectedCandidate: $selectedCity
    }),
    cancel:()=>{
      this.areas = this.mapManager.getNextLayer("cityAreaMap",this.selectedCity)
    }
  })

  areaDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      candidates: $areas,
      selectedCandidate: $selectedArea
    }),
    cancel:()=>{this.displayResult()}
  })

  displayResult(){
    if(!!(this.selectedProvince && this.selectedCity && this.selectedArea)){
      promptAction.showToast({
        message: `${this.selectedProvince}-${this.selectedCity}-${this.selectedArea}`
      })
    }
  }

  aboutToAppear(){
    this.mapManager = new MapManager()
    let provinceCityMap:ProvinceCityMapClass = new ProvinceCityMapClass()
    let cityAreaMap:CityAreaMapClass = new CityAreaMapClass()
    provinceCityMap.register("provinceCityMap",this.mapManager)
    cityAreaMap.register("cityAreaMap",this.mapManager)
    this.mapManager.initMaps()
    this.provinces = this.mapManager.getFirstLayer()
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
    this.mapManager = undefined
  }
}