import router from '@ohos.router';

@Entry
@Component
struct Index_home {
  @State message: string = 'Home';

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('本地生活-一站式服务直达')
          .fontColor('#FFFFFF')
          .fontWeight(800)
          .fontSize(15)

      }
      .margin({top:-40})
      .width('100%')
      .height(40)
      .backgroundColor('#FFA500')
      .justifyContent(FlexAlign.Center)
      // 选择区域
      Row() {
        Text('公告：本地生活的服务时间根据服务类型会有差异！请知悉！')
          .fontSize(12)
          .fontColor('#999999')
      }
      .width('100%')
      .height(30)
      .padding({ left: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F5F5F5')

      // 小TA信息栏
      Row() {
        Image('https://via.placeholder.com/50') // 这里替换为小TA的实际图片链接
          .width(50)
          .height(50)
          .borderRadius(25)
        Column() {
          Text('小TA')
            .fontSize(16)
            .fontWeight(700)
          Row() {
            Text('红包 ')
              .fontSize(12)
              .fontColor('#FFA500')
            Text('卡券 ')
              .fontSize(12)
              .fontColor('#FFA500')
              .margin({ left: 10 }) // 修改为 margin 方式
            Text('钱包 ')
              .fontSize(12)
              .fontColor('#FFA500')
              .margin({ left: 10 }) // 修改为 margin 方式
          }
        }
        .margin({ left: 10 }) // 修改为 margin 方式
        Text('签到领5元红包')
          .fontSize(12)
          .fontColor('#FFA500')
          .backgroundColor('#FFF0E6')
          .padding({ left: 5, right: 5, top: 2, bottom: 2 })
          .borderRadius(5)
          .margin({ left: 'auto', right: 10 }) // 修改为 margin 方式
      }
      .width('100%')
      .height(70)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid}) // 修改为更明确的 border 设置方式

      // 今日生活栏
      Row() {
        Text('今日生活')
          .fontSize(16)
          .fontWeight(700)
        Text('16-23℃')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 'auto' }) // 修改为 margin 方式
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid }) // 修改为更明确的 border 设置方式

      // 今日生活内容
      Column() {
        Row() {
          Image('https://via.placeholder.com/30')
            .width(30)
            .height(30)
          Column() {

          }
          .margin({ left: 10 })
        }
        .width('100%')
        .height(80)
        .padding({ left: 10, right: 10 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      Row(){

      }

      // 最新通知栏
      Row() {
        Text('最新')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#FFA500')
          .padding({ left: 5, right: 5, top: 2, bottom: 2 })
          .borderRadius(3)
        Text('11111111111111111')
          .fontSize(14)
          .margin({ left: 10 })
        Text('>')
          .fontSize(14)
          .margin({ left: 'auto' })
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid })

      // 超级品类日广告栏
      Image($r('app.media.chaoji'))
        .width('100%')
        .height(150)

      // 常用服务栏
      Row() {
        Text('常用服务')
          .fontSize(16)
          .fontWeight(700)
        Text('更多')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 'auto' })
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid})

      // 常用服务按钮
      Row() {
        Column() {
          Image($r('app.media.wentichaoshi'))
            .width(50)
            .height(50)
            .backgroundColor('#FFF58B')
            .padding(9)
          Text('便利超市')
            .fontSize(12)
            .margin({ top: 5 })
        }
        Column() {
          Image($r('app.media.gouwuche'))
            .width(50)
            .height(50)
            .backgroundColor('#DAF6F3')
            .padding(9)
          Text('小区团购')
            .fontSize(12)
            .margin({ top: 5 })
        }
        Column() {
          Image($r('app.media.dg'))
            .width(50)
            .height(50)
            .backgroundColor('#E0D9D5')
            .padding(9)
          Text('蛋糕烘焙')
            .fontSize(12)
            .margin({ top: 5 })
        }
        Column() {
          Image($r('app.media.jz'))
            .width(50)
            .height(50)
            .backgroundColor('#FFE9E9')
            .padding(9)
          Text('家政清洁')
            .fontSize(12)
            .margin({ top: 5 })
        }
        Column() {
          Image($r('app.media.shenghuo'))
            .width(50)
            .height(50)
            .backgroundColor('#E8E8E8')
            .padding(9)
          Text('保养干洗')
            .fontSize(12)
            .margin({ top: 5 })
        }
      }
      .width('100%')
      .height(80)
      .padding({ left: 10, right: 10 })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

export default Index_home;