<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/5
  Time: 11:30
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
            <label class="layui-form-label">客户名称</label>
            <div class="layui-input-inline">
                <input type="text" id="cusName" name="cusName" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" id="do_search"  class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="">
                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
            </button>
        </div>
    </div>
</form>
<table id="demo" lay-filter="customerList"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
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
            ,url: 'customer/getCustomerInfoList' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'customerList'
            ,cols: [[ //表头
                {field: 'cusId', title: 'ID',width:130 ,hide:true}
                ,{field: 'cusName', title: '名称', width:130,align:'center',sort:true}
                ,{field: 'cusAddress', title: '地址',align:'center', width:120}
                ,{field: 'cusPostCode', title: '邮编',align:'center', width: 120}
                ,{field: 'cusFax', title: '传真',align:'center', width: 155}
                ,{field: 'cusContact', title: '联系人', width: 130,align:'center',sort:true }
                ,{field: 'cusContactPhone', title: '联系人电话',align:'center', width: 125}
                ,{fixed: 'right', title:'操作', width: 170, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(customerList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.open({
                    type: 2
                    ,title: '查看客户详细信息'
                    ,content: 'customer/showCustomerInfo/'+data.cusId
                    ,maxmin: true
                    ,area: ['700px', '400px']
                    ,btn: ['关闭']
                });
            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var cusName = $('#cusName').val();
            table.reload('customerList', {
                method: 'post'
                , where: {
                    'cusName': cusName
                }
            });
        });
    });


</script>
</body>
</html>

