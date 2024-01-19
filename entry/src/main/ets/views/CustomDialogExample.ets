@Component
@CustomDialog
export struct CustomDialogExample {
  @Link candidates: string[]
  @Link selectedCandidate: string
  controller: CustomDialogController

  build() {
    Column(){
      ForEach(this.candidates, (candidate)=>{
        Text(candidate).onClick(()=>{
          this.selectedCandidate = candidate
        })
      })
    }
  }
}