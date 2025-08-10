import router from '@ohos.router';

import http from '@ohos.net.http';
import hilog from '@ohos.hilog';

// 定义数据项接口 - 合并重复接口，保持唯一性
interface ListItem {
  username: string;
  password: string;
  _id: string;
  mani: number;
  name: string;
  kajuan: string;
  score: number;
  vipLevel: number;
  stock: boolean;
  dh: number;
}

// 正确的API响应结构 - 匹配实际返回数据
interface ApiResponse {
  code: number;
  data: ListItem[];
}

// HTTP响应类型
interface HttpResponse<T> {
  responseCode: number;
  result: string;
}

// 错误信息接口
interface RequestError {
  message?: string;
  code?: number;
}



  @Entry
  @Component
  struct PersonalCenter {
  private readonly DOMAIN: number = 0x00001;
  private readonly TAG: string = 'HomePage';

  @State message: string = 'Home';
  @State private item: ListItem = {
    username: '',
    password: '',
    _id: '',
    mani: 0,
    name: '加载中...',
    kajuan: '',
    score: 0,

    vipLevel: 0,
    stock: false,

    dh: 0
  };

  private request: http.HttpRequest | null = null;
  build() {
    Column() {
      Row() {
        Text('个人中心')
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold) // 替换为枚举类型
          .fontSize(17)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FF9800')
      .justifyContent(FlexAlign.Center)

      // 顶部信息区
      Row() {
        Column() {
          Text(this.item.name)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Row() {
            // 星级评分
            Text('★★★★★')
              .fontSize(12)
              .fontColor('#FF9800')
            Text(`会员时长: ${this.item.vipLevel}天`)
              .fontSize(12)
              .margin({ left: 5 })
          }
          .margin({ top: 5 })
          Button('签到领5元红包')
            .fontSize(10)
            .fontColor('#FF9800')
            .backgroundColor('#FFF3E0')
            .padding({ left: 8, right: 8, top: 2, bottom: 2 })
            .borderRadius(5)
            .margin({ top: 5 })
        }
        .margin({ left: 10 })
        Image('https://via.placeholder.com/60') // 替换为实际头像
          .width(60)
          .height(60)
          .borderRadius(30)
          .margin({ left: 'auto', right: 20 })
      }
      .width('100%')
      .height(100)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F5F5F5')

      // 会员信息区（修正边框写法）
      Row() {
        Text('五星会员')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF9800')
        Text('开通后,服务享受95折和3倍积分')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 5 })
        Text('>')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 'auto' })
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE' }) // 统一边框格式

      // 红包卡券积分区（修正边框写法）
      Row() {
        Column() {
          Text(`余额 `)
            .fontSize(12)
            .fontColor('#999999')
          Text(`${this.item.mani}￥`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF5722')

        }
        .width('33.33%')
        .height(80)
        .justifyContent(FlexAlign.Center)

        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE'})

        Column() {
          Text('合作卡券')
            .fontSize(12)
            .fontColor('#999999')
          Text(`${this.item.kajuan}¥`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF5722')

        }
        .width('33.33%')
        .height(80)
        .justifyContent(FlexAlign.Center)

        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE' })

        Column() {
          Text('钱包积分')
            .fontSize(12)
            .fontColor('#999999')
          Text(`${this.item.score}¥`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF5722')

        }
        .width('33.33%')
        .height(80)
        .justifyContent(FlexAlign.Center)

        .backgroundColor('#FFFFFF')
      }
      .width('100%')

      Column() {
        Row() {
          Image('https://via.placeholder.com/20')
            .width(20)
            .height(20)
          Text('我的地址')
            .fontSize(14)
            .margin({ left: 10 })
          Text('>')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ left: 'auto' })
        }
        .width('100%')
        .height(50)
        .padding({ left: 10, right: 10 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE'})

        Row() {
          Image('https://via.placeholder.com/20')
            .width(20)
            .height(20)
          Text('管家消息')
            .fontSize(14)
            .margin({ left: 10 })
          Text('')
            .fontSize(10)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF5722')
            .padding({ left: 5, right: 5, top: 2, bottom: 2 })
            .borderRadius(5)
            .margin({ left: 10 })
          Text('>')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ left: 'auto' })
        }
        .width('100%')
        .height(50)
        .padding({ left: 10, right: 10 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE'})

        Row() {
          Image('https://via.placeholder.com/20')
            .width(20)
            .height(20)
          Text('分享有奖')
            .fontSize(14)
            .margin({ left: 10 })
          Text('>')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ left: 'auto' })
        }
        .width('100%')
        .height(50)
        .padding({ left: 10, right: 10 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE' })

        Row() {
          Image('https://via.placeholder.com/20')
            .width(20)
            .height(20)
          Text('商务合作')
            .fontSize(14)
            .margin({ left: 10 })
          Text('>')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ left: 'auto' })
        }
        .width('100%')
        .height(50)
        .padding({ left: 10, right: 10 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE'})

        Row() {
          Image('https://via.placeholder.com/20')
            .width(20)
            .height(20)
          Text('使用帮助')
            .fontSize(14)
            .margin({ left: 10 })
          Text('>')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ left: 'auto' })
        }
        .width('100%')
        .height(50)
        .padding({ left: 10, right: 10 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  private async get() {
    try {
      const request: http.HttpRequest = http.createHttp();  // 显式声明类型
      this.request = request;

      // 声明响应类型，避免any
      const response: HttpResponse<ApiResponse> = await request.request(
        'http://192.168.176.176:3001/ljl/get',
        {
          method: http.RequestMethod.GET,
          connectTimeout: 10000,
          readTimeout: 10000
        }
      ) as HttpResponse<ApiResponse>;

      hilog.info(this.DOMAIN, this.TAG, `HTTP响应码: ${response.responseCode}`);

      if (response.responseCode === http.ResponseCode.OK) {
        const result = response.result.toString();
        hilog.info(this.DOMAIN, this.TAG, `原始响应数据: ${result}`);

        try {
          // 解析为正确的ApiResponse类型
          const apiResponse: ApiResponse = JSON.parse(result) as ApiResponse;
          hilog.info(this.DOMAIN, this.TAG, `解析后数据: ${JSON.stringify(apiResponse)}`);

          // 检查响应码和数据有效性
          if (apiResponse.code === 200 && apiResponse.data && apiResponse.data.length > 0) {
            const firstItem = apiResponse.data[0];  // 获取第一条数据

            // 修复对象赋值语法错误，正确更新item状态
            this.item = {
              username: firstItem.username || '',
              password: firstItem.password || '',
              _id: firstItem._id || '',
              mani: firstItem.mani || 0,
              name: firstItem.name || '未命名',
              kajuan: firstItem.kajuan || '',
              score: firstItem.score || 0,
              vipLevel: firstItem.vipLevel || 0,
              stock: firstItem.stock || false,
              dh: firstItem.dh || 0
            };

            hilog.info(this.DOMAIN, this.TAG, `更新后的item: ${JSON.stringify(this.item)}`);
          } else {
            this.item.name = apiResponse.code === 200 ? '数据为空' : `服务器错误: ${apiResponse.code}`;
            hilog.warn(this.DOMAIN, this.TAG, `API返回异常: code=${apiResponse.code}`);
          }
        } catch (jsonError) {
          const error = jsonError as RequestError;
          hilog.error(this.DOMAIN, this.TAG, `JSON解析错误: ${error.message}`);
          this.item.name = '数据解析失败';
        }
      } else {
        hilog.error(this.DOMAIN, this.TAG, `HTTP错误: ${response.responseCode}`);
        this.item.name = `请求失败: ${response.responseCode}`;
      }
    } catch (err) {
      const error = err as RequestError;
      hilog.error(this.DOMAIN, this.TAG, `网络错误: ${error.message || '未知错误'}`);
      this.item.name = '网络连接失败';
    } finally {
      this.request?.destroy();
      this.request = null;
    }
  }

  aboutToAppear() {
    this.get();  // 页面加载时请求数据
  }

  aboutToDisappear() {
    this.request?.destroy();  // 页面销毁时清理请求
    this.request = null;
  }

}

export default PersonalCenter;