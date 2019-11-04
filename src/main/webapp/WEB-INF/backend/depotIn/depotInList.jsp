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
            <label class="layui-form-label">入库编号</label>
            <div class="layui-input-inline">
                <input type="text" id="depotInNo" name="depotInNo" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">经手人</label>
            <div class="layui-input-inline">
                <input type="text" id="empName" name="empName" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品名称</label>
            <div class="layui-input-inline">
                <select name="productName" id="productName" lay-filter="">

                </select>
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
            ,url: 'depotIn/depotInList' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'depotInList'
            ,cols: [[ //表头
                {field: 'depotInId', title: 'ID', hide:true}
                ,{field: 'depotInNo', title: '入库编号', width:180,align:'center', fixed: 'left'}
                ,{field: 'empName', title: '经手人',align:'center', width:180}
                ,{field: 'productName', title: '商品名称',align:'center', width:180,sort:true}
                ,{field: 'depotInTime', title: '入库时间',align:'center', width: 180}
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
                    ,title: '查看入库详情'
                    ,content: 'depotIn/getDetailByNo/'+data.depotInNo
                    ,maxmin: true
                    ,area: ['700px', '400px']
                    ,btn: ['关闭']
                });
            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var depotInNo = $('#depotInNo').val();
            var empName = $('#empName').val();
            var productName=$("#productName option:selected").val();
            table.reload('depotInList', {
                method: 'post'
                , where: {
                    'depotInNo': depotInNo,
                    'empName': empName,
                    'productName':productName
                }
            });
        });
    });

    layui.use('element',function () {
        //异步获取所有商品名称
        var $=layui.$;
        $.ajax({
            url:"depotIn/getAllProductName",
            data:{},
            type:"post",
            dataType:"json",
            success:function (data) {
                var options="<option value=''>—请选择—</option>";
                for(var i=0;i<data.length;i++){
                    options+="<option value='"+data[i]+"'>"+data[i]+"</option>";
                }
                $("#productName").html(options);
            }
        });
    });

</script>
</body>
</html>
