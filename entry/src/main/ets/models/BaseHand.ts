abstract class BaseHand{

  date : Date
  currentAngle: number = 0
  renderPeriod: number = -1


  getCurrentAngle():number{
    return this.currentAngle;
  }

  abstract setCurrentAngle(date:Date)

  getRenderPeriod():number{
    return this.renderPeriod;
  }

  setRenderPeriod(renderPeriod : number):void{
    this.renderPeriod = renderPeriod
  }

  abstract renderHand(renderPeriod : number):void














}