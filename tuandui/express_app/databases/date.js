const { mongo } = require('mongoose')
const mongoose = require('./database')
const { text } = require('body-parser')

const shopDatesRouple = new mongoose.Schema({
    name:String,
    type:Number
})
const shopDatesModule = mongoose.model('shopdatebas',shopDatesRouple,'shopdatebas')

const shopsDatesRouple = new mongoose.Schema({
    name:String,
    price:Number,
    num:{
        default:0,
        type:Number
    },
    shopdatebasId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'shopdatebas'
    }
})
const shopsDatesModule = mongoose.model('shopsdatebas',shopsDatesRouple,'shopsdatebas')

const MessageSheam = new mongoose.Schema({
    content:String,//发送的消息内容
    messageType:{
    type:String,
    default:"小区活动"
    },
    startTime:{
        type:Date,
        default:Date.now()
    },
    textname:String,//消息标头
})
const MessageModule = mongoose.model('mesage',MessageSheam,'mesage')

const propertySheam = new mongoose.Schema({
    name:{//用户
        type:mongoose.Schema.Types.ObjectId,
        ref:'property'
    },
    startTime:{ //缴费时间
        type:Date,
        default:Date.now()
    },
    many:Number,//缴费金额

})
const propertyModule = mongoose.model('property',propertySheam,'property')
const username = new mongoose.Schema({
   username:String,
   password:String,
   kajuan:String,
    name:String,
    stock:String,
    vip:String,
    jifen:String,
    dizhi:String,
    mani:String


})
const user = mongoose.model('user',username,'user')


module.exports = {
    shopDatesModule,
    shopsDatesModule,
    MessageModule,
    user,
    propertyModule
}