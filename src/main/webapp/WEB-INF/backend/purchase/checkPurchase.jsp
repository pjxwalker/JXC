<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/2
  Time: 9:20
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
    <div class="layui-form-item" style="padding-top:15px;">
        <div class="layui-inline">
            <label class="layui-form-label">订单编号</label>
            <div class="layui-input-inline">
                <input type="text" value="${purchase.purchaseNo}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">采购人</label>
            <div class="layui-input-inline">
                <input type="text" value="${purchase.purchaser}"  readonly autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">采购时间</label>
            <div class="layui-input-inline">
                <input type="text"  value="${purchase.purchaseTime}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">申请人</label>
            <div class="layui-input-inline">
                <input type="text" value="${purchase.proposer}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">申请部门</label>
            <div class="layui-input-inline">
                <input type="text" value="${purchase.applyBranch}"  readonly autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">说&nbsp;&nbsp;明</label>
            <div class="layui-input-inline">
                <input type="text" value="${purchase.explain}" readonly placeholder="无" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
</form>
<table class="layui-table">
    <colgroup>
        <col width="150">
        <col width="150">
        <col>
    </colgroup>
    <thead>
    <tr>
        <td colspan="8" align="right">合计：${purchase.totalPrice}元</td>
    </tr>
    <tr>
        <th>商品编号</th>
        <th>商品名称</th>
        <th>商品类型</th>
        <th>商品规格</th>
        <th>商品进价</th>
        <th>商品库存</th>
        <th>采购数量</th>
        <th>小计</th>
    </tr>
    </thead>
    <tbody>
        <c:forEach var="pro" items="${purchase.mapList}">
            <tr>
                <td>${pro.productNo}</td>
                <td>${pro.productName}</td>
                <td>${pro.typeName}</td>
                <td>${pro.productSize}</td>
                <td>${pro.productInPrice}</td>
                <td>${pro.productCount}</td>
                <td>${pro.productNumber}</td>
                <td>${pro.subtotal}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="layui-form-item layui-hide">
    <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
    <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
</div>
<script src="layui/layui.js"></script>
</body>
</html>
