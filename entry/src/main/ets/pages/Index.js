struct Index extends   {
    constructor() { }
    degreeToRadius(angleInDegree) {
        const ONE_DEGREE_IN_RADIUS = Math.PI / 180;
        return angleInDegree * ONE_DEGREE_IN_RADIUS;
    }
    calculateRotateAngle(currentTime) {
        const TOTAL_SECONDS_IN_ONE_HOUR = 3600;
        const TOTAL_SECONDS_IN_ONE_MINUTE = 60;
        const TOTAL_DEGREE_SECOND_HAND_ROTATE_IN_ONE_SECOND = 6;
        const TOTAL_DEGREE_MINUTE_HAND_ROTATE_IN_ONE_SECOND = 6 / 60;
        const TOTAL_DEGREE_HOUR_HAND_ROTATE_IN_ONE_SECOND = 6 / 60 / (60 / 5);
        const hour = currentTime.getHours();
        const minute = currentTime.getMinutes();
        const second = currentTime.getSeconds();
        const totalSecond = hour * TOTAL_SECONDS_IN_ONE_HOUR + minute * TOTAL_SECONDS_IN_ONE_MINUTE + second;
        const minSecond = (totalSecond) % TOTAL_SECONDS_IN_ONE_MINUTE === 0 ? totalSecond : totalSecond - totalSecond % TOTAL_SECONDS_IN_ONE_MINUTE;
        const secondAngle = this.degreeToRadius(totalSecond * TOTAL_DEGREE_SECOND_HAND_ROTATE_IN_ONE_SECOND);
        const minuteAngle = this.degreeToRadius((this.isMinuteHandMovingEveryMinute ? minSecond : totalSecond) * TOTAL_DEGREE_MINUTE_HAND_ROTATE_IN_ONE_SECOND);
        const hourAngle = this.degreeToRadius(totalSecond * TOTAL_DEGREE_HOUR_HAND_ROTATE_IN_ONE_SECOND);
        return [hourAngle, minuteAngle, secondAngle];
    }
    drawDial(image) {
        this.context.save();
        this.context.drawImage(image, this.startX, this.startY, this.clockSize, this.clockSize);
        this.context.restore();
    }
    drawHand(image, angleInRadius) {
        this.context.save();
        this.context.translate(this.startX + this.clockSize / 2, this.startY + this.clockSize / 2);
        this.context.rotate(this.degreeToRadius(180) + angleInRadius);
        this.context.translate(-(this.startX + this.clockSize / 2), -(this.startY + this.clockSize / 2));
        this.context.drawImage(image, this.startX + this.clockSize / 2 - this.handWidth / 2, this.startY, this.handWidth, this.handHeight);
        this.context.restore();
    }
    drawClock() {
        const currentTime = new Date();
        const anglesInRadius = this.calculateRotateAngle(currentTime);
        this.drawDial(this.dial);
        this.drawHand(this.hourHand, anglesInRadius[0]);
        this.drawHand(this.minuteHand, anglesInRadius[1]);
        this.drawHand(this.secondHand, anglesInRadius[2]);
    }
    drawClockEverySeconds() {
        this.timer = setInterval(() => {
            this.context.clearRect(this.startX, this.startY, this.clockSize, this.clockSize);
            this.drawClock();
        }, 1000);
    }
    build() {
        ;
    }
    aboutToDisappear() {
        clearInterval(this.timer);
    }
}
export {};
//# sourceMappingURL=Index.js.map