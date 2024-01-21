import {AbstractMapClass} from "./AbstractMapClass"
import {CITY_LIST} from "./Cities"
import  {AREA_LIST} from "./Areas"

export class CityAreaMapClass extends AbstractMapClass{

  keyList : string[] = []
  valueList : Array<Array<string>> = new Array<Array<string>>()
  private cities : string[] = CITY_LIST.map(item=>item.name)
  private cityIndexes: string[] = CITY_LIST.map(item => item.code)

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
    this.keyList = this.cities
    return this
  }

  setValueList() {
    for (let i = 0; i < this.cities.length; i++) {
      let cityIndex = this.cityIndexes[i]
      let cityCode = CITY_LIST.filter(item =>{return item.code === cityIndex})[0].code
      let values = AREA_LIST.filter(item => item.cityCode === cityCode).map(item => item.name)
      this.valueList.push(values)
      //console.log(JSON.stringify(values));
    }
    return this
  }

  getValueAccordingToKey(key:string){
    let cityIndex = this.cities.indexOf(key)
    return this.valueList[cityIndex]
  }

  init(){
    this.setKeyList()
    this.setValueList()
  }






}