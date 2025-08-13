const { mongo } = require('mongoose')
const mongoose = require('./database')
const { text } = require('body-parser')

const shopdatebas = new mongoose.Schema({
    name: String,
    type: Number
})
const shopDatesModule = mongoose.model('shopdatebas', shopdatebas, 'shopdatebas')

const shopsdatebas = new mongoose.Schema({
    name: String,
    price: Number,
    num: Number,
    type: Number,
    types: Number
})
const shopsDatesModule = mongoose.model('shopsdatebas', shopdatebas, 'shopsdatebas')

const MessageSheam = new mongoose.Schema({
    content: String,//发送的消息内容
    messageType: {
        type: String,
        default: "小区活动"
    },
    startTime: {
        type: Date,
        default: Date.now()
    },
    textname: String,//消息标头
})
const MessageModule = mongoose.model('mesage', MessageSheam, 'mesage')

const propertySheam = new mongoose.Schema({
    name: {//用户
        type: mongoose.Schema.Types.ObjectId,
        ref: 'property'
    },
    startTime: { //缴费时间
        type: Date,
        default: Date.now()
    },
    many: Number,//缴费金额

})
const propertyModule = mongoose.model('property', propertySheam, 'property')
const username = new mongoose.Schema({
    username: String,
    password: String,
    kajuan: String,
    name: String,
    stock: String,
    vip: String,
    jifen: String,
    dizhi: String,
    mani: String


})
const user = mongoose.model('user', username, 'user')


// 定义商品信息子模型
const ProductItemSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    count: {
        type: Number,
        required: true,
        min: 1
    },
    price: {
        type: Number,
        required: true,
        min: 0
    },
    image: {
        type: String,
        required: true,
        trim: true
    }
});

// 主订单模型
const OrderSchema = new mongoose.Schema({
    status: {
        type: String,
        required: true,
        trim: true,
        // 订单状态枚举
        enum: ['进行中', '已完成', '已取消', '已退款', '待支付']
    },
    userInfo:{ 
        type: mongoose.Schema.Types.ObjectId, // 关联用户ID
        ref: 'user', // 关联到User模型
        required: true // 必须关联一个用户
    },
    deliveryAddress: {
        type: String,
        required: true,
        trim: true
    },
    orderTime:  {
        type: Date,
        default: Date.now
    },
    orderRemark: {
        type: String,
        default: '无',
        trim: true
    },
    products: {
        type: [ProductItemSchema],
        required: true,
        minlength: 1
    },
    totalCount: {
        type: Number,
        required: true,
        min: 0,
        default: 0
    },
    totalPrice: {
        type: Number,
        required: true,
        min: 0
    },
    cancelBtnVisible: {
        type: Boolean,
        default: true
    },
    from: {
        type: String,
        required: true
    }
});


const  Order = mongoose.model('Order', OrderSchema, 'Order');

module.exports = {
    MessageModule,
    user,
    propertyModule,
    Order,
    shopDatesModule,
    shopsDatesModule
}
