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
<table id="demo" lay-filter="productList"></table>

<script src="layui/layui.js"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var $=layui.$;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: 'purchase/purchaseDetail' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 5
            }//开启分页
            ,id:'purchaseDetail'
            ,cols: [[ //表头
                {field: 'purchaseId', title: 'ID', hide:true}
                ,{field: 'purchaseNo', title: '采购订单编号', width:160,align:'center', fixed: 'left'}
                ,{field: 'purchaser', title: '经手人',align:'center', width:160}
                ,{field: 'productName', title: '商品名称',align:'center', width:160,sort:true}
                ,{field: 'productNumber', title: '采购数量',align:'center', width: 160}
                ,{field: 'productUnit', title: '单位',align:'center', width: 160}
                ,{field: 'subtotal', title: '小结',align:'center', width: 160}
                ,{field: 'proposer', title: '申请人',align:'center', width: 160}
                ,{field: 'createTime', title: '采购时间',align:'center', width: 180}
                ,{field: 'explains', title: '附带信息',align:'center', width: 180}
            ]]
        });

    });



</script>
</body>
</html>
