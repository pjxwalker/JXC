<%--
  Created by IntelliJ IDEA.
  User: dick
  Date: 2019/7/28
  Time: 9:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <base href="http://localhost:8080/jxc/">
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">采购单号</label>
            <div class="layui-input-inline">
                <input type="text" id="purchaseNo" name="purchaseNo" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">经手人</label>
            <div class="layui-input-inline">
                <input type="text" id="purchaser" name="purchaser" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" id="do_search"  class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="">
                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
            </button>
        </div>
    </div>
</form>
<table id="demo" lay-filter="productList"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看详情</a>
</script>
<script src="layui/layui.js"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var $=layui.$;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 600
            ,url: 'purchase/purchaseList' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'purchaseList'
            ,cols: [[ //表头
                {field: 'purchaseId', title: 'ID', hide:true}
                ,{field: 'purchaseNo', title: '采购订单编号', width:180,align:'center', fixed: 'left'}
                ,{field: 'purchaser', title: '经手人',align:'center', width:180}
                ,{field: 'purchaseTime', title: '采购时间',align:'center', width:180,sort:true}
                ,{field: 'totalPrice', title: '采购总价￥',align:'center', width: 180}
                ,{field: 'status', title: '状态',align:'center', width: 180}
                ,{fixed: 'right', title:'操作', width: 180, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(productList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.open({
                    type: 2
                    ,title: '查看采购订单详情'
                    ,content: 'purchase/getPurchaseByNo?purchaseNo='+data.purchaseNo
                    ,maxmin: true
                    ,area: ['900px', '450px']
                    ,btn: ['关闭']
                });
            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var purchaseNo = $('#purchaseNo').val();
            var purchaser = $('#purchaser').val();
            table.reload('purchaseList', {
                method: 'post'
                , where: {
                    'purchaseNo': purchaseNo,
                    'purchaser': purchaser
                }
            });
        });
    });



</script>
</body>
</html>
