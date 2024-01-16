export abstract class BaseHand{

  date : Date
  currentAngle: number = 0
  renderPeriod: number = -1


  getCurrentAngle():number{
    return this.currentAngle;
  }

  abstract setCurrentAngle(date:Date)


  abstract renderHand(renderPeriod : number):void
















}