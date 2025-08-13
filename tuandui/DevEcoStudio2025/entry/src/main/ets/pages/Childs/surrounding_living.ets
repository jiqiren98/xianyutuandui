import router from '@ohos.router';
import http from '@ohos.net.http';
import hilog from '@ohos.hilog';

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

interface ApiResponse {
  code: number | string;
  data: ListItem[];
  message?: string;
}

@Entry
@Component
struct PersonalCenter {
  private readonly DOMAIN: number = 0x00001;
  private readonly TAG: string = 'PersonalCenter';

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
      // 标题栏
      Row() {
        Text('个人中心')
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
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
        Image('https://via.placeholder.com/60')
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

      // 会员信息区
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
      .border({ width: 1, color: '#EEEEEE' })

      // 红包卡券积分区
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

      // 功能列表区
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
      const request = http.createHttp();
      this.request = request;
      const url = 'http://localhost:3001/ljl/get';
      hilog.info(this.DOMAIN, this.TAG, `请求地址: ${url}`);

      const response = await request.request(url, {
        method: http.RequestMethod.GET,
        connectTimeout: 10000,
        readTimeout: 10000
      });

      hilog.info(this.DOMAIN, this.TAG, `HTTP响应码: ${response.responseCode}`);

      if (response.responseCode === http.ResponseCode.OK) {
        const result = response.result.toString();
        hilog.info(this.DOMAIN, this.TAG, `原始响应数据: ${result}`);

        try {
          const apiResponse: ApiResponse = JSON.parse(result);
          const code = Number(apiResponse.code);

          hilog.info(this.DOMAIN, this.TAG,
            `解析后响应: code=${code}, data类型=${typeof apiResponse.data}, data长度=${apiResponse.data?.length || '空'}`);

          if (code === 200) {
            if (Array.isArray(apiResponse.data)) {
              if (apiResponse.data.length > 0) {
                const firstItem = apiResponse.data[0];
                this.item = {
                  username: firstItem.username || '',
                  password: firstItem.password || '',
                  _id: firstItem._id || '',
                  mani: firstItem.mani ?? 0, // 使用空值合并运算符处理数字类型
                  name: firstItem.name || '未命名',
                  kajuan: firstItem.kajuan || '',
                  score: firstItem.score ?? 0,
                  vipLevel: firstItem.vipLevel ?? 0,
                  stock: firstItem.stock ?? false, // 处理布尔类型
                  dh: firstItem.dh ?? 0
                } as ListItem; // 显式类型断言确保类型匹配
                hilog.info(this.DOMAIN, this.TAG, `数据更新成功: ${this.item.name}`);
              } else {
                this.item.name = '暂无数据（后端返回空列表）';
                hilog.warn(this.DOMAIN, this.TAG, `API返回空数组`);
              }
            } else {
              this.item.name = '数据格式错误（非数组）';
              hilog.error(this.DOMAIN, this.TAG, `data不是数组: ${typeof apiResponse.data}`);
            }
          } else {
            this.item.name = `服务器错误: ${apiResponse.message || code}`;
            hilog.warn(this.DOMAIN, this.TAG, `API返回非200状态: ${code}`);
          }
        } catch (error) {
          hilog.error(this.DOMAIN, this.TAG, `JSON解析错误: ${(error as Error).message}`);
          this.item.name = '数据解析失败';
        }
      } else {
        hilog.error(this.DOMAIN, this.TAG, `HTTP错误: ${response.responseCode}`);
        this.item.name = `请求失败: ${response.responseCode}`;
      }
    } catch (error) {
      hilog.error(this.DOMAIN, this.TAG, `网络错误: ${(error as Error).message}`);
      this.item.name = '网络连接失败';
    } finally {
      this.request?.destroy();
      this.request = null;
    }
  }

  aboutToAppear() {
    this.get();
  }

  aboutToDisappear() {
    this.request?.destroy();
    this.request = null;
  }
}

export default PersonalCenter;
