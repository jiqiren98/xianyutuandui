var express = require('express');
var router = express.Router();
const DataMdoule = require('../../databases/date')

/* GET users listing. */
router.get('/index',async function(req, res, next) {
  const {id} = req.query
  const ids = parseInt(id) + 1
  const find = await DataMdoule.shopDatesModule.find({type:ids})
  console.log(find)
  res.send({
    code:"200",
    data:find
  });
});


router.get('/indexs',async function(req, res, next) {
  const find = await DataMdoule.shopsDatesModule.find()
  res.send({
    code:"200",
    data:find
  });
});

module.exports = router;    