<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/5
  Time: 11:29
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
            <label class="layui-form-label">供应商名称</label>
            <div class="layui-input-inline">
                <input type="text" id="proName" name="proName" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" id="do_search"  class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="">
                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
            </button>
        </div>
    </div>
</form>
<table id="demo" lay-filter="providerList"></table>
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
            ,url: 'provider/getProviderInfoList' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'providerList'
            ,cols: [[ //表头
                {field: 'proId', title: 'ID',width:130 ,hide:true}
                ,{field: 'proName', title: '名称', width:130,align:'center',sort:true}
                ,{field: 'proAddress', title: '地址',align:'center', width:120}
                ,{field: 'proPostCode', title: '邮编',align:'center', width: 120}
                ,{field: 'proFax', title: '传真',align:'center', width: 155}
                ,{field: 'proContact', title: '联系人', width: 130,align:'center',sort:true }
                ,{field: 'proContactPhone', title: '联系人电话',align:'center', width: 125}
                ,{fixed: 'right', title:'操作', width: 170, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(providerList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.open({
                    type: 2
                    ,title: '查看商品详细信息'
                    ,content: 'provider/showProviderInfo/'+data.proId
                    ,maxmin: true
                    ,area: ['700px', '400px']
                    ,btn: ['关闭']
                });
            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var proName = $('#proName').val();
            table.reload('providerList', {
                method: 'post'
                , where: {
                    'proName': proName
                }
            });
        });
    });


</script>
</body>
</html>