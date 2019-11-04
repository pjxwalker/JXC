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
                <label class="layui-form-label">员工编号</label>
                <div class="layui-input-inline">
                    <input type="text" id="empNo" readonly name="empNo"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">员工姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="empName" lay-verify="empName"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">性&nbsp;&nbsp;别</label>
                <div class="layui-input-inline">
                    <select name="empSex" lay-filter="aihao">
                        <option value="">-请选择-</option>
                        <option value="0">女</option>
                        <option value="1" selected="">男</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">政治面貌</label>
                <div class="layui-input-inline">
                    <select name="empPolitics" lay-filter="aihao">
                        <option value="">-请选择-</option>
                        <option value="群众" selected>群众</option>
                        <option value="团员">团员</option>
                        <option value="预备党员">预备党员</option>
                        <option value="党员">党员</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">职&nbsp;&nbsp;务</label>
                <div class="layui-input-inline">
                    <select name="roleId" id="role1" lay-verify="required">

                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-inline">
                    <input type="text" name="empBirthday" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">电话号码</label>
                <div class="layui-input-inline">
                    <input type="tel" name="empPhone" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">电子邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" name="empEmail" lay-verify="email" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">籍&nbsp;&nbsp;贯</label>
                <div class="layui-input-inline">
                    <input type="text" name="empAddress" lay-verify="" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">邮箱编号</label>
                <div class="layui-input-inline">
                    <input type="tel" name="empPostCode" lay-verify="postcode" autocomplete="off" class="layui-input">
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
            $.ajax({
                url:"emp/getRoleList",
                data:{},
                type:"post",
                dataType:"json",
                success:function (data) {
                    var options="<option value='' selected>—请选择—</option>";
                    for(var i=0;i<data.length;i++){
                        options+="<option value='"+data[i].roleId+"'>"+data[i].roleName+"</option>";
                    }
                    $("#role1").html(options);
                    form.render();
                }
            });
            //异步获取员工编号
            $.ajax({
                url:"emp/getEmpNo",
                type:"post",
                dataType:"text",
                success:function (data) {
                    $("#empNo").val(data);
                }
            })
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
                $.ajax({
                    url:"emp/addemp",
                    type:"post",
                    data:$("#myform").serialize(),
                    dataType:"text",
                    success:function (data) {
                        if (data=="true"){
                            parent.layer.close(index); //再执行关闭
                            parent.layui.table.reload('empList');//重载表格
                        }else{
                            alert("添加失败");
                        }
                    }
                });
                //parent.layui.table.reload('empList');

            });

            //表单初始赋值
            /*form.val('example', {
                "username": "贤心" // "name": "value"
                ,"password": "123456"
                ,"interest": 1
                ,"like[write]": true //复选框选中状态
                ,"close": true //开关状态
                ,"sex": "女"
                ,"desc": "我爱 layui"
            })*/
        });
    </script>
</body>
</html>