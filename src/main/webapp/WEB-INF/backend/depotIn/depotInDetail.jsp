<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <base href="http://localhost:8080/jxc/">
    <title>ImportDetail</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>
    <form class="layui-form" id="myform" action="">
        <input type="hidden" name="productId" value="${detail_map.depotInNo}">
        <div class="layui-form-item" style="padding-top:20px;">
            <div class="layui-inline">
                <label class="layui-form-label">入库编号</label>
                <div class="layui-input-inline">
                    <input type="text" value="${detail_map.depotInNo}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">经手人</label>
                <div class="layui-input-inline">
                    <input type="text"  value="${detail_map.empName}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">商品名称</label>
                <div class="layui-input-inline">
                    <input type="text"  value="${detail_map.productName}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">商品编号</label>
                <div class="layui-input-inline">
                    <input type="text"  value="${detail_map.productNo}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">规&nbsp;&nbsp;格</label>
                <div class="layui-input-inline">
                    <input type="text" readonly value="${detail_map.productSize}"   autocomplete="off" class="layui-input"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">入库数量</label>
                <div class="layui-input-inline">
                    <input type="number"    value="${detail_map.productNumber}" readonly  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">单&nbsp;&nbsp;位</label>
                <div class="layui-input-inline">
                    <input type="text"  value="${detail_map.productUnit}" readonly autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">单位成本</label>
                <div class="layui-input-inline">
                    <input type="number"  value="${detail_map.productInPrice}" readonly autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">产&nbsp;&nbsp;地</label>
                <div class="layui-input-inline">
                    <input type="text"  value="${detail_map.productPlace}" readonly autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">入库时间</label>
                <div class="layui-input-inline">
                    <input type="text" readonly value="${detail_map.depotInTime}" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
            </form>
    <script src="layui/layui.js"></script>
</body>
</html>