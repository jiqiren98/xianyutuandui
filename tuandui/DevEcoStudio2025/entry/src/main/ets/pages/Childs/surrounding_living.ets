import router from '@ohos.router';

@Entry
@Component
struct PersonalCenter {
  @State message: string = '小TA';

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('个人中心')
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold) // 替换为枚举类型
          .fontSize(17)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FF9800')
      .justifyContent(FlexAlign.Center)

      // 顶部信息区
      Row() {
        Column() {
          Text(this.message)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Row() {
            // 星级评分
            Text('★★★★★')
              .fontSize(12)
              .fontColor('#FF9800')
            Text('会员时长: 3个月10天')
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
        Image('https://via.placeholder.com/60') // 替换为实际头像
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

      // 会员信息区（修正边框写法）
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
      .border({ width: 1, color: '#EEEEEE' }) // 统一边框格式

      // 红包卡券积分区（修正边框写法）
      Row() {
        Column() {
          Text('红包奖励')
            .fontSize(12)
            .fontColor('#999999')
          Text('¥')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF5722')
          Text('可用')
            .fontSize(10)
            .fontColor('#999999')
            .margin({ top: 2 })
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
          Text('¥')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF5722')
          Text('可用')
            .fontSize(10)
            .fontColor('#999999')
            .margin({ top: 2 })
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
          Text('¥')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF5722')
          Text('150分')
            .fontSize(10)
            .fontColor('#999999')
            .margin({ top: 2 })
        }
        .width('33.33%')
        .height(80)
        .justifyContent(FlexAlign.Center)

        .backgroundColor('#FFFFFF')
      }
      .width('100%')

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
}

export default PersonalCenter;