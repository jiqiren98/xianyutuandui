var express = require('express');
var router = express.Router();
const {Order} = require('../../databases/date.js')
/* GET users listing. */
router.get('/index',async function(req, res, next) {
  const find = await DateModule.DatesModule.find()
  res.send({
    code:"200",
    date:find
  });
});
// 获取所有订单
router.get('/orders', async (req, res) => {
  try {
    const orders = await Order.find();
    res.status(200).json({
      success: true,
      count: orders.length,
      data: orders
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: '服务器错误'
    });
  }
});

// 根据ID获取订单详情
router.get('/orders/:id', async (req, res) => {
  try {
    const order = await Order.findById(req.params.id);
    
    if (!order) {
      return res.status(404).json({
        success: false,
        error: '订单不存在'
      });
    }
    
    res.status(200).json({
      success: true,
      data: order
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: '服务器错误'
    });
  }
});

module.exports = router;    