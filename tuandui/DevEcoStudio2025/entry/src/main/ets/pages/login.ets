
import router from '@ohos.router'
@Entry

@Component
struct login {
  @State username: string = ''
  @State password: string = ''

  build() {
    Column({ space: 20 }) {
      Row({ space: 10 }) {
        Text('本地生活-一站式推送')
          .fontColor("#FFFFFF")
          .fontWeight(800)
          .fontSize(17)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FFA500')
      .margin({top:-39})
      .borderWidth(2)
      .borderColor('#FFA500')

      Image($r("app.media.logoLE"))
        .width(190)


      TextInput({ placeholder: '请输入用户名' })
        .width('80%')
        .height(40)
        .borderRadius(8)
        .backgroundColor(Color.White)
        .onChange((value: string) => {
          this.username = value
        })

      TextInput({ placeholder: '请输入密码' })
        .width('80%')
        .height(40)
        .type(InputType.Password)
        .borderRadius(8)
        .backgroundColor(Color.White)
        .onChange((value: string) => {
          this.password = value
        })

      Button('登录', { type: ButtonType.Capsule })
        .width('60%')
        .height(40)
        .backgroundColor('#007DFF')
        .onClick(() => {
          if (this.username && this.password) {
            router.pushUrl({
              url: 'pages/Index',
              params: { targetTabIndex: 4 }
            })
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
export default login