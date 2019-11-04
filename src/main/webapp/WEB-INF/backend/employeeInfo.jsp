<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/5
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <base href="http://localhost:8080/jxc/">
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>
<form class="layui-form" id="myform" action="" style="padding-top: 10px;padding-right:30px;">
    <input type="hidden" name="empId" value="${map.empId}">
    <div class="layui-form-item">
        <label class="layui-form-label">员工编号</label>
        <div class="layui-input-block">
            <input type="text" value="${map.empNo}" readonly name="empNo"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">员工姓名</label>
        <div class="layui-input-block">
            <input type="text" name="empName" lay-verify="empName" value="${map.empName}"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性&nbsp;&nbsp;别</label>
        <div class="layui-input-block">
            <select name="empSex" lay-filter="aihao">
                <c:if test="${map.empSex==0}">
                    <option value="">-请选择-</option>
                    <option value="0" selected>女</option>
                    <option value="1" >男</option>
                </c:if>
                <c:if test="${map.empSex==1}">
                    <option value="">-请选择-</option>
                    <option value="0" >女</option>
                    <option value="1" selected>男</option>
                </c:if>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">政治面貌</label>
        <div class="layui-input-block">
            <select name="empPolitics" lay-filter="aihao">
                <option value="">-请选择-</option>
                <option value="群众" selected>群众</option>
                <option value="团员">团员</option>
                <option value="预备党员">预备党员</option>
                <option value="党员">党员</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">职&nbsp;&nbsp;务</label>
        <div class="layui-input-block">
            <input type="text" readonly value="${map.roleName}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">出生日期</label>
        <div class="layui-input-block">
            <input type="text" value="${map.empBirthday}" name="empBirthday" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">电话号码</label>
        <div class="layui-input-block">
            <input type="tel" name="empPhone" value="${map.empPhone}" lay-verify="required|phone" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">电子邮箱</label>
        <div class="layui-input-block">
            <input type="text" name="empEmail" value="${map.empEmail}" lay-verify="email" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">籍&nbsp;&nbsp;贯</label>
        <div class="layui-input-block">
            <input type="text" name="empAddress" value="${map.empAddress}" lay-verify="" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">邮箱编号</label>
        <div class="layui-input-block">
            <input type="tel" name="empPostCode" value="${map.empPostCode}" lay-verify="postcode" autocomplete="off" class="layui-input">
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
        //日期
        laydate.render({
            elem: '#date'
        });
        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');
        //自定义验证规则
        form.verify({
            empName: function(value){
                if(value.length <=0){
                    return '姓名不能为空！';
                }
            }
            ,postcode: function (value) {
                if (value.length>0 && value.length>6) {
                    return '地址邮箱必须6位，且不能出现空格';
                }
            },content: function(value){
                layedit.sync(editIndex);
            }
        });


        //监听提交
        form.on('submit(layuiadmin-app-form-submit)', function(data){
            var field = data.field; //获取提交的字段
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引

            //提交 Ajax 成功后，关闭当前弹层并重载表格
            if (confirm("确定修改基本信息？")){
                $.ajax({
                    url:"emp/modifyemp",
                    type:"post",
                    data:$("#myform").serialize(),
                    dataType:"text",
                    success:function (data) {
                        if (data=="true"){
                            alert("修改成功！")
                            parent.layer.close(index); //再执行关闭
                        }else{
                            alert("对不起，修改失败!");
                        }
                    }
                });
            }
        });

    });
</script>
</body>
</html>
