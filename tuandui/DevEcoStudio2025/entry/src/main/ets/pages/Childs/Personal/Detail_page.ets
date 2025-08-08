import router from '@ohos.router';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';


interface Product {
  id: string;
  name: string;
  price: number;
  image: string;
}

interface Category {
  name: string;
}
interface QueryParams {
  id?: string;
  name?: string;
}

@Entry
@Component
struct DetailPage {
  @State ids: number = 0; // 接收传递的 id 参数
  @State selectedCategoryIndex: number = 0;
  @State products: Product[] = [];
  @State categories: Category[] = [
    { name: '饮料酒水' },
    { name: '日用百货' },
    { name: '文具用品' },
    { name: '粮油副食' },
    { name: '零食小吃' }
  ];



  private context?: common.UIAbilityContext;

  aboutToAppear() {
    const query = router.getParams() as QueryParams;
    if (query) {
      this.ids = parseInt(query.id || '0');
      console.log(JSON.stringify(this.ids))
    }
    this.context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    this.getProductList();
  }

  private async getProductList() {
    let httpRequest = http.createHttp();
    httpRequest.request(`http://localhost:3001/gk/index?id=${this.ids}`, (err: BusinessError, data: http.HttpResponse) => {
      if (!err) {
        console.info('Data received:', data.result);
        // 假设返回的 result 是数组
        this.products = data.result as Product[];
      } else {
        console.error('Request Error:', err);
      }
      httpRequest.destroy();
    });
  }

  build() {
    Column() {
      // 顶部：返回 + 我的订单
      Row() {
        Text('← 返回')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.pushUrl({ url: 'pages/Childs/Personal/personal_center' });
          });
        Blank();
        Text('我的订单')
          .fontSize(16)
          .fontWeight(FontWeight.Medium);
        // Image($r('app.media.order_icon')) // 顶部右侧图标
        //   .width(24)
        //   .height(24);
      }
      .padding(12)

      // Banner 图片
      Image($r('app.media.sclsbjztgg'))
        .width('95%')
        .height(90)
        .borderRadius(12)
        .margin({ bottom: 10 })

      // 公告
      Text('公告：本地生活服务时间根据服务类型会有差异！请知悉！')
        .width('100%')
        .fontSize(12)
        .textAlign(TextAlign.Center)
        .backgroundColor('#FFF8DC')
        .padding(10)
        .margin({ bottom: 10 })

      // 服务优惠横条
      Row() {
        Text('服务优惠')
          .fontSize(14)
          .margin({ right: 10 });

        Button() {
          Text('新用户减5');
        }
        .backgroundColor('#259B24')
        .fontColor('#FFF')
        .margin({ right: 8 })

        Button() {
          Text('满60减20');
        }
        .backgroundColor('#2196F3')
        .fontColor('#FFF')
      }
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .backgroundColor('#FFF')
      .margin({ bottom: 10 })

      // 商家推荐（横向滑动）
      Column() {
        Text('商家推荐')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .padding(12)

        // 横向商品卡片
        List() {
          ForEach([1, 2, 3], (index:number) => {
            ListItem() {
              Column() {
                Image($r('app.media.xiaoqu1'))
                  .width(80)
                  .height(80)
                  .borderRadius(8)
                Text('可口可乐888ml')
                  .fontSize(12)
                  .margin({ top: 4 })
                Row() {
                  Text('￥').fontSize(12).fontColor('red');
                  Text('5').fontSize(16).fontColor('red');
                  Button() {
                    Text('+');
                  }
                  .margin({ left: 4 })
                }
              }
              .width(100)
              .padding(8)
              .backgroundColor('#FFF')
              .borderRadius(10)
              .margin({ right: 10 })
            }
          })
        }
        .listDirection(Axis.Horizontal) // ✅ 正确写法
        .margin({ left: 12, right: 12 })
        .height(150) // 给定高度以确保展示
      }
      .backgroundColor('#FFF')
      .margin({ bottom: 10 })

      // 全部商品区域
      Row() {
        // 左边：分类导航
        Column() {
          ForEach(this.categories, (item: Category, index: number) => {
            Text(item.name)
              .fontSize(14)
              .padding(10)
              .backgroundColor(this.selectedCategoryIndex === index ? '#FFFFFF' : '#F5F5F5') // ✅ 高亮背景
              .fontColor(this.selectedCategoryIndex === index ? '#007DFF' : '#000000') // ✅ 高亮字体颜色
              .borderRadius(6)
              .margin({ bottom: 4 })
              .onClick(() => {
                this.selectedCategoryIndex = index;
              });
          }, (item: Category) => item.name)
        }
        .width('30%')
        .height(200)
        .backgroundColor('#EEE')

        // 右边：商品列表（可滑动）
        Scroll() {
          Column() {
            ForEach([1, 2, 3, 4], (index:number) => {
              Row() {
                Image($r('app.media.xiaoqu1'))
                  .width(60)
                  .height(60)
                  .borderRadius(8)
                  .margin({ right: 10 });

                Column() {
                  Text('可口可乐含糖可乐888ml瓶')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Row() {
                    Text('￥').fontSize(12).fontColor('red');
                    Text('6').fontSize(16).fontColor('red');
                  }
                }

                Blank();

                Button() {
                  Text('+');
                }
                .margin({ right: 10 })
              }
              .padding(10)
              .backgroundColor('#FFF')
              .borderRadius(10)
              .margin({ bottom: 8 })
            })
          }
        }
        .width('70%')
        .height(300) // 限定高度才能滚动
        .padding(10)
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
      }
      .height('auto')
      .backgroundColor('#FFF')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}
