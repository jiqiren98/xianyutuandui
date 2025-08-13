import router from '@ohos.router';

// 拆分用户信息子类型
interface UserInfo {
  channel: string;   // 下单渠道（如“小程序”）
  phone: string;     // 用户手机号（脱敏后）
}

// 拆分商品信息子类型
interface ProductItem {
  name: string;      // 商品名称
  count: number;     // 商品数量
  price: number;     // 商品单价
  image: Resource;   // 商品图片资源
}

// 主订单信息接口（引用拆分后的子接口）
interface OrderInfo {
  _id:string;
  status:'进行中' | '已完成' | '已取消' | '待支付' | '已退款';
  userInfo: string; // 引用UserInfo接口
  deliveryAddress: string; // 配送地址
  orderTime: string; // 下单时间
  orderRemark: string; // 订单备注
  products: ProductItem[]; // 引用ProductItem接口的数组
  totalCount: number; // 总数
  totalPrice: number; // 合计金额
  cancelBtnVisible: boolean; // 是否显示“取消订单”按钮
}

@Entry
@Component
struct DetailsPage {
  @State isCollected: boolean = false;
  @State cardId :number =0 ;
  aboutToAppear() {
    const params = router.getParams() as Record<string, number|OrderInfo>;
    if (params?.cardId !== undefined) {
      this.cardId = params.cardId as number;
    }
    if (params?.item !==undefined){
      this.orderInfo = params.item as OrderInfo
    }
  }
  //是否可以取消订单
  canCancelOrder(orderTime: string): boolean {
    const createTime = new Date(orderTime).getTime(); // 订单创建时间（毫秒）
    const currentTime = new Date().getTime(); // 当前时间（毫秒）
    const diffMinutes = (currentTime - createTime) / (1000 * 60); // 时间差（分钟）
    return diffMinutes > 3; // 超过3分钟返回true（允许取消）
  }


  //时间过滤器


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
  // 模拟订单数据源
  private orderInfo: OrderInfo = {
    _id:'1110',
    status: '进行中',
    userInfo: '',
    deliveryAddress: '武汉市江汉区汉江大道166号鹏利广场1单元2栋304',
    orderTime: '2019年12月23日 17:18',
    orderRemark: '无',
    products: [],
    totalCount: 1,
    totalPrice: 8.00,
    cancelBtnVisible: true,
  };

  @Builder
  OrderStatusBar() {
    Column(){
      Row() {
        Text('订单状态')
          .fontSize(16)
          .fontColor('#ff000000');
        Text(this.orderInfo.status)
          .fontSize(16)
          .fontColor(this.orderInfo.status === '已完成' ? '#00CC00' : '#FF0000')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 });
      }
    }
    .width('100%')
    .height(56)
    .backgroundColor('#ffffffff')
    .margin({top:8,bottom:8})
    .justifyContent(FlexAlign.Center);
  }

  @Builder
  UserInfoSection() {
    Column({ space: 8 }) {
      Row() {
        Text('订单编号:')
          .fontSize(16)
          .fontColor('#333')
          .layoutWeight(1);
        Text(`${this.orderInfo._id} `)
          .fontSize(16)
          .fontColor('#666');
      }

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
        Stack() {
          Text('配送地址')
            .fontSize(16)
            .fontColor('#333')
        }.width('20%')

        Stack() {
          Text(this.orderInfo.deliveryAddress)
            .fontSize(16)
            .fontColor('#666')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis });
        }.width('60%')

      }.width('100%')

      Row() {
        Text('下单时间')
          .fontSize(16)
          .fontColor('#333')
          .layoutWeight(1);
        Text(this.time_filter(this.orderInfo.orderTime))
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
      .width('100%')
      .height(56)
      .margin({top:8,bottom:8})

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
        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Stack() {
            Image($r('app.media.icon404'))
              .width(60)
              .height(60)
              .objectFit(ImageFit.Contain);
          }.width('20%')

          Column({ space: 4 }) {
            Text(product.name)
              .fontSize(16)
              .fontColor('#ff000000')
              .width('100%')
            Text(`共${product.count}件  小计 ¥${product.price.toFixed(2)}`)
              .fontSize(14)
              .fontColor('#666')
              .width('100%')
          }.width('75%')
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
        Text(`优惠 ¥${this.orderInfo.totalCount}`)
          .fontSize(16)
          .fontColor('#ff5000');
        Text(`合计 ¥${this.orderInfo.totalPrice.toFixed(2)}`)
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
        .fontSize(12)
        .fontColor('#666')
        .lineHeight(20);
    }
    .margin({top:50,bottom:50})
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
          Stack() {
            Text('<').onClick(() => {
              router.back()
            })
              .fontColor('#ffffffff')
          }.width('10%')

          Stack() {
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

      Column() {
        this.OrderStatusBar()
        this.UserInfoSection()
        this.BottomActions()
        this.AmountSummary()
        this.ProductList()
      }

      // 底部操作栏
      Row() {
        if(!this.canCancelOrder(this.orderInfo.orderTime)){
          Button('取消订单')
            .width('45%')
            .height(40)
            .backgroundColor('#ff5000')
            .fontColor(Color.White)
            .onClick(()=>{

            })
        }else {
          Text()
        }

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
