import router from '@ohos.router';
import {BusinessError} from '@kit.BasicServicesKit'

interface iconAbc {
  name:string,
  icon:Resource,
  back?:string,
}

@Entry
@Component
struct personal_center {
  @State message: string = 'personal_center';

  private iconList:iconAbc[] = [
    {name:'便利超市', icon:$r('app.media.bianlichaoshizhangben'), back:'#FFF8AB'},
    {name:'小区团购', icon:$r('app.media.tuangou'), back:'#DAF6F3'},
    {name:'蛋糕烘焙', icon:$r('app.media.dangaohongbei'), back:'#E0D9D5'},
    {name:'家政清洁', icon:$r('app.media.jiazhengqingjie'), back:'#FFE9E9'},
    {name:'保养洗干', icon:$r('app.media.ganxi'), back:'#E8E8E8'}
  ]

  private iconListA:iconAbc[][] = [
    [
      {name:'同城快递', icon:$r('app.media.xinnuoyou_fill'), back:'#DAE9F6'},
      {name:'家电维修', icon:$r('app.media.jiadianweixiu'), back:'#FFF0E3'}
    ],
    [
      {name: '净菜配菜', icon:$r('app.media.canju'), back:'#FFF0E3'},
      {name: '医疗保健', icon:$r('app.media.yiliaobaojian'), back:'#DAE9F6'}
    ],
    [
      {name:'代送接送', icon:$r('app.media.san'), back:'#DAF6F3'},
      {name:'代办跑腿', icon:$r('app.media.huojian'), back:'#E0D9D5'}
    ],
    [
      {name:'修门开锁', icon:$r('app.media.kaisuo'), back:'#E0D9D5'},
      {name:'手机维修', icon:$r('app.media.shouji'), back:'#DAE9F6'}
    ],
    [
      {name:'代缴费用', icon:$r('app.media.yinhangka_huaban'), back:'#FFF0E3'},
      {name:'更换煤气', icon:$r('app.media.menling'), back:'#DAF6F3'}
    ]
  ]

  private iconLists:iconAbc[][] = [
    [
      {name:'家教培训', icon:$r('app.media.study'), back:'#DAF6F3'},
      {name:'年检换证', icon:$r('app.media.bianlichaoshizhangben'), back:'#E0D9D5'}
    ],
    [
      {name:'派对惊喜', icon:$r('app.media.liwu'), back:'#DAE9F6'},
      {name:'货运搬家', icon:$r('app.media.huojian'), back:'#FFF0E3'}
    ],
    [
      {name:'会议决策', icon:$r('app.media.fangjianpeitaotubiao'), back:'#FFF0E3'},
      {name:'鲜花绿植', icon:$r("app.media.lvye32"), back:'#FFF8AB'}
    ],
    [
      {name:'文印广告', icon:$r('app.media.dayinwenjian'), back:'#FFF8AB'},
      {name:'美妆养生', icon:$r("app.media.magicfull"), back:'#DAE9F6'}
    ],
    [
      {name:'汽车保养', icon:$r('app.media.qiche'), back:'#E0D9D5'},
      {name:'保姆培训', icon:$r('app.media.FBABEACCEFEB'), back:'#DAF6F3'}
    ]
  ]
  build() {
    Column(){

      Column(){
        Text('常用服务')
          .fontSize('16')
          .textAlign(TextAlign.Start)
          .padding({left:10})

        Grid(){
          ForEach(this.iconList, (item:iconAbc,index:number) => {
              GridItem(){
                Column(){
                  Image(item.icon)
                    .width('60')
                    .height('60')
                    .backgroundColor(item.back)
                    .borderRadius(10)
                    .padding({top:10,bottom:10,left:10,right:10})
                  Text(item.name)
                    .fontSize(12)
                }
                .onClick(() => {
                  // 传递额外的参数到目标页面
                  router.pushUrl({
                    url: `pages/Childs/Personal/Detail_page`,
                    params: {
                      id: JSON.stringify(index)
                    }
                  })
                    .then(() => {
                      console.log("跳转成功");
                    })
                    .catch((error: string) => {
                      console.error("跳转失败: " + JSON.stringify(error));
                    });
                })
              }
              .width('20%')
          }, (item:iconAbc) => item.name )
        }
        .width('100%')
        .margin({bottom:10})
      }
      .width('100%')
      .height('20%')
      .backgroundColor('#FFF')
      .justifyContent(FlexAlign.SpaceBetween)

      Column(){
        Grid(){
          ForEach(this.iconListA, (item:iconAbc[]) => {
            GridItem() {
              Column(){
                ForEach(item, (items:iconAbc) => {
                  Column(){
                    Image(items.icon)
                      .width('60')
                      .height('60')
                      .backgroundColor(items.back)
                      .borderRadius(5)
                      .padding({top:10,bottom:10,left:10,right:10})
                    Text(items.name)
                      .fontSize(12)
                  }
                  .margin({top:20,bottom:20})
                }, (items:iconAbc,indexs:number) => `res_${indexs}` )
              }
              .width('20%')
            }
          }, (item:iconAbc[], index:number) => `${index}` )
        }
        .width('100%')
      }
      .width('100%')
      .height('35%')
      .backgroundColor('#FFF')
      .margin({top:'5%',bottom:'5%'})
      .justifyContent(FlexAlign.SpaceBetween)


      Column(){
        Grid(){
          ForEach(this.iconLists, (item:iconAbc[]) => {
            GridItem(){
              Column(){
                ForEach(item, (items:iconAbc) => {
                  Column(){
                    Image(items.icon)
                      .width('60')
                      .height('60')
                      .backgroundColor(items.back)
                      .borderRadius(10)
                      .padding({top:10,bottom:10,left:10,right:10})
                      .margin({bottom:5})
                    Text(items.name)
                      .fontSize(12)
                  }
                  .margin({top:20,bottom:20})
                }, (items:iconAbc,indexs:number) => `w_${indexs}` )
              }
              .width('20%')
            }
          }, (item:iconAbc[], index:number) => `${index}` )
        }
      }
      .width('100%')
      .height('55%')
      .backgroundColor('#FFF')
      .justifyContent(FlexAlign.SpaceBetween)


    }
    .backgroundColor('#CCC')
    .width('100%')
    .height('100%')
  }
}

export default personal_center