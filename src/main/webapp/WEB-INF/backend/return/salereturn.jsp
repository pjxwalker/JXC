<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/5
  Time: 15:53
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
            <label class="layui-form-label">销售单编号</label>
            <div class="layui-input-inline">
                <input type="text" id="saleNo" name="saleNo" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">销售人</label>
            <div class="layui-input-inline">
                <input type="text" id="saler" name="saler" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" id="do_search"  class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="">
                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
            </button>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">退货仓库</label>
            <div class="layui-input-block">
                <select lay-filter="repository" class="layui-select" id="repositoryName"><option>--选择仓库--</option></select>
            </div>
        </div>
    </div>
</form>
<table id="demo" lay-filter="saleList"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="layui/layui.js"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var form =layui.form;
        var $=layui.$;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 600
            ,url: 'return/getSaleInfoList' //数据接口
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'saleList'
            ,cols: [[ //表头
                {field: 'saleId', title: 'ID',width:130 ,hide:true}
                ,{field: 'saleNo', title: '销售订单编号', width:130,align:'center',sort:true}
                ,{field: 'saler', title: '销售人',align:'center', width:120,sort:true}
                ,{field: 'proposer', title: '申请人',align:'center', width: 120}
                ,{field: 'phone', title: '联系电话',align:'center', width: 155}
                ,{field: 'explains',title: '退货说明',align:'center', width: 170}
                ,{field: 'totalPrice', title: '销售总价', width: 130,align:'center',sort:true }
                ,{field: 'createTime', title: '销售时间',align:'center', width: 125}
                ,{fixed: 'right', title:'操作', width: 170, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(saleList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event //获得 lay-event 对应的值
                ,reName=$("#repositoryName").find("option:selected").text()
                ,reId=$("#repositoryName").val();
            if(layEvent === 'detail'){
                if(reName!="--选择仓库--")
                {
                    layer.open({
                        type: 2
                        ,title: '查看销售订单详细信息'
                        ,content: 'return/showSaleInfo/'+data.saleNo+"/"+data.saler+"/"+reName+"/"+reId
                        ,maxmin: true
                        ,area: ['1000px', '400px']
                        ,btn: ['关闭']
                    });
                }
                else
                {
                    layer.alert("请选择仓库");
                }
            }
            else if(layEvent === 'del'){
                if(reName!="--选择仓库--")
                {
                    layer.confirm('确定要删除编号：【'+data.saleNo+"】的销售订单吗？", function(index){
                        //向服务端发送删除指令
                        $.ajax({
                            url:"return/deleteSaleMaster",
                            data:{"saleNo":data.saleNo,"reId":reId},
                            dataType:"text",
                            type:"post",
                            success:function (data) {
                                if (data=="true"){
                                    obj.del(); //删除对应行（tr）的DOM结构
                                    layer.close(index);
                                    table.reload('saleList');
                                } else{
                                    alert("对不起，删除失败!");
                                }
                            }
                        })
                    });
                }
                else
                {
                    layer.alert("请选择仓库");
                }
            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var saleNo = $('#saleNo').val();
            var saler = $('#saler').val();
            table.reload('saleList', {
                method: 'post'
                , where: {
                    'saleNo': saleNo
                    ,'saler':saler
                }
            });
        });

        $.ajax({
            url:"return/getRepositoryName",
            type:"post",
            dataType:"json",
            success:function (data) {
                for(var i in data)
                {
                    var option="<option value='"+data[i].repositoryTypeId+"'>"+data[i].repositoryTypeName+"</option>";
                    $("#repositoryName").append(option);
                    form.render('select');
                }
            }
        });

        form.on('select',function (data) {
            if(data.value=="--选择仓库--")
            {
                layer.alert("仓库未选择")
            }
            else
            {
                layer.alert("你选择了"+$("#repositoryName").find("option:selected").text());
            }

        })

    });





</script>



</body>
</html>
