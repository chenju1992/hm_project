import settings from '@ohos.settings';
@Entry
@Component
struct Index {

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private timer : number = -1

  private dial : ImageBitmap = new ImageBitmap('images/ic_clock_pan.png')
  private hourHand : ImageBitmap = new ImageBitmap('images/ic_hour_pointer.png')
  private minuteHand : ImageBitmap = new ImageBitmap('images/ic_minute_pointer.png')
  private secondHand : ImageBitmap = new ImageBitmap('images/ic_second_pointer.png')

  startX : number = 50
  startY : number = 100
  clockSize : number = 252
  handHeight : number = 252
  handWidth : number = 8
  defaultAngle : number = 180 * Math.PI / 180

   // rotateHandToDefault(){
   //   this.context.save()
   //     this.context.drawImage(this.dial,this.startX,this.startY,this.clockSize,this.clockSize)
   //     this.context.translate(this.startX + this.clockSize / 2, this.startY + this.clockSize / 2)
   //     this.context.rotate(180 * Math.PI / 180)
   //     this.context.translate(-(this.startX + this.clockSize / 2), -(this.startY + this.clockSize / 2))
   //     this.context.drawImage(this.hourHand,this.startX + this.clockSize / 2 - this.handWidth / 2 ,this.startY,this.handWidth,this.handHeight)
   //     this.context.drawImage(this.minuteHand,this.startX + this.clockSize / 2 - this.handWidth / 2 ,this.startY,this.handWidth,this.handHeight)
   //     this.context.drawImage(this.secondHand,this.startX + this.clockSize / 2 - this.handWidth / 2 ,this.startY,this.handWidth,this.handHeight)
   //   this.context.restore()
   // }

  calculateRotateAngle(currentTime:Date): Array<number>{
    const hour : number = currentTime.getHours()
    const minute : number = currentTime.getMinutes()
    const second : number = currentTime.getSeconds()

    const totalSecond : number = hour * 3600 + minute * 60 + second
    const secondAngle : number = ((totalSecond * 6) % 360) * Math.PI / 180
    const minuteAngle : number = ((totalSecond * 6 / 60) % 360) * Math.PI / 180
    const hourAngle : number = (totalSecond * 6 / 720) % 360 * Math.PI / 180

    return [hourAngle, minuteAngle, secondAngle]
  }

  drawDial(image:ImageBitmap){
    this.context.save()
    this.context.drawImage(image,this.startX,this.startY,this.clockSize,this.clockSize)
    this.context.restore()
  }


  drawHand(image:ImageBitmap, angle:number){
    this.context.save()
    this.context.translate(this.startX + this.clockSize / 2, this.startY + this.clockSize / 2)
    this.context.rotate(180 * Math.PI / 180 + angle)
    this.context.translate(-(this.startX + this.clockSize / 2), -(this.startY + this.clockSize / 2))
    this.context.drawImage(image,this.startX + this.clockSize / 2 - this.handWidth / 2 ,this.startY,this.handWidth,this.handHeight)
    this.context.restore()
  }

  drawClock(){
    const currentTime :Date = new Date()
    const angles :Array<number> = this.calculateRotateAngle(currentTime)
    this.drawDial(this.dial)
    this.drawHand(this.hourHand,angles[0])
    this.drawHand(this.minuteHand,angles[1])
    this.drawHand(this.secondHand,angles[2])
  }

  drawClockEverySeconds(){
    this.timer = setInterval(()=>{
      this.context.clearRect(this.startX,this.startY, this.clockSize, this.clockSize)
      this.drawClock()

    },1000)
  }

  build(){
    Column(){
      Row(){
        Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }){
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {this.drawClockEverySeconds()})
        }

      }
    }

  }

  aboutToDisappear(){
    clearInterval(this.timer)
  }

}
