@Entry
@Component
struct textInputPractice {

  @State text: string = ''
  controller : TextInputController = new TextInputController()


  build() {
    Column(){
      TextInput({text : this.text,placeholder: "input your word...", controller: this.controller})
        .placeholderColor(Color.Gray)
        .placeholderFont({size: 14, weight: 400} as Font)
        .width(400)
        .height(40)
        .margin(20)
        .fontSize(14)
        .onChange((value:string) =>{
          this.text = value
        })
      Text(this.text)
    }
  }
}