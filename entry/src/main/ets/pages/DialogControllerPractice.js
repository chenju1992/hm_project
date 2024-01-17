import HashMap from '@ohos.util.HashMap';
struct DialogControllerPractice extends   {
    constructor() { }
    onPageShow() {
        this.hashMap.set("hunan", ["changsha", "zhuzhou", "xiangtan"]);
        this.hashMap.set("guangdong", ["guangzhou", "shenzhen", "zhuhai"]);
    }
    build() {
            .height('100%');
    }
    onPageHide() {
        this.hashMap = null;
    }
}
//# sourceMappingURL=DialogControllerPractice.js.map