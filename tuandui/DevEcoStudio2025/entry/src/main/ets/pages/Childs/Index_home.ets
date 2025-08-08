// 旧版本鸿蒙不需要显式导入ArkUI基础组件
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
  jifen: string;
  vipLevel: number;
  stock: boolean;
  dizhi: string;
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
struct Index_home {
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
    jifen: '',
    vipLevel: 0,
    stock: false,
    dizhi: '',
    dh: 0
  };

  private request: http.HttpRequest | null = null;

  build() {
    Column({ space: 20 }) {
      // 顶部导航栏
      Row({ space: 10 }) {
        Text('本地生活-一站式服务直达')
          .fontColor('#FFFFFF')
          .fontWeight(800)
          .fontSize(15);
      }
      .margin({ top: -40 })
      .width('100%')
      .height(40)
      .backgroundColor('#FFA500')
      .justifyContent(FlexAlign.Center);

      // 公告栏
      Row({ space: 10 }) {
        Text('公告：本地生活的服务时间根据服务类型会有差异！请知悉！')
          .fontSize(12)
          .fontColor('#999999');
      }
      .width('100%')
      .height(30)
      .padding({ left: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F5F5F5');

      // 小TA信息栏（展示后端数据）
      Row({ space: 10 }) {
        Image('https://via.placeholder.com/50')
          .width(50)
          .height(50)
          .borderRadius(25);
        Column({ space: 5 }) {
          Text(this.item.name)  // 渲染name字段
            .fontSize(16)
            .fontWeight(700);
          Row({ space: 10 }) {
            Text(`红包 ${this.item.mani}`)     // 渲染mani字段
              .fontSize(12)
              .fontColor('#FFA500');
            Text(`卡卷 ${this.item.kajuan}`)   // 渲染kajuan字段
              .fontSize(12)
              .fontColor('#FFA500');
            Text(`积分 ${this.item.jifen}`)    // 渲染jifen字段
              .fontSize(12)
              .fontColor('#FFA500');
          }
        }
        .margin({ left: 10 });
        Text('签到领5元红包')
          .fontSize(12)
          .fontColor('#FFA500')
          .backgroundColor('#FFF0E6')
          .padding({ left: 5, right: 5, top: 2, bottom: 2 })
          .borderRadius(5)
          .margin({ left: 'auto', right: 10 });
      }
      .width('100%')
      .height(70)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid });

      // 最新通知栏
      Row({ space: 10 }) {
        Text('最新')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#FFA500')
          .padding({ left: 5, right: 5, top: 2, bottom: 2 })
          .borderRadius(3);
        Text('11111111111111111')
          .fontSize(14)
          .margin({ left: 10 });
        Text('>')
          .fontSize(14)
          .margin({ left: 'auto' });
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid });

      // 广告栏
      Image($r('app.media.chaoji'))
        .width('100%')
        .height(150);

      // 常用服务栏
      Row({ space: 10 }) {
        Text('常用服务')
          .fontSize(16)
          .fontWeight(700);
        Text('更多')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 'auto' });
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid });

      // 常用服务按钮区
      Row({ space: 10 }) {
        Column({ space: 5 }) {
          Image($r('app.media.wentichaoshi'))
            .width(50)
            .height(50)
            .backgroundColor('#FFF58B')
            .padding(9);
          Text('便利超市')
            .fontSize(12)
            .margin({ top: 5 });
        }
        Column({ space: 5 }) {
          Image($r('app.media.gouwuche'))
            .width(50)
            .height(50)
            .backgroundColor('#DAF6F3')
            .padding(9);
          Text('小区团购')
            .fontSize(12)
            .margin({ top: 5 });
        }
        Column({ space: 5 }) {
          Image($r('app.media.dg'))
            .width(50)
            .height(50)
            .backgroundColor('#E0D9D5')
            .padding(9);
          Text('蛋糕烘焙')
            .fontSize(12)
            .margin({ top: 5 });
        }
        Column({ space: 5 }) {
          Image($r('app.media.jz'))
            .width(50)
            .height(50)
            .backgroundColor('#FFE9E9')
            .padding(9);
          Text('家政清洁')
            .fontSize(12)
            .margin({ top: 5 });
        }
        Column({ space: 5 }) {
          Image($r('app.media.shenghuo'))
            .width(50)
            .height(50)
            .backgroundColor('#E8E8E8')
            .padding(9);
          Text('保养干洗')
            .fontSize(12)
            .margin({ top: 5 });
        }
      }
      .width('100%')
      .height(80)
      .padding({ left: 10, right: 10 })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF');

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }


  private async get() {
    try {
      const request: http.HttpRequest = http.createHttp();  // 显式声明类型
      this.request = request;

      // 声明响应类型，避免any
      const response: HttpResponse<ApiResponse> = await request.request(
        'http://192.168.176.89:3001/ljl/get',
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
              jifen: firstItem.jifen || '',
              vipLevel: firstItem.vipLevel || 0,
              stock: firstItem.stock || false,
              dizhi: firstItem.dizhi || '',
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

export default Index_home;
