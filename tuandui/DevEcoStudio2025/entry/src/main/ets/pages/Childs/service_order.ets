import router from '@ohos.router';
import http from '@ohos.net.http';


interface ApiResponse<T> {
  success: boolean;
  count: number;
  data: T[];
}

interface Product {
  _id: string;
  name: string;
  count: number;
  price: number;
  image: string;
}

interface OrderItem {
  icon?: Resource
  _id: string;
  status: '进行中' | '已完成' | '已取消' | '待支付' | '已退款';
  userInfo?: string;
  deliveryAddress?: string;
  orderTime: string;
  orderRemark?: string;
  products?: Product[];
  totalCount: number;
  totalPrice: number;
  cancelBtnVisible?: boolean;
  from: string;
}

@Entry
@Component
struct service_order {
  @State message: string = 'service_order';
  private request: http.HttpRequest | null = null;
  @State res: http.HttpRequest | null = null;
  @State img: Resource[] = [
    $r('app.media.icon03'), $r('app.media.icon02'), $r('app.media.icon01'),
    $r('app.media.hand'), $r('app.media.icon04')
  ];
  @State order_run: number = 0;
  @State orders: OrderItem[] = [];

  aboutToDisappear() {
    if (this.request) {
      this.request.destroy();
      this.request = null;
    }
  }
  aboutToAppear() {
    this.loadOrders();
    console.log('111')
  }
  public refreshOrders() {
    this.loadOrders();
    console.log('刷新了')
  }
  onPageShow() {
    this.loadOrders(); // 重新请求数据
    console.log('触发')
  }
  time_filter (isoTime:string){
    const date = new Date(isoTime);

    // 转换为北京时间（UTC+8）
    const year = date.getUTCFullYear();
    const month = date.getUTCMonth() + 1; // 月份从 0 开始，需 +1
    let day = date.getUTCDate();
    let hours = date.getUTCHours() + 8; // 北京时间 = UTC 时间 + 8 小时

    // 处理跨天情况（如 UTC 23:00 +8 = 次日 07:00）
    if (hours >= 24) {
      hours -= 24;
      day += 1; // 需额外处理月份天数，简化场景可省略
    }

    // 补零格式化（如 1 → "01"）
    const formatNumber = (num: number) => num.toString().padStart(2, '0');

    const beijingTime = `${year}-${formatNumber(month)}-${formatNumber(day)} ${formatNumber(hours)}:${formatNumber(date.getUTCMinutes())}`;
    console.log('北京时间：', beijingTime); // 输出：2024-08-08 17:30
    return beijingTime
  }

  async loadOrders() {
    let request: http.HttpRequest | null = null;
    try {
      request = http.createHttp();
      const response = await request.request(
        'http://192.168.205.22:3001/lxl/orders',
        {
          method: http.RequestMethod.GET,
          connectTimeout: 5000,
          readTimeout: 5000
        }
      );

      // 检查HTTP状态码（200-299为成功）
      if (response.responseCode < 200 || response.responseCode >= 300) {
        throw new Error(`请求失败，状态码：${response.responseCode}`);
      }

      const responseData = response.result as string;
      if (!responseData) {
        throw new Error('后端返回空数据');
      }

      const result: ApiResponse<OrderItem> = JSON.parse(responseData);
      this.orders = result.data.filter(i => i.status === '进行中')
      this.order_run = result.data.filter(i => i.status === '进行中').length;
    } catch (error) {
      console.error('加载订单失败：', error);
      this.orders = [];
      this.order_run = 0;
    } finally {
      if (request) {
        request.destroy();
      }
      // 新增：无论成功失败，都结束刷新状态
    }
  }


  build() {
    RelativeContainer() {
      Column() {
        // 顶部导航栏
        Row() {
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
            Stack().width('10%');
            Stack() {
              Text('服务订单'+this.orders.length)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
                .textAlign(TextAlign.Center)
                .fontColor('#ffffffff')
            }.onClick(()=>{
              this.loadOrders()
              console.log('更新了')
            })

            Stack().width('10%');
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFA500')
        .justifyContent(FlexAlign.SpaceBetween);

        // 订单统计行
        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
          Row() {
            Text('进行中：').fontSize(16);
            Text(`${this.order_run}个订单`)
              .fontSize(16)
              .fontColor(Color.Red);
          };

          Row() {
            Image($r('app.media.order')).width(24).height(24);
            Text('历史订单')
              .fontSize(16)
              .margin({ left: 4 });
          }
          .onClick(() => {
            router.pushUrl({ url: 'pages/LXL/history_orders' });
          });
        }
        .padding({
          top: 16,
          left: 16,
          right: 16,
          bottom: 8
        });

        Column() {
          ForEach(this.orders, (order: OrderItem, index: number) => {
            if (order.status === '进行中') {
              Row() {
                Column() {
                  Image(this.img[index % this.img.length])// 优化：避免索引越界
                    .width(48)
                    .height(48)
                    .borderRadius(8);
                  Text(order.from)
                    .fontSize(12)
                    .margin({ top: 4 });
                }
                .margin({ right: 12 });

                Column() {
                  Row() {
                    Text(`共${order.totalCount}件`).fontSize(14).fontColor('#888888');
                    Text(' 合计 ').fontSize(14).fontColor('#888888');
                    Text(`￥${order.totalPrice.toFixed(2)}`).fontSize(16).fontColor(Color.Red);
                  }
                  .margin({ bottom: 4 });

                  Text(`预计送达：202${index}-12-0${index} 18:30`).fontSize(14).fontColor('#888888');
                  Text(`下单时间：${this.time_filter(order.orderTime)}`).fontSize(12).fontColor('#bbbbbb');
                }
                .width('75%')
                .alignItems(HorizontalAlign.Start);

                Image($r('app.media.grantor')).width(16).height(16);
              }
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/LXL/details',
                  params: { item: order }
                });
              })
              .padding(12)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .margin({ left: 16, right: 16, top: 8 })
              .width('95%')
              .shadow({
                radius: 8,
                color: '#eeeeee',
                offsetX: 0,
                offsetY: 2
              });
            }
          }, (order: OrderItem) => order._id);
        }
      }
      .backgroundColor('#F7F7F7')
      .height('100%')
      .width('100%');
    }
    .height('100%')
    .width('100%');
  }
}

export default service_order;