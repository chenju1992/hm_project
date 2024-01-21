import {AbstractMapClass} from "./AbstractMapClass"
import {PROVINCE_LIST} from "./Provinces"
import {CITY_LIST} from "./Cities"

export class ProvinceCityMapClass extends AbstractMapClass{

  keyList: string[] = []
  valueList: Array<Array<string>> = new Array<Array<string>>()
  private provinces = PROVINCE_LIST.map((item)=>{return item.name})
  private provinceIndexes = PROVINCE_LIST.map((item)=>{return item.code})

  getKeyList(){
    if(this.keyList.length === 0){
      this.setKeyList()
    }
    return this.keyList
  }
  getValueList(){
    if(this.valueList.length === 0){
      this.setValueList()
    }
      return this.valueList
  }
  setKeyList(){
    for(let province of PROVINCE_LIST){
      this.keyList.push(province.name);
    }
    return this
  }

  setValueList(){
    for(let i = 0; i < this.provinces.length; i++){
        let keyToCities = this.provinceIndexes[i]
        let cityListForProvince : string[] = CITY_LIST.filter((item)=>{return item.provinceCode === keyToCities})
                                             .map((item)=>{return item.name})
        this.valueList.push(cityListForProvince)
    }
    return this
  }

  getValueAccordingToKey(key:string){
    const index = this.keyList.indexOf(key)
    return this.valueList[index]
  }

  init(){
    this.setKeyList()
    this.setValueList()
  }

}