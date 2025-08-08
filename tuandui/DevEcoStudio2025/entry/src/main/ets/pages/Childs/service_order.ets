import router from '@ohos.router';
import http from '@ohos.net.http';

interface ApiResponse<T> {
  success: boolean; // 接口调用是否成功（true/false）
  count: number; // 数据总数
  data: T[]; // 具体数据列表（泛型数组，根据业务场景指定类型）
}

// 定义商品信息类型（匹配后端products结构）
interface Product {
  _id: string;
  name: string;
  count: number;
  price: number;
  image: string;
}

// 定义订单数据类型（完全匹配后端返回结构）
interface OrderItem {
  icon?: Resource
  _id: string; // 后端返回的唯一标识
  status: '进行中' | '已完成' | '已取消' | '待支付' | '已退款'; // 完整状态枚举
  userInfo?: string; // 关联的用户ID
  deliveryAddress?: string;
  orderTime: string; // 后端返回的ISO时间字符串
  orderRemark?: string;
  products?: Product[]; // 商品列表
  totalCount: number; // 总数量（数字类型）
  totalPrice: number; // 总价格（数字类型）
  cancelBtnVisible?: boolean;
  from: string; // 订单来源（匹配导航菜单）
}

@Entry
@Component
struct service_order {
  @State message: string = 'service_order';
  private request: http.HttpRequest | null = null; // 初始化为 null
  @State res: http.HttpRequest | null = null
  @State img: Resource[] =
    [$r('app.media.icon03'), $r('app.media.icon02'), $r('app.media.icon01'), $r('app.media.hand'),
      $r('app.media.icon04')]

  aboutToDisappear() {
    if (this.request) {
      this.request.destroy(); // 页面销毁时取消请求
      this.request = null;
    }
  }

  aboutToAppear() {
    this.loadOrders();
  }

  // 从后端加载订单数据
  async loadOrders() {
    let request: http.HttpRequest | null = null;

    try {
      request = http.createHttp();
      // 发送请求
      const response = await request.request(
        'http://192.168.205.22:3001/lxl/orders',
        {
          method: http.RequestMethod.GET,
          connectTimeout: 5000,
          readTimeout: 5000
        }
      );

      // 1. 检查请求状态码（200 表示成功）


      // 2. 从 result 中获取数据（类型为 any，需转为字符串后解析）
      const responseData = response.result as string;
      if (!responseData) {
        throw new Error('后端返回空数据');
      }

      // 3. 解析 JSON 数据并匹配 ApiResponse 接口
      const result: ApiResponse<OrderItem> = JSON.parse(responseData);
      this.orders = result.data

    } catch (error) {
      this.orders = []
    } finally {
      if (request) {
        request.destroy(); // 销毁请求实例
      }
    }
  }
  @State orders: OrderItem[] = []
  build() {
    RelativeContainer() {

      Column() {
        // 顶部栏
        // 顶部导航栏
        Row() {
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
            Stack() {
              Text('')
            }.width('10%')

            Stack() {
              Text('服务订单')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
                .textAlign(TextAlign.Center)
                .fontColor('#ffffffff')

            }

            Stack().width("10%")
          }

        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFA500')
        .justifyContent(FlexAlign.SpaceBetween);

        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
          Row() {
            Text('进行中：')
              .fontSize(16)
            Text('5 个订单')
              .fontSize(16)
              .fontColor(Color.Red)
          }

          Row() {
            // 替代Blank，自动填充剩余空间
            Image($r('app.media.order'))
              .width(24).height(24)
            Stack() {
              Text('历史订单')
                .fontSize(16)
                .margin({ left: 4 })
            }
          }.onClick(() => {
            router.pushUrl({
              url: 'pages/LXL/history_orders'
            })
          })

        }
        .padding({
          top: 16,
          left: 16,
          right: 16,
          bottom: 8
        })


        // 订单列表
        ForEach(this.orders, (order: OrderItem, index: number) => {
          if (order.status==='进行中') {
            Row() {
              Column() {
                Image(this.img[index])// 替换为实际资源
                  .width(48)
                  .height(48)
                  .borderRadius(8)
                Text(order.from)
                  .fontSize(12)
                  .margin({ top: 4 })
              }
              .margin({ right: 12 })

              // 订单信息
              Column() {
                Row() {
                  Text(`共${order.totalCount}件`)
                    .fontSize(14)
                    .fontColor('#888888')
                  Text(' 合计 ')
                    .fontSize(14)
                    .fontColor('#888888')
                  Text(`￥${order.totalPrice.toFixed(2)}`)
                    .fontSize(16)
                    .fontColor(Color.Red)
                }
                .margin({ bottom: 4 })

                Text(`预计送达：202${index}-12-0${index} 18:30`)
                  .fontSize(14)
                  .fontColor('#888888')
                Text(`下单时间：${order.orderTime}`)
                  .fontSize(12)
                  .fontColor('#bbbbbb')
              }
              .width('75%')
              .alignItems(HorizontalAlign.Start)

              Image($r('app.media.grantor'))// 资源名需和media目录下图片一致
                .width(16).height(16)
            }
            .onClick(() => {
              router.pushUrl({
                url: 'pages/LXL/details',
                params: { item: order }
              })
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
            })
          }
        }, (order: OrderItem) => order._id) // key
      }
      .backgroundColor('#F7F7F7')
      .height('100%')
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }
}


export default service_order