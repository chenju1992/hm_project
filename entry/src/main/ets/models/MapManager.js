export class MapManager {
    constructor() {
        this.keyList = new Array();
        this.valueList = new Array();
        this.cursor = -1;
    }
    get(name) {
        if (this.keyList.indexOf(name) !== -1) {
            return this.valueList[this.keyList.indexOf(name)];
        }
        return undefined;
    }
    set(name, value) {
        this.keyList.push(name);
        this.valueList.push(value);
        return;
    }
    initMaps() {
        for (let i = 0; i < this.valueList.length; i++) {
            this.valueList[i].init();
        }
    }
    getFirstLayer() {
        if (this.keyList.length > 0) {
            return this.valueList[0].getKeyList();
        }
        return undefined;
    }
    getNextLayer(map, selectedCandidate) {
        return this.get(map).getValueAccordingToKey(selectedCandidate);
    }
}
//# sourceMappingURL=MapManager.js.map