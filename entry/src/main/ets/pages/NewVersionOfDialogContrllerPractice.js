import promptAction from '@ohos.promptAction';
import { CustomDialogExample } from '../views/CustomDialogExample';
import { ProvinceCityMapClass } from '../models/ProvinceCityMapClass';
import { CityAreaMapClass } from '../models/CityAreaMapClass';
import { MapManager } from '../models/MapManager';
struct CustomDialogUser extends   {
    constructor() { }
    displayResult() {
        if (!!(this.selectedProvince && this.selectedCity && this.selectedArea)) {
            promptAction.showToast({
                message: `${this.selectedProvince}-${this.selectedCity}-${this.selectedArea}`
            });
        }
    }
    aboutToAppear() {
        this.mapManager = new MapManager();
        let provinceCityMap = new ProvinceCityMapClass();
        let cityAreaMap = new CityAreaMapClass();
        provinceCityMap.register("provinceCityMap", this.mapManager);
        cityAreaMap.register("cityAreaMap", this.mapManager);
        this.mapManager.initMaps();
        this.provinces = this.mapManager.getFirstLayer();
    }
    build() {
        .width('100%').margin({ top: 5 });
    }
    // 在自定义组件即将析构销毁时将dialogController置空
    aboutToDisappear() {
        this.provinceDialogController = undefined;
        this.cityDialogController = undefined;
        this.areaDialogController = undefined;
        this.mapManager = undefined;
        this.provinces = undefined;
        this.cities = undefined;
        this.areas = undefined;
        this.selectedProvince = undefined;
        this.selectedCity = undefined;
        this.selectedArea = undefined;
    }
}
//# sourceMappingURL=NewVersionOfDialogContrllerPractice.js.map