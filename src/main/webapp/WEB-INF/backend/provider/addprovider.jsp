<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/31
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <base href="http://localhost:8080/jxc/">
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>
<form class="layui-form" id="myform" action="">
    <div class="layui-form-item" style="padding-top:20px;">
        <div class="layui-inline">
            <label class="layui-form-label">供应商名称</label>
            <div class="layui-input-inline">
                <input type="text" name="proName" lay-verify="proName"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">供应商简称</label>
            <div class="layui-input-inline">
                <input type="text" name="proShortName" lay-verify="proShortName"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">地址</label>
            <div class="layui-input-inline">
                <input type="text" name="proAddress" lay-verify="proAddress"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">邮编</label>
            <div class="layui-input-inline">
                <input type="text" name="proPostCode" lay-verify="proPostCode"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
                <label class="layui-form-label">电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="proPhone" lay-verify="proPhone"  autocomplete="off" class="layui-input">
                </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">传真</label>
            <div class="layui-input-inline">
                <input type="text" name="proFax" lay-verify="proFax"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
                <label class="layui-form-label">联系人</label>
                <div class="layui-input-inline">
                    <input type="text" name="proContact" lay-verify="proContact"  autocomplete="off" class="layui-input">
                </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">联系人电话</label>
            <div class="layui-input-inline">
                <input type="text" name="proContactPhone" lay-verify="proContactPhone"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开户银行</label>
            <div class="layui-input-inline">
                <input type="text" name="proBank" lay-verify="proBank"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">银行卡号</label>
            <div class="layui-input-inline">
                <input type="text" name="proBankCard" lay-verify="proBankCard"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">电子邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="proEmail" lay-verify="proEmail"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
        <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
    </div>
</form>
<script src="layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
        //异步获取所有角色
        var $=layui.$;
        //自定义验证规则
        form.verify({
            proName: function(value){
                if(value.length <=0){
                    return '供应商名称不能为空！';
                }
            }
            ,proContact: function (value) {
                if (value.length<=0) {
                    return '联系人不能为空！';
                }
            },proContactPhone: function (value) {
                if (value.length<=0) {
                    return '联系人电话不能为空！';
                }
            },proBank: function (value) {
                if (value.length<=0) {
                    return '开户银行不能为空！';
                }
            },proBankCard: function (value) {
                if (value.length<=0) {
                    return '银行卡号不能为空！';
                }
            }
        });

        //监听提交
        form.on('submit(layuiadmin-app-form-submit)', function(data){
            var field = data.field; //获取提交的字段
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引

            //提交 Ajax 成功后，关闭当前弹层并重载表格
            $.ajax({
                url:"provider/addprovider",
                type:"post",
                data:$("#myform").serialize(),
                dataType:"text",
                success:function (data) {
                    if (data=="true"){
                        parent.layer.close(index); //再执行关闭
                        parent.layui.table.reload('providerList');//重载表格
                    }else{
                        alert("添加失败");
                    }
                }
            });
        });
    });
</script>
</body>
</html>