export abstract class AbstractMapClass{

  keyList : string[]
  valueList : Array<Array<string>>

  abstract getKeyList():string[]

  abstract setKeyList()

  abstract getValueList():Array<Array<string>>

  abstract setValueList()

  abstract getValueAccordingToKey(key:string):Array<string>

  abstract init()


}