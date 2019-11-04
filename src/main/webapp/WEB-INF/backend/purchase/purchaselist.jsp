<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/31
  Time: 16:10
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
                <label class="layui-form-label">订单编号</label>
                <div class="layui-input-inline">
                    <input type="text" id="purchaseNo" name="purchaseNo" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">申请人</label>
                <div class="layui-input-inline">
                    <input type="text" id="proposer" name="proposer" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">申请部门</label>
                <div class="layui-input-inline">
                    <input type="text" id="applyBranch" name="applyBranch" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <button id="do_search" type="button" class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="">
                    <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                </button>
            </div>
        </div>
    </form>
    <table id="demo" lay-filter="purchaseList"></table>
<script type="text/html" id="toolbarDemo">
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-sm" lay-event="checkStauts">审核</a>
</script>
<script src="layui/layui.js"></script>
    <script>
        layui.use(['form', 'table'], function(){
            var table = layui.table;
            var form =layui.form;
            var $=layui.$;
            //第一个实例
            table.render({
                elem: '#demo'
                ,height: 600
                ,url: 'purchase/getPurchaseList' //数据接口
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
                    ,{field: 'purchaseNo', title: '编号', width:140,align:'center', fixed: 'left'}
                    ,{field: 'purchaser', title: '采购人',align:'center', width:110}
                    ,{field: 'proposer', title: '申请人',align:'center', width:110}
                    ,{field: 'applyBranch', title: '申请部门',align:'center', width: 120}
                    ,{field: 'purchaseTime', title: '采购时间',align:'center', width: 125,sort:true}
                    ,{field: 'totalPrice', title: '合计(￥)',align:'center', width: 130}
                    ,{field: 'explains', title: '说明',align:'center', width: 155}
                    ,{field: 'statusName', title: '状态', width: 120,align:'center'}
                    ,{fixed: 'right', title:'操作', width: 100, align:'center', toolbar: '#barDemo'}
                ]]
            });
            //监听行工具事件
            table.on('tool(purchaseList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'checkStauts'){
                    layer.open({
                        type: 2
                        ,title: '查看采购订单详细信息'
                        ,content: 'purchase/getPurchase/'+data.purchaseId
                        ,maxmin: true
                        ,area: ['1000px', '440px']
                        ,btn: ['审核通过','审核不通过']
                        ,yes:function (index,layero) {
                            //点击确认触发 iframe 内容中的按钮提交
                            var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                            if (confirm("确定审核通过该采购订单吗？")) {
                                $.ajax({
                                    url:"purchase/updateStatus",
                                    data:{"statusId":2,"purchaseId":data.purchaseId},
                                    type:"post",
                                    dataType:"text",
                                    success:function (data) {
                                        if (data=="true"){
                                            alert("审核成功！");
                                            layer.close(index);
                                            table.reload("purchaseList");
                                        } else{
                                            alert("对不起，审核失败！");
                                        }
                                    }
                                })
                            }

                        }
                        ,btn2:function(index,layero){
                            var edit = layero.find('iframe').contents().find("#layuiadmin-app-form-edit");
                            if (confirm("确定审核不通过该采购订单吗？")) {
                                $.ajax({
                                    url:"purchase/updateStatus",
                                    data:{"statusId":3,"purchaseId":data.purchaseId},
                                    type:"post",
                                    dataType:"text",
                                    success:function (data) {
                                        if (data=="true"){
                                            alert("审核成功！");
                                            table.reload();
                                        } else{
                                            alert("对不起，审核失败！");
                                        }
                                    }
                                })
                            }
                        }
                    });
                }
            });
            // 执行搜索，表格重载
            $('#do_search').on('click', function () {
                // 搜索条件
                var purchaseNo = $('#purchaseNo').val();
                var applyBranch = $('#applyBranch').val();
                var proposer=$("#proposer").val();
                table.reload('purchaseList', {
                    method: 'post'
                    , where: {
                        'purchaseNo': purchaseNo,
                        'proposer':proposer,
                        'applyBranch':applyBranch
                    }
                });
            });
        });
    </script>
</body>
</html>