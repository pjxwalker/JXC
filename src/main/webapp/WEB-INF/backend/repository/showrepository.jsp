<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/6
  Time: 11:04
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
    <input type="hidden" name="productId" value="${RepositoryProduct.productId}">
    <div class="layui-form-item" style="padding-top:20px;">
        <div class="layui-inline">
            <label class="layui-form-label">仓库</label>
            <div class="layui-input-inline">
                <input type="text" value="${RepositoryProduct.repositoryTypeName}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">库存量</label>
            <div class="layui-input-inline">
                <input type="text"  value="${RepositoryProduct.productCount}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">商品编号</label>
            <div class="layui-input-inline">
                <input type="text" value="${RepositoryProduct.productNo}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品全称</label>
            <div class="layui-input-inline">
                <input type="text"  value="${RepositoryProduct.productName}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">商品简称</label>
            <div class="layui-input-inline">
                <input type="text"  value="${RepositoryProduct.productShortName}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品规格</label>
            <div class="layui-input-inline">
                <input type="text"  value="${RepositoryProduct.productSize}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">商品类型</label>
            <div class="layui-input-inline">
                <input type="text" readonly value="${RepositoryProduct.typeName}"   autocomplete="off" class="layui-input"/>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品进价</label>
            <div class="layui-input-inline">
                <input type="number"    value="${RepositoryProduct.productInPrice}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">商品售价</label>
            <div class="layui-input-inline">
                <input type="number"  value="${RepositoryProduct.productOutPrice}" readonly autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">零&nbsp;售价</label>
            <div class="layui-input-inline">
                <input type="number"  value="${RepositoryProduct.productRetailPrice}" readonly autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">产&nbsp;&nbsp;地</label>
            <div class="layui-input-inline">
                <input type="text"  value="${RepositoryProduct.productPlace}" readonly autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">计量单位
            </label>
            <div class="layui-input-inline">
                <input type="text" readonly value="${RepositoryProduct.productUnit}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
</form>
<script src="layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
</body>
</html>