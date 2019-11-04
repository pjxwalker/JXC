<!DOCTYPE html>
<html>
<head>
    <base href="http://localhost:8080/jxc/">
    <%@page isELIgnored="false" pageEncoding="UTF-8" %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>进销存后台管理平台</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body class="layui-layout-body">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <div class="layui-logo">JXC 管理系统</div>
            <!-- 头部区域（可配合layui已有的水平导航） -->
            <%--<ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item"><a href="">控制台</a></li>
                <li class="layui-nav-item"><a href="">商品管理</a></li>
                <li class="layui-nav-item"><a href="">用户</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">其它系统</a>
                    <dl class="layui-nav-child">
                        <dd><a href="">邮件管理</a></dd>
                        <dd><a href="">消息管理</a></dd>
                        <dd><a href="">授权管理</a></dd>
                    </dl>
                </li>
            </ul>--%>
            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                        ${emp.empName}
                    </a>
                    <dl class="layui-nav-child">
                        <dd style="text-align: center"><a id="empinfo" href="javascript:;">基本资料</a></dd>
                        <dd  layadmin-event="updPwd" style="text-align: center" ><a id="updPwd" href="javascript:;">重置密码</a></dd>
                        <hr>
                        <dd layadmin-event="logout" style="text-align: center"><a id="logout" href="javascript:;">退出</a> </dd>
                    </dl>
                </li>
            </ul>
        </div>

        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree"  lay-filter="test" id="nav">

                </ul>
            </div>
        </div>

        <div class="layui-tab" lay-filter="demo" lay-allowclose="true" style="margin-left: 200px;">
            <ul class="layui-tab-title"></ul>
            <!-- 内容主体区域 -->
            <div style="padding: 15px;"  class="layui-tab-content"></div>
        </div>

        <div class="layui-footer">
            <!-- 底部固定区域 -->
            © JXC.SYSTEM - 进销存系统
        </div>
    </div>
<script src="layui/layui.js"></script>
<script src="js/backIndex.js"></script>
</body>
</html>