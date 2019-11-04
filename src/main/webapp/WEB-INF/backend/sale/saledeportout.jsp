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
<botton id="shuaxin" type="button" class='btn btn-primary btn-lg update' >刷新</botton>
<div id="selectsap">
    销售人:<input class="saler"/>
    买家:<input class="proposer"/>
    <botton id="chazhao" type="button" class='btn btn-primary btn-lg update'>查找</botton>
</div>
<table class="table table-striped">
    <thead>
    <tr>
        <th>签单号</th>
        <th>销售员</th>
        <th>签单时间</th>
        <th>买家</th>
        <th>买家联系电话</th>
        <th>签单状态</th>
        <th>签单备注</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="fahuo">
    </tbody>
</table>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>--%>
                <h4 class="modal-title" id="myModalLabel">
                    发货信息
                </h4>
            </div>
            <div class="modal-body">
                <div id="header">
                    收货人<input id="proposer" readonly><br/>
                    收货人电话<input id="phone" readonly><br/>
                    送货地址<input id="address" readonly><br/>
                    选择仓库<select class="repositoryTypeId"></select>
                </div>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>商品编号</th>
                        <th>商品名称</th>
                        <th>出货数量</th>
                        <th>计量单位</th>
                        <th>库存</th>
                        <%--<th>操&nbsp&nbsp作</th>--%>
                    </tr>
                    </thead>
                    <tbody id="mytbd2"></tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default fahuo">发货
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
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
            url: "sale/selectSaleMasterFH",
            type: "post",
            dataType: "json",
            data:{"pageNum":pages,"pageSize":pageSize,"saler":$("#selectsap .saler").val(),"proposer":$("#selectsap .proposer").val()},
            success: function (data) {
                dataPage=data;
                var datelist=data.list;
                $("#fahuo").html("");
                for (var i = 0; i < datelist.length; i++) {
                    var tr = "<tr>"
                    tr += "<td>" + datelist[i].saleNo + "</td>";
                    tr += "<td>" + datelist[i].saler + "</td>";
                    tr += "<td>" + datelist[i].saleTime + "</td>";
                    tr += "<td>" + datelist[i].proposer + "</td>";
                    tr += "<td>" + datelist[i].phone + "</td>";
                    tr += "<td>" + datelist[i].saleStatus + "</td>";
                    tr += "<td>" + datelist[i].explains + "</td>";
                    tr += "<td><button type=\"button\" class='btn btn-primary btn-lg xiangqing' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        // "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">发货</button>" +
                        "</td>";
                    tr += "</tr>";
                    $("#fahuo").append(tr);
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
        $.ajax({
            url: "sale/getrepositoryTypeId",
            type: "post",
            dataType: "json",
            success: function (data) {
                $("#header .repositoryTypeId").html("");
                for (var i in data) {
                    var option = "<option value='"+(data[i].repositoryTypeId)+"'>" + data[i].repositoryTypeName + "</option>";
                    $("#header .repositoryTypeId").append(option);
                }
            }
        })
    }
    var productinfo
    var saleNo
    var cusName
    var cusContactPhone
    $("#fahuo").on("click", ".xiangqing", function () {
        saleNo=$(this).parent().parent().children("td").eq(0).text();
        cusName=$(this).parent().parent().children("td").eq(3).text();
        cusContactPhone=$(this).parent().parent().children("td").eq(4).text();
        $.ajax({
            url: "sale/selectChuKu",
            type: "post",
            data: {
                "saleNo": $(this).parent().parent().children("td").eq(0).text(),
                "cusName": $(this).parent().parent().children("td").eq(3).text(),
                "cusContactPhone": $(this).parent().parent().children("td").eq(4).text(),
                "repositoryTypeId":"1"
            },
            dataType: "json",
            success: function (data) {
                productinfo = data;
                $("#proposer").val(data[0].cusName);
                $("#phone").val(data[0].cusContactPhone);
                $("#address").val(data[0].cusAddress);
                $("#mytbd2").html("");
                for (var i = 0; i < data.length; i++) {
                    var tr = "<tr>"
                    tr += "<td>" + data[i].productNo + "</td>";
                    tr += "<td>" + data[i].productName + "</td>";
                    tr += "<td>" + data[i].productNumber + "</td>";
                    tr += "<td>" + data[i].productUnit + "</td>";
                    tr += "<td>" + data[i].productCount + "</td>";
                    /*tr += "<td><button type=\"button\" class='btn btn-primary btn-lg xiangqing' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        // "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">发货</button>" +
                        "</td>";*/
                    tr += "</tr>";
                    $("#mytbd2").append(tr);
                }
            }
        });
    })
    $("#header").on("change",".repositoryTypeId",function(){
        console.log(saleNo+"KKK"+cusName+"KKK"+cusContactPhone)
        $.ajax({
            url: "sale/selectChuKu",
            type: "post",
            data: {
                "saleNo": saleNo,
                "cusName": cusName,
                "cusContactPhone": cusContactPhone,
                "repositoryTypeId":$(this).val()
            },
            dataType: "json",
            success: function (data) {
                productinfo = data;
                $("#proposer").val(data[0].cusName);
                $("#phone").val(data[0].cusContactPhone);
                $("#address").val(data[0].cusAddress);
                $("#mytbd2").html("");
                for (var i = 0; i < data.length; i++) {
                    var tr = "<tr>"
                    tr += "<td>" + data[i].productNo + "</td>";
                    tr += "<td>" + data[i].productName + "</td>";
                    tr += "<td>" + data[i].productNumber + "</td>";
                    tr += "<td>" + data[i].productUnit + "</td>";
                    tr += "<td>" + data[i].productCount + "</td>";
                    /*tr += "<td><button type=\"button\" class='btn btn-primary btn-lg xiangqing' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        // "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">发货</button>" +
                        "</td>";*/
                    tr += "</tr>";
                    $("#mytbd2").append(tr);
                }
            }
        });
    })


    $("#myModal").on("click",".fahuo",function(){
        var falg=false;
        var a=1;
        console.log(productinfo);
        if (confirm("是否确认发货?")) {
            for(var i in productinfo){
                if(productinfo[i].productNumber>productinfo[i].productCount){
                    a=2;
                    console.log(productinfo[i].productNumber+"----"+productinfo[i].productCount+"---"+a)
                    break;
                }
            }
            if(a==2){
                falg = false;
                alert("商品不足，请先补充商品");
            }
            else if(productinfo[0].cusAddress==null) {
                falg = false;
                alert("请先补充送货地址");
            }
            else {
                falg = true;
            }
        }
        if(falg==true){
            var productarr=new Array();
            var saleStatus="已售出";
            var repositoryTypeId=$("#header .repositoryTypeId").val();
            // var typeid=$("#header .repositoryTypeId").val();
            for(var i in productinfo){
                var saleorder=new Object();
                saleorder.productNo=productinfo[i].productNo;
                saleorder.productCount=(productinfo[i].productCount-productinfo[i].productNumber);
                console.log(saleorder.productNo+"---"+saleorder.productCount+"---"+saleStatus);
                productarr.push(saleorder);
            }
            /*var repositorytypeid=new Object();
            repositorytypeid.repositoryTypeId=$("#header .repositoryTypeId").val();
            productarr.push(repositorytypeid);*/
            $.ajax({
                url:"sale/updateRepository",
                type: "post",
                contentType: 'application/json',
                data:JSON.stringify({"saleNo":saleNo,"repositoryTypeId":repositoryTypeId,"saleStatus":saleStatus,"productarr":productarr}),
                success:function(date){
                    if(date=="true"){
                        alert("商品已发货");
                        query(dataPage.pageNum,$("#pageSize").val());
                        $("#myModal").modal("hide");
                    }
                    else {
                        alert("商品发货失败");
                    }

                }
            })
            return true;
        }
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
    $("#shuaxin").click(function(){
        query(dataPage.pageNum,$("#pageSize").val());
    })

    $("#chazhao").click(function(){
        $.ajax({
            url: "sale/selectSaleMasterFH",
            type: "post",
            dataType: "json",
            data: {
                "pageNum": 1,
                "pageSize": $("#pageSize").val(),
                "saler": $("#selectsap .saler").val(),
                "proposer": $("#selectsap .proposer").val()
            },
            success: function (data) {
                dataPage = data;
                var datelist = data.list;
                $("#fahuo").html("");
                for (var i = 0; i < datelist.length; i++) {
                    var tr = "<tr>"
                    tr += "<td>" + datelist[i].saleNo + "</td>";
                    tr += "<td>" + datelist[i].saler + "</td>";
                    tr += "<td>" + datelist[i].saleTime + "</td>";
                    tr += "<td>" + datelist[i].proposer + "</td>";
                    tr += "<td>" + datelist[i].phone + "</td>";
                    tr += "<td>" + datelist[i].saleStatus + "</td>";
                    tr += "<td>" + datelist[i].explains + "</td>";
                    tr += "<td><button type=\"button\" class='btn btn-primary btn-lg xiangqing' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        // "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">发货</button>" +
                        "</td>";
                    tr += "</tr>";
                    $("#fahuo").append(tr);
                    $("#currPage").html(data.pageNum);
                    $("#totalpage").html(data.pages);
                    if (data.isFirstPage) {
                        $("#prevPage").hide();
                    } else {
                        $("#prevPage").show();
                    }
                    if (data.isLastPage) {
                        $("#nextPage").hide();
                    } else {
                        $("#nextPage").show();
                    }
                }
            }
        })
    })
</script>