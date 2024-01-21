import { AbstractMapClass } from './AbstractMapClass'
export class MapManager{

  keyList: Array<string> = new Array()
  valueList: Array<AbstractMapClass> = new Array()
  cursor: number = -1

  get(name:string):AbstractMapClass{
    if(this.keyList.indexOf(name) !== -1){
      return this.valueList[this.keyList.indexOf(name)]
    }
    return undefined
  }

  set(name:string,value:AbstractMapClass):void{
    this.keyList.push(name)
    this.valueList.push(value)
    return
  }

  initMaps():void{
    for(let i = 0; i < this.valueList.length; i++){
      this.valueList[i].init()
    }
  }

  getFirstLayer():Array<string>{
    if(this.keyList.length > 0){
      return this.valueList[0].getKeyList()
    }
    return undefined
  }

  getNextLayer(map:string,selectedCandidate:string):Array<string>{
    return this.get(map).getValueAccordingToKey(selectedCandidate)
  }

}