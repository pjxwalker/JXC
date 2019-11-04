<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/1
  Time: 11:32
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
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusName}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">客户简称</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusShortName}">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">地址</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusAddress}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">邮编</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusPostCode}">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusPhone}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">传真</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusFax}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">联系人</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusContact}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">联系人电话</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusContactPhone}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开户银行</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusBank}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">银行卡号</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusBankCard}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">电子邮箱</label>
            <div class="layui-input-inline">
                <input type="text" readonly  autocomplete="off" class="layui-input" value="${customer.cusEmail}">
            </div>
        </div>
    </div>

</form>
<script src="layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

</body>
</html>