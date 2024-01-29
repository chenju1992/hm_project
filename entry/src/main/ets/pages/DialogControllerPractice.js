import promptAction from '@ohos.promptAction';
import { provinceCityAreaMaps } from '../models/ProvinceCityMap';
import { CustomDialogExample } from '../views/CustomDialogExample';
struct CustomDialogUser extends   {
    constructor() { }
    setProvinceList() {
        this.provinces = provinceCityAreaMaps.map(province => { return province.name; });
    }
    setCityList() {
        if (!!(this.selectedProvince)) {
            this.cities = provinceCityAreaMaps.filter(item => item.name === this.selectedProvince)[0].city
                .map(item => { return item.name; });
        }
    }
    setAreaList() {
        if (!!(this.selectedCity && this.selectedProvince)) {
            this.areas = provinceCityAreaMaps.filter(item => item.name === this.selectedProvince)[0].city
                .filter(city => city.name === this.selectedCity)[0].area;
        }
    }
    displayResult() {
        if (!!(this.selectedProvince && this.selectedCity && this.selectedArea)) {
            promptAction.showToast({
                message: `${this.selectedProvince}-${this.selectedCity}-${this.selectedArea}`
            });
        }
    }
    onCancel() {
        console.info('Callback when the first button is clicked');
    }
    onAccept() {
        console.info('Callback when the second button is clicked');
    }
    existApp() {
        console.info('Click the callback in the blank area');
    }
    aboutToAppear() {
        this.setProvinceList();
    }
    build() {
        .width('100%').margin({ top: 5 });
    }
    // 在自定义组件即将析构销毁时将dialogController置空
    aboutToDisappear() {
        this.provinceDialogController = undefined;
        this.cityDialogController = undefined;
        this.areaDialogController = undefined;
    }
}
//# sourceMappingURL=DialogControllerPractice.js.map