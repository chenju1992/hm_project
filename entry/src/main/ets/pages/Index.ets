import settings from '@ohos.settings';


@Entry
@Component
struct Index {

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private timer : number = -1
  private isMinuteHandMovingEveryMinute = true;

  private dial : ImageBitmap = new ImageBitmap('images/ic_clock_pan.png')
  private hourHand : ImageBitmap = new ImageBitmap('images/ic_hour_pointer.png')
  private minuteHand : ImageBitmap = new ImageBitmap('images/ic_minute_pointer.png')
  private secondHand : ImageBitmap = new ImageBitmap('images/ic_second_pointer.png')

  startX : number = 50
  startY : number = 100
  clockSize : number = 252
  handHeight : number = 252
  handWidth : number = 8


  degreeToRadius(angleInDegree : number){
    const ONE_DEGREE_IN_RADIUS : number = Math.PI / 180
    return angleInDegree * ONE_DEGREE_IN_RADIUS
  }


  calculateRotateAngle(currentTime:Date): Array<number>{

    const TOTAL_SECONDS_IN_ONE_HOUR : number = 3600
    const TOTAL_SECONDS_IN_ONE_MINUTE : number = 60
    const TOTAL_DEGREE_SECOND_HAND_ROTATE_IN_ONE_SECOND : number = 6
    const TOTAL_DEGREE_MINUTE_HAND_ROTATE_IN_ONE_SECOND : number = 6 / 60
    const TOTAL_DEGREE_HOUR_HAND_ROTATE_IN_ONE_SECOND : number = 6 / 60 / (60 / 5)

    const hour : number = currentTime.getHours()
    const minute : number = currentTime.getMinutes()
    const second : number = currentTime.getSeconds()

    const totalSecond : number = hour * TOTAL_SECONDS_IN_ONE_HOUR + minute * TOTAL_SECONDS_IN_ONE_MINUTE + second
    const minSecond :   number = (totalSecond) % TOTAL_SECONDS_IN_ONE_MINUTE === 0 ? totalSecond : totalSecond - totalSecond % TOTAL_SECONDS_IN_ONE_MINUTE
    const secondAngle : number = this.degreeToRadius(totalSecond * TOTAL_DEGREE_SECOND_HAND_ROTATE_IN_ONE_SECOND)
    const minuteAngle : number = this.degreeToRadius((this.isMinuteHandMovingEveryMinute ? minSecond : totalSecond) * TOTAL_DEGREE_MINUTE_HAND_ROTATE_IN_ONE_SECOND)
    const hourAngle :   number = this.degreeToRadius(totalSecond * TOTAL_DEGREE_HOUR_HAND_ROTATE_IN_ONE_SECOND)

    return [hourAngle, minuteAngle, secondAngle]
  }

  drawDial(image:ImageBitmap){
    this.context.save()
    this.context.drawImage(image,this.startX,this.startY,this.clockSize,this.clockSize)
    this.context.restore()
  }



  drawHand(image:ImageBitmap, angleInRadius : number){
    this.context.save()
    this.context.translate(this.startX + this.clockSize / 2, this.startY + this.clockSize / 2)
    this.context.rotate(this.degreeToRadius(180) + angleInRadius)
    this.context.translate(-(this.startX + this.clockSize / 2), -(this.startY + this.clockSize / 2))
    this.context.drawImage(image,this.startX + this.clockSize / 2 - this.handWidth / 2 ,this.startY,this.handWidth,this.handHeight)
    this.context.restore()
  }

  drawClock(){
    const currentTime :Date = new Date()
    const anglesInRadius :Array<number> = this.calculateRotateAngle(currentTime)
    this.drawDial(this.dial)
    this.drawHand(this.hourHand,anglesInRadius[0])
    this.drawHand(this.minuteHand,anglesInRadius[1])
    this.drawHand(this.secondHand,anglesInRadius[2])
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
