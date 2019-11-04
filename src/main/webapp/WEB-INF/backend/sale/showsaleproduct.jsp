<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <base href="http://localhost:8080/jxc/"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"></link>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
<botton id="shuaxin" type="button" class='btn btn-primary btn-lg update'>刷新</botton>
<div id="selectsap">
    商品名称:<input class="productName"/>
    <botton id="chazhao" type="button" class='btn btn-primary btn-lg update'>查找</botton>
</div>
<table class="table table-striped">
    <thead>
    <tr>
        <th>商品编号</th>
        <th>商品名称</th>
        <th>产品规格</th>
        <th>计量单位</th>
        <th>商品售价</th>
        <th>商品总售量</th>
    </tr>
    </thead>
    <tbody id="yssp">
    </tbody>
</table>
<div style="position: fixed; bottom: 20px;">
    当前是第<span id="currPage"></span>页，共<span id="totalpage"></span>页，
    <button id="toprevPage">首页</button><button id="prevPage">上一页</button><button id="nextPage">下一页</button><button id="lastPage">尾页</button>
    每页<select id="pageSize">
    <option value="5">5</option>
    <option value="10">10</option>
    <option value="15">15</option>
    <option value="20">20</option>
</select>条
</div>
</body>
</html>
<script>
    $(function () {
        query(1,5);
    })
    var dataPage;
    function query(pages,pageSize) {
        $.ajax({
            url: "sale/getSaleProduct",
            type: "post",
            dataType: "json",
            data:{"pageNum":pages,"pageSize":pageSize,"productName":$("#selectsap .productName").val()},
            success: function (data) {
                dataPage=data;
                var datelist=data.list;
                $("#yssp").html("");
                for(var i in datelist) {
                    var tr = "<tr>"
                    tr += "<td>" + datelist[i].productNo + "</td>";
                    tr += "<td>" + datelist[i].productName + "</td>";
                    tr += "<td>" + datelist[i].productSize + "</td>";
                    tr += "<td>" + datelist[i].productUnit + "</td>";
                    tr += "<td>" + datelist[i].productOutPrice + "</td>";
                    tr += "<td>" + datelist[i].productNumber + "</td>";
                    /*tr += "<td>" + data[i].explains + "</td>";
                    tr += "<td><button type=\"button\" class='btn btn-primary btn-lg xiangqing' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        // "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">发货</button>" +
                        "</td>";*/
                    tr += "</tr>";
                    $("#yssp").append(tr);
                    $("#currPage").html(data.pageNum);
                    $("#totalpage").html(data.pages);
                    if(data.isFirstPage){
                        $("#prevPage").hide();
                        $("#toprevPage").hide();
                    }else{
                        $("#prevPage").show();
                        $("#toprevPage").show();
                    }
                    if(data.isLastPage){
                        $("#nextPage").hide();
                        $("#lastPage").hide();
                    }else{
                        $("#nextPage").show();
                        $("#lastPage").show();
                    }
                }
            }
        })
    }
    $("#shuaxin").click(function(){
        query(dataPage.pageNum,$("#pageSize").val());
    })

    $("#nextPage").click(function(){
        //将下一页的页码传到服务器
        query(dataPage.nextPage,$("#pageSize").val());
    })
    $("#toprevPage").click(function(){
        query(1,$("#pageSize").val());
    })
    $("#lastPage").click(function(){
        query(dataPage.pages,$("#pageSize").val());
    })
    $("#prevPage").click(function(){
        //将上一页的页码传到服务器
        query(dataPage.prePage,$("#pageSize").val());
    })

    $("#pageSize").change(function(){
        query(dataPage.pageNum,$("#pageSize").val());

    })
    $("#chazhao").click(function(){
        $.ajax({
            url: "sale/getSaleProduct",
            type: "post",
            dataType: "json",
            data:{"pageNum":1,"pageSize":$("#pageSize").val(),"productName":$("#selectsap .productName").val()},
            success: function (data) {
                dataPage=data;
                var datelist=data.list;
                $("#yssp").html("");
                for(var i in datelist) {
                    var tr = "<tr>"
                    tr += "<td>" + datelist[i].productNo + "</td>";
                    tr += "<td>" + datelist[i].productName + "</td>";
                    tr += "<td>" + datelist[i].productSize + "</td>";
                    tr += "<td>" + datelist[i].productUnit + "</td>";
                    tr += "<td>" + datelist[i].productOutPrice + "</td>";
                    tr += "<td>" + datelist[i].productNumber + "</td>";
                    /*tr += "<td>" + data[i].explains + "</td>";
                    tr += "<td><button type=\"button\" class='btn btn-primary btn-lg xiangqing' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        // "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">发货</button>" +
                        "</td>";*/
                    tr += "</tr>";
                    $("#yssp").append(tr);
                    $("#currPage").html(data.pageNum);
                    $("#totalpage").html(data.pages);
                    if(data.isFirstPage){
                        $("#prevPage").hide();
                        $("#toprevPage").hide();
                    }else{
                        $("#prevPage").show();
                        $("#toprevPage").show();
                    }
                    if(data.isLastPage){
                        $("#nextPage").hide();
                        $("#lastPage").hide();
                    }else{
                        $("#nextPage").show();
                        $("#lastPage").show();
                    }
                }
            }
        })
    })
</script>

