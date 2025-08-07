import http from '@ohos.net.http';
import { BusinessError } from '@kit.BasicServicesKit';
import promptAction from '@ohos.promptAction';

// 修正接口名与规范
interface LoginData {
  username: string;
  password: string;
  _id: string;
  mani: string;
  kajuan: string;
  jifen: string;
  vip: string;
  stock: string;
  dizhi: string;
}

@Entry
@Component
struct Login { // 组件名建议 PascalCase（如 Login 而非 login）
  @State username: string = '';
  @State password: string = '';

  build() {
    // ... 原 UI 逻辑（注意 Text 等组件属性保持鸿蒙语法正确）
  }

  loginRequest() {
    const url = 'http://localhost:3000/list/login';
    const requestConfig: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: {
        username: this.username,
        password: this.password
      }


    }
    // request.request(url, requestConfig).then((res: http.HttpResponse) => {
    //   // 处理响应逻辑
    //   if (res.responseCode === 200) {
    //     let result = JSON.parse(res.result.toString());
    //     console.info('Response data:', result);
    //   }
    // }).catch((err: BusinessError) => {
    //   console.error('请求失败:', err.code, err.message);
    // });



    let httpRequest = http.createHttp();
    httpRequest.request(url, requestConfig).then((result) => {
      // 原来的成功回调逻辑
      if (result.responseCode === 200) {
        // 注意：这里 result.result 类型可能是 string | Object | ArrayBuffer ，要处理类型断言
        let resultStr = typeof result.result === 'string' ? result.result : JSON.stringify(result.result);
        let resultData = JSON.parse(resultStr) as LoginData;
        console.info('Login success:', resultData);
      } else {
        console.error('Login failed:', result.responseCode);
      }
    }).catch((err: BusinessError) => {
      // 原来的失败回调逻辑
      console.error('Request error:', err.code, err.message);
    });
  }
}

export default Login;