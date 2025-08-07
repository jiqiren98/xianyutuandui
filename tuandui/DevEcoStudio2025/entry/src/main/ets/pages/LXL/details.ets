import router from '@ohos.router';

// 拆分用户信息子类型
interface UserInfo {
  channel: string; // 下单渠道（如“小程序”）
  phone: string; // 用户手机号（脱敏后）
}

// 拆分商品信息子类型
interface ProductItem {
  name: string; // 商品名称
  count: number; // 商品数量
  price: number; // 商品单价
  image: Resource; // 商品图片资源
}

// 主订单信息接口（引用拆分后的子接口）
interface OrderInfo {
  orderStatus: string; // 订单状态（如“进行中”）
  userInfo: UserInfo; // 引用UserInfo接口
  deliveryAddress: string; // 配送地址
  orderTime: string; // 下单时间
  orderRemark: string; // 订单备注
  products: ProductItem[]; // 引用ProductItem接口的数组
  totalDiscount: number; // 优惠金额
  totalAmount: number; // 合计金额
  cancelBtnVisible: boolean; // 是否显示“取消订单”按钮
}

@Entry
@Component
struct DetailsPage {
  @State isCollected: boolean = false;
  // 模拟订单数据源
  private orderInfo: OrderInfo = {
    orderStatus: '进行中',
    userInfo: {
      channel: '小程序',
      phone: '138****0000',
    },
    deliveryAddress: '武汉市江汉区汉江大道166号鹏利广场1单元2栋304',
    orderTime: '2019年12月23日 17:18',
    orderRemark: '无',
    products: [
      {
        name: '可口可乐含糖可乐888ml瓶',
        count: 1,
        price: 5.00,
        image: $r('app.media.icon03'), // 替换为实际图片资源
      },
      {
        name: '景田百岁山570ml瓶',
        count: 1,
        price: 3.00,
        image: $r('app.media.icon03'), // 替换为实际图片资源
      },
    ],
    totalDiscount: 1.00,
    totalAmount: 8.00,
    cancelBtnVisible: true,
  };

  @Builder
  OrderStatusBar() {
    Row() {
      Text('订单状态')
        .fontSize(16)
        .fontColor('#333');
      Text(this.orderInfo.orderStatus)
        .fontSize(16)
        .fontColor('#ff5000')
        .fontWeight(FontWeight.Bold)
        .margin({ left: 8 });
    }.margin('5px')
  }

  @Builder
  UserInfoSection() {
    Column({ space: 8 }) {
      Row() {
        Text('用户信息')
          .fontSize(16)
          .fontColor('#333')
          .layoutWeight(1);
        Text(`${this.orderInfo.userInfo.channel}  ${this.orderInfo.userInfo.phone}`)
          .fontSize(16)
          .fontColor('#666');
      }

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
        Stack() {
          Text('配送地址')
            .fontSize(16)
            .fontColor('#333')
            .layoutWeight(1);
        }.width('20%')

        Stack() {
          Text(this.orderInfo.deliveryAddress)
            .fontSize(16)
            .fontColor('#666')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis });
        }.width('60%')

      }

      Row() {
        Text('下单时间')
          .fontSize(16)
          .fontColor('#333')
          .layoutWeight(1);
        Text(this.orderInfo.orderTime)
          .fontSize(16)
          .fontColor('#666');
      }

      Row() {
        Text('订单备注')
          .fontSize(16)
          .fontColor('#333')
          .layoutWeight(1);
        Text(this.orderInfo.orderRemark || '无')
          .fontSize(16)
          .fontColor('#666');
      }
    }
  }

  @Builder
  ProductList() {
    Column({ space: 12 }) {
      Text('商品清单')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333');

      ForEach(this.orderInfo.products, (product: ProductItem) => {
        Row({ space: 12 }) {
          Image(product.image)
            .width(60)
            .height(60)
            .objectFit(ImageFit.Contain);
          Column({ space: 4 }) {
            Text(product.name)
              .fontSize(16)
              .fontColor('#333');
            Text(`共${product.count}件  小计 ¥${product.price.toFixed(2)}`)
              .fontSize(14)
              .fontColor('#666');
          }
        }
      })
    }
  }

  @Builder
  AmountSummary() {
    Column({ space: 8 }) {
      Row() {
        Text('共2件')
          .fontSize(16)
          .fontColor('#333')
          .layoutWeight(1);
        Text(`优惠 ¥${this.orderInfo.totalDiscount.toFixed(2)}`)
          .fontSize(16)
          .fontColor('#ff5000');
        Text(`合计 ¥${this.orderInfo.totalAmount.toFixed(2)}`)
          .fontSize(16)
          .fontColor('#ff5000')
          .fontWeight(FontWeight.Bold);
      }
    }
  }

  @Builder
  BottomActions() {
    Column({ space: 8 }) {
      Text('便利商品支付后正常20分钟内送达，请保持手机畅通！\n便利超市订单支付后3分钟内可以取消订单')
        .fontSize(14)
        .fontColor('#666')
        .lineHeight(20);

      Row() {
        Text('如有特殊情况请联系管家')
          .fontSize(14)
          .fontColor('#666')
          .layoutWeight(1);
        if (this.orderInfo.cancelBtnVisible) {
          Button('取消订单')
            .width(100)
            .height(32)
            .fontSize(14)
            .backgroundColor('#ff5000')
            .fontColor(Color.White)
            .borderRadius(4)
            .onClick(() => {
              console.log('取消订单');
            });
        }
        Button('拨打管家电话')
          .width(120)
          .height(32)
          .fontSize(14)
          .backgroundColor('#f5f5f5')
          .fontColor('#333')
          .border({ width: 1, color: '#ddd' })
          .borderRadius(4)
          .onClick(() => {
            console.log('拨打电话');
          });
      }
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }){
          Stack() {
            Text('<').onClick(() => {
              router.back()
            })
              .fontColor('#ffffffff')
          }.width('10%')
          Stack(){
            Text('订单详情')
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

      // 内容滚动区
      Scroll() {
        Column({ space: 16 }) {
          this.OrderStatusBar()
          this.UserInfoSection()
          this.BottomActions()
          this.AmountSummary()
          this.ProductList()
        }
        .padding(16)
      }
      .scrollable(ScrollDirection.Vertical)
      .layoutWeight(1);

      // 底部操作栏
      Row() {
        Button('查看物流')
          .width('45%')
          .height(40)
          .backgroundColor('#ff5000')
          .fontColor(Color.White);

        Button('联系商家')
          .width('45%')
          .height(40)
          .backgroundColor('#333')
          .fontColor(Color.White);
      }
      .width('100%')
      .height(80)
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(Color.White);
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5');
  }
}
