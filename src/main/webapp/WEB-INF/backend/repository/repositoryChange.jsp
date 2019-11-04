<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/6
  Time: 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <base href="http://localhost:8080/jxc/">
    <title>调拨商品</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>
<form  id="myform" action="">
    <input type="hidden" name="RepositoryId" value="${repositoryChange.id}">
    <div class="layui-form-item" style="padding-top:20px;">
        <div class="layui-inline">
            <label class="layui-form-label">源仓库</label>
            <div class="layui-input-inline" style="padding-top: 9px">
                <select name="fromRepositoryId" id="fromRepositoryId" lay-filter="">
                    <option value="${repositoryChange.repositoryTypeId}">${repositoryChange.repositoryTypeName}</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">目标仓库</label>
            <div class="layui-input-inline" style="padding-top: 9px">
                <select name="toRepositoryId" id="toRepositoryId" lay-filter="">

                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">商品编号</label>
            <div class="layui-input-inline">
                <input name="productNo" id="productNo" type="text" value="${repositoryChange.productNo}"
                       readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品全称</label>
            <div class="layui-input-inline">
                <input type="text"  value="${repositoryChange.productName}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">商品类型</label>
            <div class="layui-input-inline">
                <input type="text" readonly value="${repositoryChange.typeName}"   autocomplete="off" class="layui-input"/>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">商品规格</label>
            <div class="layui-input-inline">
                <input type="text"  value="${repositoryChange.productSize}" readonly  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">库存量</label>
            <div class="layui-input-inline">
                <input id="productCount" type="text" readonly value="${repositoryChange.productCount}"   autocomplete="off" class="layui-input"/>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">调拨数量</label>
            <div class="layui-input-inline">
                <input name="allotCount" id="allotCount" onkeyup="checkAllotCount()"
                       type="text"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
</form>

<script src="layui/layui.js"></script>
</body>

<script>
    layui.use('element',function () {
        var $ = layui.$ ;
        //获取源仓库以外的仓库
        $.ajax({
            type:"post",
            url: "repository/findOtherRepository",
            data:{"repositoryTypeId":$("#fromRepositoryId").val()},
            dataType:"json",
            success:function (data) {
                var options="<option value=''>—请选择—</option>";
                for (var i in data){
                    options +="<option value='"+data[i].repositoryTypeId+"'>"+data[i].repositoryTypeName+"</option>"
                }
                $("#toRepositoryId").html(options);
            }
        })
    });

    //动态检查 调拨数量 不能比 库存量 大
    function checkAllotCount() {
        var $ = layui.$ ;
        var allotCount = parseInt($("#allotCount").val());
        var productCount = parseInt($("#productCount").val());
        if(allotCount > productCount){
            $("#allotCount")[0].style.border="1px solid red";
            alert("调拨数量 不能比 库存量 大 !!!")
        }
        else if(allotCount <= 0){
            $("#allotCount")[0].style.border="1px solid red";
            alert("调拨数量 不能小于等于 0 !!!")
        }
    }

    //返回调拨需要的数据
    var callbackdata = function() {
        var $ = layui.$ ;
        var data = {fromRepositoryId:parseInt($("#fromRepositoryId option:selected").val()),  //源仓库
                    toRepositoryId:parseInt($("#toRepositoryId option:selected").val()),      //目标仓库
                    productNo:$("#productNo").val(),
                      productCount:parseInt($("#productCount").val()),     //库存量  传到父页面 用来比较与调拨量的大小
                    allotCount:parseInt($("#allotCount").val()) }          //调拨数量
        return data ;
    }

</script>


</html>