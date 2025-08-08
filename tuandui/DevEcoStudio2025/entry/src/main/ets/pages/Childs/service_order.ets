import router from '@ohos.router';

interface OrderType {
  icon?: Resource;
  title: string;
  count: number;
  total: number;
  time: string;
  orderTime: string;
}

@Entry
@Component
struct service_order {
  @State message: string = 'service_order';
  private orders: OrderType[] = [
    {
      icon: $r('app.media.icon03'),
      title: '便利店订单',
      count: 2,
      total: 19.9,
      time: '17:30',
      orderTime: '2025-08-05'
    },
    {
      icon: $r('app.media.icon02'),
      title: '小区团购',
      count: 3,
      total: 89.80,
      time: '2019-12-24 18:30',
      orderTime: '2019-12-20 17:20'
    },
    {
      icon: $r('app.media.icon01'),
      title: '蛋糕烘焙',
      count: 2,
      total: 306.00,
      time: '今天 16:30',
      orderTime: '2019-12-20 17:20'
    },
    {
      icon: $r('app.media.hand'),
      title: '家政清洁',
      count: 1,
      total: 80.00,
      time: '今天 17:35',
      orderTime: '2019-12-20 17:20'
    },
    {
      icon: $r('app.media.icon04'),
      title: '保养干洗',
      count: 2,
      total: 90.00,
      time: '今天 17:35',
      orderTime: '2019-12-20 17:20'
    }
  ]

  build() {
    RelativeContainer() {

      Column() {
        // 顶部栏
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
            Text('历史订单')
              .fontSize(16)
              .margin({ left: 4 })
          }

        }
        .padding({
          top: 16,
          left: 16,
          right: 16,
          bottom: 8
        })


        // 订单列表
        ForEach(this.orders, (order: OrderType, index: number) => {
          Row() {
            Column() {
              Image(order.icon)// 替换为实际资源
                .width(48)
                .height(48)
                .borderRadius(8)
              Text("便利超市")
                .fontSize(12)
                .margin({ top: 4 })
            }
            .margin({ right: 12 })

            // 订单信息
            Column() {
              Row() {

                Text(`共${order.count}件`)
                  .fontSize(14)
                  .fontColor('#888888')
                Text(' 合计 ')
                  .fontSize(14)
                  .fontColor('#888888')
                Text(`￥${order.total.toFixed(2)}`)
                  .fontSize(16)
                  .fontColor(Color.Red)
              }
              .margin({ bottom: 4 })

              Text(`预计送达：${order.time}`)
                .fontSize(14)
                .fontColor('#888888')
              Text(`下单时间：${order.orderTime}`)
                .fontSize(12)
                .fontColor('#bbbbbb')
            }

            Blank() // 右箭头
            Image($r('app.media.grantor'))// 资源名需和media目录下图片一致
              .width(16).height(16)
          }
          .onClick(() => {
            router.pushUrl({
              url:'pages/LXL/details'
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
        }, (order: OrderType) => order.title) // key
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