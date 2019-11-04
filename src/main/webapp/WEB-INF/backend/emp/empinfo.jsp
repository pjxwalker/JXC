<%--
  Created by IntelliJ IDEA.
  User: Administrator
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
                <label class="layui-form-label">员工编号</label>
                <div class="layui-input-inline">
                    <input type="text" id="empNo" name="empNo" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">员工姓名</label>
                <div class="layui-input-inline">
                    <input type="text" id="empName" name="empName" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">员工角色</label>
                <div class="layui-input-inline">
                    <select name="roleId" id="role" lay-filter="aihao">

                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <button id="do_search" type="button" class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="">
                    <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                </button>
            </div>
        </div>
    </form>
<table id="demo" lay-filter="empList"></table>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="addEmp layui-btn layui-btn-sm" lay-event="add">添加员工</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
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
            ,url: 'emp/getEmpList' //数据接口
            ,toolbar: '#toolbarDemo'//开启头部工具栏
            ,page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
                , curr: 1
                , groups: 1
                , limit: 10
            }//开启分页
            ,id:'empList'
            ,cols: [[ //表头
                {field: 'empId', title: 'ID', hide:true}
                ,{field: 'empNo', title: '编号', width:110,align:'center', fixed: 'left'}
                ,{field: 'empName', title: '姓名',align:'center', width:100}
                ,{field: 'empSexName', title: '性别',align:'center', width:80,sort:true}
                ,{field: 'roleName', title: '角色',align:'center', width: 120}
                ,{field: 'empPhone', title: '联系电话',align:'center', width: 125}
                ,{field: 'empAddress', title: '地址',align:'center', width: 125}
                ,{field: 'empEmail', title: '电子邮箱',align:'center', width: 155}
                ,{field: 'empBirthday', title: '生日', width: 130,align:'center',sort:true }
                ,{fixed: 'right', title:'操作', width: 165, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //头工具栏事件
        table.on('toolbar(empList)', function(obj){
            if (obj.event=='add') {
                layer.open({
                   type: 2
                   ,title: '添加员工信息'
                   ,content: 'emp/toAddEmp'
                   ,maxmin: true
                   ,area: ['700px', '400px']
                   ,btn: ['确定', '取消']
                   ,yes: function(index, layero){
                       //点击确认触发 iframe 内容中的按钮提交
                       var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                       submit.click();
                   }

               });
            }
        });
        //监听行工具事件
        table.on('tool(empList)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.open({
                    type: 2
                    ,title: '查看员工详细信息'
                    ,content: 'emp/showEmp/'+data.empId
                    ,maxmin: true
                    ,area: ['700px', '400px']
                    ,btn: ['关闭']
                });
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    //向服务端发送删除指令
                    $.ajax({
                        url:"emp/deleteEmp",
                        data:{empId:data.empId},
                        dataType:"text",
                        type:"post",
                        success:function (data) {
                            if (data=="true"){
                                obj.del(); //删除对应行（tr）的DOM结构
                                layer.close(index);
                            } else{
                                alert("对不起，删除失败!");
                            }
                        }
                    })
                });
            } else if(layEvent === 'edit'){
                layer.open({
                    type: 2
                    ,title: '修改员工信息'
                    ,content: 'emp/toModifyEmp/'+data.empId
                    ,maxmin: true
                    ,area: ['700px', '400px']
                    ,btn: ['确定', '取消']
                    ,yes: function(index, layero){
                        //点击确认触发 iframe 内容中的按钮提交
                        var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                        submit.click();
                    }
                });
            }
        });
        // 执行搜索，表格重载
        $('#do_search').on('click', function () {
            // 搜索条件
            var empNo = $('#empNo').val();
            var empName = $('#empName').val();
            var roleId=$("#role option:selected").val();
            table.reload('empList', {
                method: 'post'
                , where: {
                    'empNo': empNo,
                    'empName': empName,
                    'roleId':roleId
                }
            });
        });
    });

    layui.use('element',function () {
        //异步获取所有角色
        var $=layui.$;
        $.ajax({
            url:"emp/getRoleList",
            data:{},
            type:"post",
            dataType:"json",
            success:function (data) {
                var options="<option value=''>—请选择—</option>";
                for(var i=0;i<data.length;i++){
                    options+="<option value='"+data[i].roleId+"'>"+data[i].roleName+"</option>";
                }
                $("#role").html(options);
            }
        });
    });

</script>
</body>
</html>
