<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/1
  Time: 11:11
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
            <label class="layui-form-label">客户名称</label>
            <div class="layui-input-inline">
                <input type="text" name="cusName" lay-verify="cusName"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">客户简称</label>
            <div class="layui-input-inline">
                <input type="text" name="cusShortName" lay-verify="cusShortName"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">地址</label>
            <div class="layui-input-inline">
                <input type="text" name="cusAddress" lay-verify="cusAddress"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">邮编</label>
            <div class="layui-input-inline">
                <input type="text" name="cusPostCode" lay-verify="cusPostCode"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-inline">
                <input type="text" name="cusPhone" lay-verify="cusPhone"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">传真</label>
            <div class="layui-input-inline">
                <input type="text" name="cusFax" lay-verify="cusFax"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">联系人</label>
            <div class="layui-input-inline">
                <input type="text" name="cusContact" lay-verify="cusContact"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">联系人电话</label>
            <div class="layui-input-inline">
                <input type="text" name="cusContactPhone" lay-verify="cusContactPhone"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开户银行</label>
            <div class="layui-input-inline">
                <input type="text" name="cusBank" lay-verify="cusBank"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">银行卡号</label>
            <div class="layui-input-inline">
                <input type="text" name="cusBankCard" lay-verify="cusBankCard"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">电子邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="cusEmail" lay-verify="cusEmail"  autocomplete="off" class="layui-input">
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
            cusName: function(value){
                if(value.length <=0){
                    return '供应商名称不能为空！';
                }
            }
            ,cusContact: function (value) {
                if (value.length<=0) {
                    return '联系人不能为空！';
                }
            },cusContactPhone: function (value) {
                if (value.length<=0) {
                    return '联系人电话不能为空！';
                }
            },cusBank: function (value) {
                if (value.length<=0) {
                    return '开户银行不能为空！';
                }
            },cusBankCard: function (value) {
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
                url:"customer/addcustomer",
                type:"post",
                data:$("#myform").serialize(),
                dataType:"text",
                success:function (data) {
                    if (data=="true"){
                        parent.layer.close(index); //再执行关闭
                        parent.layui.table.reload('customerList');//重载表格
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
