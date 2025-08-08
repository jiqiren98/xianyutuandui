var express = require("express");
var router = express.Router();
const { user } = require("../../databases/date");
/* GET users listing. */
router.post("/login", async function (req, res, next) {
  
  const { username, password } = req.body;
  const data = await user.findOne({ username });
  
  console.log('====================================');
  console.log(data);
  console.log('====================================');
  if (data) {
    // 验证密码
    if (data.password === password) {
      console.log("密码匹配，登录成功");
      res.send({
        code: 200,
        data: {
          username: data.username,
          password: data.password,
          id:data._id,
         
        },
      });
    } else if(data.username!=username) {
      console.log("用户不存在");
      res.send({ code: 301, message: "用户不存在" });
    }
  } else {
    res.send({ code: 300, message: "密码错误" });
  }
  
});
router.get("/get", async function (req, res, next) {
  const data = await user.find({ });
 // 验证密码
      res.send({
        code: 200,
        data: data
      });
  
})
module.exports = router;
