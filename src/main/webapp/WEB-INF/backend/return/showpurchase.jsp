<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/1
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="http://localhost:8080/jxc/">
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">订单编号</label>
            <div class="layui-input-inline">
                <input type="text" id="purchaseNo" name="purchaseNo" readonly autocomplete="off" class="layui-input" value="${purchaseNo}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">采购人</label>
            <div class="layui-input-inline">
                <input type="text" id="purchaser" name="purchaser" readonly autocomplete="off" class="layui-input" value="${purchaser}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">商品名</label>
            <div class="layui-input-inline">
                <input type="text" id="productName" name="productName" placeholder="请输入" autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品类型</label>
            <div class="layui-input-inline">
                <input type="text" id="typeName" name="typeName" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" id="do_search"  class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="">
                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
            </button>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
    </div>
</form>
<table id="demo" lay-filter="DpurchaseList"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="del">部分退货</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="alldel">商品全退</a>
</script>
<script src="layui/layui.js"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var $=layui.$;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: 'purchase/getDetailPurchaseInfoList/' //数据接口
            ,where:{purchaseNo:$('#purchaseNo').val()}
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'DpurchaseList'
            ,cols: [[ //表头
                {field: 'detailId', title: 'ID',width:130 ,hide:true}
                ,{field: 'productName', title: '商品名', width:130,align:'center',sort:true}
                ,{field: 'typeName', title: '商品类型',align:'center', width:120}
                ,{field: 'productSize', title: '商品规格',align:'center', width:120}
                ,{field: 'productInPrice', title: '进货价',align:'center', width:120,sort:true}
                ,{field: 'productNumber', title: '产品数量',align:'center', width: 120,sort:true}
                ,{field: 'returnNumber',title:'退货数量',align:'center',width:120,edit:true}
                ,{field: 'subtotal', title: '小计',align:'center', width: 155}
                ,{fixed: 'right', title:'操作', width: 170, align:'center', toolbar: '#barDemo'}
            ]]
        });
        table.on('tool(DpurchaseList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
              if(layEvent === 'del'){
                    //向服务端发送删除指令
                  var re= /^[1-9]+[0-9]*]*$/;
                  if(re.test(data.returnNumber))
                  {
                      if(data.returnNumber>0&&data.returnNumber<data.productNumber){
                          layer.confirm('确定要对'+data.returnNumber+'件商品【'+data.productName+"】退货吗？", function(index) {
                              $.ajax({
                                  url: "purchase/returnPurchase",
                                  data: {"detailId": data.detailId,"returnNumber":data.returnNumber,"productNumber":data.productNumber,"productInPrice":data.productInPrice,"subtotal":data.subtotal},
                                  dataType: "text",
                                  type: "post",
                                  success: function (data) {
                                      if (data == "true") {
                                          layer.close(index);
                                          table.reload('DpurchaseList');
                                          parent.layui.table.reload('purchaseList');
                                      } else {
                                          alert("对不起，删除失败!");
                                      }
                                  }
                              })
                          });
                      }
                      else {layer.alert("退货数量不能过多")}
                  }

                  else
                  {
                      layer.alert("请输入整型数字");
                  }


            }
              else if(layEvent === 'alldel')
              {
                  layer.confirm('确定要对商品【'+data.productName+"】从采购单删除吗？", function(index) {
                      $.ajax({
                          url: "purchase/deletePurchaseProduct",
                          data: {"detailId": data.detailId,"subtotal":data.subtotal},
                          dataType: "text",
                          type: "post",
                          success: function (data) {
                              if (data == "true") {
                                  layer.close(index);
                                  table.reload('DpurchaseList');
                                  parent.layui.table.reload('purchaseList');
                              } else {
                                  alert("对不起，删除失败!");
                              }
                          }
                      })
                  });
              }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var productName = $('#productName').val();
            var typeName = $('#typeName').val();
            table.reload('DpurchaseList', {
                method: 'post'
                , where: {
                    'productName': productName
                    ,'typeName':typeName
                }
            });
        });
    });


</script>

</body>
</html>
