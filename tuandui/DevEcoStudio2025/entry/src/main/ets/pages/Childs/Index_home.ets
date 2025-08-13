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
  code: number | string; // 兼容数字/字符串类型的code
  data: ListItem[];
  message?: string; // 新增：接收后端可能返回的消息提示
}

interface HttpResponse<T> {
  responseCode: number;
  result: string;
}

interface RequestError {
  message?: string;
  code?: number;
  stack?: string;
}

@Entry
@Component
struct  Index_home
{
  private readonly DOMAIN: number = 0x00001;
  private readonly TAG: string = 'Index_home'

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
            Text(`积分 ${this.item.score}`)    // 渲染jifen字段
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

      Column({ space: 5 }) {
        Row({ space: 5 }) {
          Text('今日生活')
            .fontSize(16)
            .fontWeight(700);
          Text('6')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .backgroundColor('#FFA500')
            .padding({ left: 5, right: 5, top: 2, bottom: 2 })
            .borderRadius(3);
        }
        Column({ space: 3 }) {
          Text('○ 【小区团购】商品已经到货，预计明天送达！')
            .fontSize(12)
            .fontColor('#333333');
          Text('○ 【家政清洁】您预约的服务明天上门！')
            .fontSize(12)
            .fontColor('#333333');
          Text('○ 【蛋糕烘焙】您预定的蛋糕预计今天送达！')
            .fontSize(12)
            .fontColor('#333333');
        }
      }

      .alignItems(HorizontalAlign.Start);

      Row({ space: 10 }) {
        Text('最新')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#FFA500')
          .padding({ left: 5, right: 5, top: 2, bottom: 2 })
          .borderRadius(3)

        Text('关于2019年12月22日14:00-15:00小区3栋、4栋、5栋紧急停水的通知')
          .fontSize(14)
          .flexGrow(1) // 让文本占满剩余空间，超出省略
          .textOverflow({ overflow: TextOverflow.Ellipsis })


        Text('>')
          .fontSize(14)
          .margin({ right: 10 })
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid })
      .margin({ top: 10 })

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
      const request: http.HttpRequest = http.createHttp();
      this.request = request;

      const url = 'http://localhost:3001/ljl/get';
      hilog.info(this.DOMAIN, this.TAG, `请求地址: ${url}`);

      const response: HttpResponse<ApiResponse> = await request.request(
        url,
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
          const apiResponse: ApiResponse = JSON.parse(result) as ApiResponse;
          // 转换code为数字，避免类型问题
          const code = Number(apiResponse.code);

          // 打印完整的解析后数据，重点关注data字段
          hilog.info(this.DOMAIN, this.TAG,
            `解析后响应: code=${code}, data类型=${typeof apiResponse.data}, data长度=${apiResponse.data?.length || '空'}, 后端消息=${apiResponse.message || '无'}`);

          // 严格校验data是否为有效的非空数组
          if (code === 200) {
            if (Array.isArray(apiResponse.data)) {
              if (apiResponse.data.length > 0) {
                // 数据正常，更新item
                const firstItem = apiResponse.data[0];
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
                hilog.info(this.DOMAIN, this.TAG, `数据更新成功: ${JSON.stringify(this.item.name)}`);
              } else {
                // data是数组但为空
                this.item.name = '暂无数据（后端返回空列表）';
                hilog.warn(this.DOMAIN, this.TAG, `API返回空数组: code=${code}`);
              }
            } else {
              // data不是数组（格式错误）
              this.item.name = '数据格式错误（非数组）';
              hilog.error(this.DOMAIN, this.TAG, `API返回的data不是数组: ${typeof apiResponse.data}`);
            }
          } else {
            // code不是200（后端返回错误状态）
            this.item.name = `服务器返回错误: ${apiResponse.message || `code=${code}`}`;
            hilog.warn(this.DOMAIN, this.TAG, `API返回非200状态: code=${code}`);
          }
        } catch (jsonError) {
          const error = jsonError as RequestError;
          hilog.error(this.DOMAIN, this.TAG, `JSON解析错误: ${error.message || ''}, 堆栈: ${error.stack || ''}`);
          this.item.name = '数据解析失败';
        }
      } else {
        hilog.error(this.DOMAIN, this.TAG, `HTTP错误: ${response.responseCode}`);
        this.item.name = `请求失败: ${response.responseCode}`;
      }
    } catch (err) {
      const error = err as RequestError;
      hilog.error(this.DOMAIN, this.TAG, `网络错误: ${error.message || '未知错误'}, 堆栈: ${error.stack || ''}`);
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

export default Index_home;
