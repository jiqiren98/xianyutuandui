import router from '@ohos.router';

// 定义订单数据类型
interface OrderItem {
  id: number;
  count: string;
  totalPrice: string;
  orderTime: string;
  status: '已完成' | '已取消'; // 可扩展更多状态
}

// 定义导航菜单项数据

interface NavItems {
  title: string;
  isActive: boolean
}

@Entry
@Component
struct DetailsPage {
  @State isCollected: boolean = false;
  private navItems: NavItems[] = [
    { title: '全部', isActive: false },
    { title: '便利超市', isActive: false },
    { title: '小区团购', isActive: true }, // 模拟当前激活项
    { title: '蛋糕烘焙', isActive: false },
    { title: '家政清洁', isActive: false },
    { title: '保养干洗', isActive: false }
  ]
  // 模拟订单数据源，实际可从接口请求
  @State orderList: OrderItem[] = [
    {
      id: 1,
      count: '共 3 件',
      totalPrice: '￥89.80',
      orderTime: '2019-12-20 17:20',
      status: '已完成'
    },
    {
      id: 2,
      count: '共 3 件',
      totalPrice: '￥89.80',
      orderTime: '2019-12-20 17:20',
      status: '已完成'
    },
    {
      id: 3,
      count: '共 3 件',
      totalPrice: '￥89.80',
      orderTime: '2019-12-20 17:20',
      status: '已完成'
    },
    {
      id: 4,
      count: '共 3 件',
      totalPrice: '￥89.80',
      orderTime: '2019-12-20 17:20',
      status: '已取消'
    },
    {
      id: 5,
      count: '共 3 件',
      totalPrice: '￥89.80',
      orderTime: '2019-12-20 17:20',
      status: '已完成'
    }
  ];

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Stack() {
            Text('<')
              .fontColor('#ffffffff')
              .onClick(() => {
                router.back()
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

      Row() {
        //左侧菜单
        Stack() {
          Column({ space: 10 }) {
            ForEach(this.navItems, (item:NavItems) => {
              Row() {
                Text(item.title)
                  .fontSize(14)
                  .fontColor(item.isActive ? '#FFA500' : '#333333')  // 激活项橙色高亮
                  .padding(10)
                  .backgroundColor(item.isActive ? '#F5F5F5' : '#FFFFFF')  // 激活项背景区分
                  .onClick(() => {
                    // 处理导航点击逻辑，可结合router跳转或状态管理
                    this.navItems.forEach(i => i.isActive = false);
                    item.isActive = true;
                  })
              }
              .width('100%')
              .borderRadius(6)
            })
          }
          .width('20%')
          .padding(10)
          .backgroundColor('#FFFFFF')

        }


        //右侧订单列表区域
        Stack() {
          List({ space: 10, initialIndex: 0 }) {
            ForEach(this.orderList, (item: OrderItem) => {
              ListItem() {
                Column() {
                  Row() {
                    Text(item.count)
                      .fontSize(14)
                      .fontColor('#333333')
                    Text(item.totalPrice)
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
              }
            }, (item: OrderItem) => item.id.toString())
          }
          .width('70%')
          .height('flex')
          .padding({ top: 10 })
          .backgroundColor('#f5f5f5')
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5');
  }
}