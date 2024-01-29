"use strict";
struct BarrageExample extends   {
    constructor() { }
    startScroll(start, end) {
        this.timer = setInterval(() => {
            this.xOffset = (this.xOffset * 10 + 4) / 10;
            this.scroller.scrollTo({ x: this.xOffset, y: 0 });
        }, 1000 / 60);
    }
    stopScroll() {
        clearInterval(this.timer);
    }
    build() {
        .width('100%');
    }
}
//# sourceMappingURL=barrageExample.js.map