export class ProgressBarData{

  totalProgress:number
  currentProgress:number

  getTotalProgress(){
    return this.totalProgress
  }

  getCurrentProgress(){
    return this.currentProgress
  }


  setTotalProgress(totalProgress:number){
    this.totalProgress = totalProgress
  }

  setCurrentProgress(currentProgress:number){
    this.currentProgress = currentProgress
  }


}