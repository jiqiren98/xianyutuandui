var express = require('express');
var router = express.Router();
const {user} = require('../../databases/date')
/* GET users listing. */
router.post('/login',async function(req, res, next) {
  try {
    const { username, password } = req.body;
    
    // 根据用户名查找用户
    const findUser = await user.findOne({ username });
    
    if (!findUser) {
      return res.send({
        code: "400",
        message: "用户不存在"
      });
    }
    
    // 验证密码
    if (findUser.password !== password) {
      return res.send({
        code: "400",
        message: "密码错误"
      });
    }
    
    // 登录成功
    res.send({
      code: "200",
      message: "登录成功",
      data: {
        username: findUser.username,
        name: findUser.name,
        _id: findUser._id,
        password: findUser.password,
        dizhi: findUser.dizhi,
        kajuan: findUser.kajuan,
        mani: findUser.mani,
        jifen:findUser.jifen,
        vip:findUser.vip,
        stock:findUser.stock,}
    });
  } catch (error) {
    res.send({
      code: "500",
      message: "服务器错误",
      error: error.message
    });
  }
});

module.exports = router;
