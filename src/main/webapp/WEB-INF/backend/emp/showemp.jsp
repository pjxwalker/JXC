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
    <form class="layui-form" id="myform" action="">
        <input type="hidden" name="empId" value="${emp.empId}">
        <div class="layui-form-item" style="padding-top:20px;">
            <div class="layui-inline">
                <label class="layui-form-label">员工编号</label>
                <div class="layui-input-inline">
                    <input type="text" value="${emp.empNo}" readonly   autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">员工姓名</label>
                <div class="layui-input-inline">
                    <input type="text" value="${emp.empName}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">性&nbsp;&nbsp;别</label>
                <div class="layui-input-inline">
                    <input type="text" value="${emp.empSex==0 ? '女':'男'}"  readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">政治面貌</label>
                <div class="layui-input-inline">
                    <input type="text" value="${emp.empPolitics}"  readonly autocomplete="off" class="layui-input"/>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">职&nbsp;&nbsp;务</label>
                <div class="layui-input-inline">
                    <input type="text" value="${emp.roleName}" readonly autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-inline">
                    <input type="text" value="${emp.empBirthday}" readonly placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">电话号码</label>
                <div class="layui-input-inline">
                    <input type="tel"value="${emp.empPhone}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">电子邮箱</label>
                <div class="layui-input-inline">
                    <input type="text"  value="${emp.empEmail}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">籍&nbsp;&nbsp;贯</label>
                <div class="layui-input-inline">
                    <input type="text" value="${emp.empAddress}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">邮箱编号</label>
                <div class="layui-input-inline">
                    <input type="tel"  value="${emp.empPostCode}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
        </div>
    </form>
    <script src="layui/layui.js"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
</body>
</html>