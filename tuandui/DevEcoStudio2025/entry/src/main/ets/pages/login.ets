
import http from '@ohos.net.http';
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';
import preferences from '@system.storage'
import router from '@ohos.router'

interface LoginData {
  username: string;
  password: string;
  _id: string;
  mani: number;
  kajuan: string;
  score: number;
  vipLevel: number;
  stock: boolean;
  dizhi: string;
  dh:number;
}
interface ApiResponse {
  code: number;
  data?: LoginData;
  message?: string;
}
interface LoginRequest {
  username: string
  password: string
}
@Entry

@Component
struct Login { // 组件名建议 PascalCase（如 Login 而非 login）
  @State username: string = '';
  @State password: string = '';

  private readonly DOMAIN: number = 0x00001;
  private readonly TAG: string = 'LoginPage';

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
          this.handleLogin()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')

  }

  private request: http.HttpRequest | null = null
  private handleLogin(){

    if(!this.username||!this.password){
      promptAction.showToast({message:'请输入完整信息', duration: 2000 })
      return
    }
    // 示例：校验用户名长度
    if (this.username.length < 4 || this.username.length > 20) {
      AlertDialog.show({ message: '用户名需为4-20位字符'})
      return
    }
    // 示例：密码复杂度校验
    if (!/^(?=.*[A-Za-z])(?=.*\d).{8,}$/.test(this.password)) {
      AlertDialog.show({ message: '密码需至少8位且包含字母数字'})
      return
    }
    this.request = http.createHttp()
    let url = 'http://localhost:3001/ljl/login'
    const params: LoginRequest = { // 使用定义好的接口类型
      username: this.username,
      password: this.password
    }
    this.request.request(
      url,
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json' // 明确指定数据格式
        },
        extraData: params // 注入请求参数
      },

      (err, data: http.HttpResponse) => {
        const resultObj :ApiResponse = JSON.parse(data.result.toString());
        const ress = data.result as ApiResponse;
          if (ress.code === 200) {
            AlertDialog.show({'message':'成功'})
          } else {
            AlertDialog.show({'message':'22'})
            router.pushUrl({
              url: 'pages/Index',
              params: { targetTabIndex: 4 }
            })

          }
        }

    )
  }

  aboutToDisappear() {
    if (this.request) {
      this.request.destroy()
      this.request = null
    }
  }
}

export default Login;
