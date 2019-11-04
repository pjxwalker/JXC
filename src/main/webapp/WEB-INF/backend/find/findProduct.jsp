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
            <label class="layui-form-label">商品编号</label>
            <div class="layui-input-inline">
                <input type="text" id="productNo" name="productNo" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品名称</label>
            <div class="layui-input-inline">
                <input type="text" id="productName" name="productName" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品类型</label>
            <div class="layui-input-inline">
                <select name="typeNo" id="type" lay-filter="">

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
            ,url: 'product/getProductInfoList' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'productList'
            ,cols: [[ //表头
                {field: 'productId', title: 'ID', hide:true}
                ,{field: 'productNo', title: '编号', width:130,align:'center', fixed: 'left'}
                ,{field: 'productName', title: '名称',align:'center', width:160}
                ,{field: 'typeName', title: '类型',align:'center', width:120,sort:true}
                ,{field: 'productSize', title: '规格',align:'center', width: 120}
                ,{field: 'productUnit', title: '计量单位',align:'center', width: 125}
                ,{field: 'productPlace', title: '产地',align:'center', width: 155}
                ,{fixed: 'right', title:'操作', width: 170, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(productList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.open({
                    type: 2
                    ,title: '查看商品详细信息'
                    ,content: 'product/showProductInfo/'+data.productId
                    ,maxmin: true
                    ,area: ['700px', '400px']
                    ,btn: ['关闭']
                });
            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var productNo = $('#productNo').val();
            var productName = $('#productName').val();
            var typeNo=$("#type option:selected").val();
            table.reload('productList', {
                method: 'post'
                , where: {
                    'productNo': productNo,
                    'productName': productName,
                    'typeNo':typeNo
                }
            });
        });
    });

    layui.use('element',function () {
        //异步获取所有角色
        var $=layui.$;
        $.ajax({
            url:"product/getTypeList",
            data:{},
            type:"post",
            dataType:"json",
            success:function (data) {
                var options="<option value=''>—请选择—</option>";
                for(var i=0;i<data.length;i++){
                    options+="<option value='"+data[i].typeNo+"'>"+data[i].typeName+"</option>";
                }
                $("#type").html(options);
            }
        });
    });

</script>
</body>
</html>

