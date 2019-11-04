<!DOCTYPE html>
<html lang="en">
<head>
    <base href="http://localhost:8080/jxc/">
    <%@page isELIgnored="false" pageEncoding="UTF-8" %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>进销存后台管理平台</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<form class="layui-form" action="" style="padding: 30px;">
    <div class="layui-form-item">
        <label class="layui-form-label">当前密码</label>
        <div class="layui-input-block">
            <input type="password" id="oldpwd"  lay-verify="oldpwd" autocomplete="off"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码</label>
        <div class="layui-input-block">
            <input type="password" id="newpwd"  lay-verify="newpwd" autocomplete="off" placeholder="6到16个字符" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">确认新密码</label>
        <div class="layui-input-block">
            <input type="password" id="conpwd"  lay-verify="conpwd" autocomplete="off"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
        <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
    </div>
</form>
<script src="layui/layui.js"></script>
<script>
    layui.use(['form'], function() {
        var form = layui.form
        var $ = layui.$;
        //自定义验证规则
        $("#oldpwd").on("blur",function () {
            var oldPwd=$("#oldpwd").val();
            $.ajax({
                type:"post",
                data:{"oldpwd":oldPwd},
                url:"checkPwd",
                dataType:"text",
                success:function (data) {
                    if (data=="false"){
                        $("#oldpwd").val("0000");
                        $("#layuiadmin-app-form-submit").click();
                    }
                }
            });
        });
        form.verify({
            oldpwd:function(value){
                if (value.length<=0){
                    return "旧密码不能为空！"
                }else if(value=="0000"){
                    return "当前密码错误，无法进行修改"
                }
            }
            ,newpwd: [/^[\S]{6,12}$/,'密码必须6到12位，且不能出现空格']
            ,conpwd:function (value) {
                if ($("#newpwd").val()!=value) {
                    return "前后密码不一致！"
                }
            }
        });

        //监听提交
        form.on('submit(layuiadmin-app-form-submit)', function(data){
            var field = data.field; //获取提交的字段
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引

            //提交 Ajax 成功后，关闭当前弹层
            $.ajax({
                url:"modifyPwd",
                type:"post",
                data:{"newPwd":$("#newpwd").val()},
                dataType:"text",
                success:function (data) {
                    if (data=="true"){
                        alert("密码修改成功！")
                        parent.layer.close(index); //再执行关闭
                    } else{
                        alert("对不起，密码修改失败！")
                    }
                }
            })

        });
    });
</script>
</body>
</html>