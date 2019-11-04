<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/5
  Time: 10:35
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
            <label class="layui-form-label">仓库</label>
            <div class="layui-input-inline">
                <select name="repositoryTypeName" id="repositoryType" lay-filter="">

                </select>
            </div>
        </div>
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
<h4 id="apply_font"></h4>
<table id="allot" lay-filter="allotList"></table>


<script type="text/html" id="barDemo1">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="repositoryChange" id="repositoryChange">调拨</a><font id="font"></font>
</script>
<script type="text/html" id="barDemo2">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="passApply">批准</a>
</script>
<script src="layui/layui.js"></script>
<script>
    //确定角色，管理员的话加载审核表格
    var roleId = ${emp.roleId}

    layui.use('table', function(){
        var table = layui.table;
        var $=layui.$;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 400
            ,url: 'repository/getRepositoryList' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'productList'
            ,cols: [[ //表头
                {field: 'id', title: 'repositoryId', hide:true}
                ,{field: 'status', title: '状态',width:130}
                ,{field: 'repositoryTypeName', title: '仓库', width:130,align:'center',sort:true}
                ,{field: 'productNo', title: '编号', width:130,align:'center'}
                ,{field: 'productName', title: '名称',align:'center', width:160}
                ,{field: 'typeName', title: '类型',align:'center', width:120,sort:true}
                ,{field: 'productSize', title: '规格',align:'center', width: 120}
                ,{field: 'productUnit', title: '计量单位',align:'center', width: 125}
                ,{field: 'productPlace', title: '产地',align:'center', width: 155}
                ,{field: 'productCount', title: '库存量', width: 130,align:'center',sort:true }
                ,{fixed: 'right', title:'操作', width: 270, align:'center', toolbar: '#barDemo1'}
            ]]
            // ,done: function(res, curr, count){
            //     var abc = "";
            //
            //     for (var i in res.data){
            //         abc += i +": "+ res.data[i].status;
            //         if(res.data[i].status == "待审核" ) {
            //             $("#repositoryChange").prop("display", true); //设置调拨按钮不可用
            //             $("#font").text("请勿重复调拨同一商品")
            //         }
            //     }
            //     alert(abc)
            // }
        });




        //监听行工具事件
        table.on('tool(productList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            var tr = obj.tr;
            if(layEvent === 'detail'){
                layer.open({
                    type: 2
                    ,title: '查看商品详细信息'
                    ,content: 'repository/showRepository/'+data.id
                    ,maxmin: true
                    ,area: ['750px', '400px']
                    ,btn: ['关闭']
                });
            } else if(layEvent === 'repositoryChange'){
                if(data.status == "待审核" ){
                    // tr.children("td").find("#repositoryChange").prop("display",true);
                    alert("请勿重复调拨同一商品")
                    tr.children("td").find("font").text("请勿重复调拨同一商品")
                    tr.children("td").find("font").css({color:"red"})
                }
                else {
                    layer.open({
                        type: 2
                        ,title: '商品调拨页面'
                        ,content: 'repository/repositoryChange/'+data.id
                        ,maxmin: true
                        ,area: ['750px', '400px']
                        ,btn: ['提交','关闭']
                        ,yes: function(index, layero){
                            //按钮【按钮一】的回调
                            var data = $(layero).find("iframe")[0].contentWindow.callbackdata() ;
                            if(data.allotCount > data.productCount){
                                alert("调拨数量 不能比 库存量 大 !!!")
                            }
                            else if(data.allotCount <= 0 ){
                                alert("调拨数量 不能小于等于 0 !!!")
                            }
                            else {
                                $.ajax({
                                    url:"repository/ApplyChange",
                                    type:"post",
                                    data:{fromRepositoryId:data.fromRepositoryId,   //源仓库
                                        toRepositoryId:data.toRepositoryId,     //目标仓库
                                        productNo:data.productNo,
                                        allotCount:data.allotCount,   //调拨数量
                                        statusId:1},
                                    dataType:"text",
                                    success:function (data) {
                                        if(data == "true"){
                                            alert("调拨申请提交成功，请等待审核！！！");
                                            // tr.children("td").find("#repositoryChange").prop("display",true);
                                            // tr.children("td").find("font").text("请勿重复调拨同一商品")
                                            table.reload('productList',{
                                                method:'post'       //重载仓库商品信息
                                                ,where:{} });
                                            if (roleId == 1 ){
                                                table.reload('allotList',{                //管理员的话,还重载调拨单信息
                                                    method:'post'
                                                    ,where:{} });
                                            }
                                            layer.close(index);
                                        }
                                        else {
                                            alert("调拨申请提交失败");
                                        }
                                    }
                                })
                            }
                        }
                    });
                }

            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var productNo = $('#productNo').val();
            var productName = $('#productName').val();
            var typeNo=$("#type option:selected").val();
            var repositoryTypeName=$("#repositoryType option:selected").val();
            table.reload('productList', {
                method: 'post'
                , where: {
                    'productNo': productNo,
                    'productName': productName,
                    'typeNo':typeNo,
                    'repositoryTypeName':repositoryTypeName
                }
            });
        });

        //加载管理员审核表格
        if(roleId == 1){
            $("#apply_font").text("管理员页面：调拨审核");
            table.render({
                elem: '#allot'
                ,height: 400
                ,url: 'repository/getRepositoryAllotList' //数据接口
                ,toolbar: '#toolbarDemo'//开启头部工具栏
                ,page: {
                    layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                    , curr: 1
                    , groups: 1
                    , limit: 10
                }//开启分页
                ,id:'allotList'
                ,cols: [[ //表头
                    {field: 'repositoryallotId', title: 'repositoryallotId', hide:true}
                    ,{field: 'id', title: 'repositoryId', hide:true}
                    ,{field: 'fromRepositoryName', title: '源仓库', width:130,align:'center',sort:true}
                    ,{field: 'toRepositoryName', title: '目标仓库', width:130,align:'center'}
                    ,{field: 'productNo', title: '编号', width:130,align:'center'}
                    ,{field: 'productName', title: '名称',align:'center', width:160}
                    ,{field: 'typeName', title: '类型',align:'center', width:120,sort:true}
                    ,{field: 'productSize', title: '规格',align:'center', width: 120}
                    ,{field: 'productCount', title: '库存量', width: 130,align:'center',sort:true }
                    ,{field: 'allotCount', title: '调拨数量', width: 130,align:'center',sort:true }
                    ,{field: 'status', title: '状态', width: 130,align:'center'}
                    ,{fixed: 'right', title:'操作', width: 270, align:'center', toolbar: '#barDemo2'}
                ]]
            });
        }
        //监听行工具事件
        table.on('tool(allotList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.open({
                    type: 2
                    ,title: '查看商品详细信息'
                    ,content: 'repository/showRepository/'+data.id
                    ,maxmin: true
                    ,area: ['750px', '400px']
                    ,btn: ['关闭']
                });
            } else if(layEvent === 'passApply'){
                if(confirm("是否通过并执行该操作？")){
                    $.ajax({
                        url:"repository/DoAllot",
                        type:"post",
                        data:{repositoryallotId:data.repositoryallotId,
                            fromRepositoryId:data.fromRepositoryId,
                            toRepositoryId:data.toRepositoryId,
                            productNo:data.productNo,
                            allotCount:data.allotCount},
                        dataType:"text",
                        success:function (data) {
                            if (data == "true"){
                                alert("该调拨申请已通过并执行")
                                //重载两个表格
                                table.reload('productList',{
                                    method:'post'
                                    ,where:{} } );
                                table.reload('allotList',{
                                    method:'post'
                                    ,where:{} } );
                            }else if (data == "false") {
                                alert("调拨操作失败")
                            }
                        }
                    })
                }
            }
        });

    });


    layui.use('element',function () {
        //异步获取所有Type
        var $=layui.$;
        $.ajax({
            url:"repository/getRepositoryType",
            type:"post",
            dataType:"json",
            success:function (data) {
                var options="<option value=''>—请选择—</option>";
                for (var i in data){
                    options +="<option value='"+data[i].repositoryTypeName+"'>"+data[i].repositoryTypeName+"</option>"
                }
                $("#repositoryType").html(options);
            }
        });
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
