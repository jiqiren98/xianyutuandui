import router from '@ohos.router';
import http from '@ohos.net.http';
import { DataType } from '@kit.MediaLibraryKit';
// http://172.30.208.1:3001/lxl/orders
interface ApiResponse<T> {
  success: boolean; // 接口调用是否成功（true/false）
  count: number;    // 数据总数
  data: T[];        // 具体数据列表（泛型数组，根据业务场景指定类型）
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

// 定义导航菜单项数据
@Observed
class NavItem {
  title: string;
  isActive: boolean;

  constructor(title: string, isActive: boolean) {
    this.title = title;
    this.isActive = isActive;
  }
}

// 子组件 - 导航菜单
@Component
struct NavMenu {
  @Link navItems: NavItem[];
  @Link activeIndex: number;
  private request: http.HttpRequest | null = null; // 初始化为 null
  @State res : http.HttpRequest | null = null

  aboutToDisappear() {
    if (this.request) {
      this.request.destroy(); // 页面销毁时取消请求
      this.request = null;
    }
  }

  build() {
    Column({ space: 10 }) {
      ForEach(this.navItems, (item: NavItem, index: number) => {
        Row() {
          Text(item.title)
            .fontSize(14)
            .fontColor(this.activeIndex === index ? '#FFA500' : '#333333')
            .padding(10)
            .backgroundColor(this.activeIndex === index ? '#F5F5F5' : '#FFFFFF')
            .onClick(() => {
              this.activeIndex = index;
            })
        }
        .width('100%')
        .borderRadius(6)
      })
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
  }
}

@Entry
@Component
struct DetailsPage {
  @State activeIndex: number = 0;
  @State navItems: NavItem[] = [
    new NavItem('全部', true),
    new NavItem('便利超市', false),
    new NavItem('小区团购', false),
    new NavItem('蛋糕烘焙', false),
    new NavItem('家政清洁', false),
    new NavItem('保养干洗', false)
  ];
  @State cate: string[] = ['全部', '便利超市', '小区团购', '蛋糕烘焙', '家政清洁', '保养干洗']
  // 模拟订单数据源，实际可从接口请求
  @State orderList: OrderItem[] = [];
  @State isLoading: boolean = false;
  aboutToAppear() {
    this.loadOrders();
  }

  // 从后端加载订单数据
  async loadOrders() {
    this.isLoading = true;
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
      this.orderList = result.data

    } catch (error) {
      this.orderList = []
    } finally {
      this.isLoading = false;
      if (request) {
        request.destroy(); // 销毁请求实例
      }
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
          Stack() {
            Text('<')
              .fontColor('#ffffffff')
              .onClick(() => {
                router.back();
              })
          }
          .width('10%')

          Stack() {
            Text('历史订单')
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

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Start }) {
        // 左侧菜单（使用子组件）
        Stack() {
          NavMenu({
            navItems: $navItems,
            activeIndex: $activeIndex
          })
        }
        .width('20%')

        // 右侧订单列表区域
        Stack() {
          if (this.isLoading) {
            Column() {
              LoadingProgress()
                .width(50)
                .height(50)
              Text('加载中...')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ top: 10 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          } else {
            List({ space: 10, initialIndex: 0 }) {
              ForEach(this.orderList, (item: OrderItem,index:number) => {
                if (this.cate[this.activeIndex] === item.from || this.activeIndex === 0) {
                  ListItem() {
                    Column() {
                      Row() {
                        Text('共'+`${item.totalCount}`+"件")
                          .fontSize(14)
                          .fontColor('#333333')
                        Text('合计￥'+`${item.totalPrice}`)
                          .fontSize(14)
                          .fontColor('#FF0000')
                          .margin({ left: 5 })
                      }
                      .padding({ bottom: 5 })

                      Row() {
                        Text(`下单时间：${item.orderTime}`)
                          .fontSize(12)
                          .fontColor('#999999')
                      }
                      .padding({ bottom: 5 })

                      Row() {
                        Text(item.status)
                          .fontSize(12)
                          .fontColor(item.status === '已完成' ? '#00CC00' : '#FF0000')
                      }
                    }
                    .padding(15)
                    .backgroundColor('#ffffff')
                    .borderRadius(8)
                    .width('100%')
                    .margin({ left: 10, right: 10 })
                    .onClick(()=>{
                      router.pushUrl({
                        url: 'pages/LXL/details',
                        params: { item: item }
                      })
                    })
                  }
                }
              }, (item: OrderItem) => item._id.toString())
            }
            .width('70%')
            .height('flex')
            .padding({ top: 10 })
            .backgroundColor('#f5f5f5')
          }
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5');
  }
}
