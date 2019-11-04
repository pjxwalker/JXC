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
        <th>总价</th>
        <th>签单状态</th>
        <th>签单说明</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="select">
    <%--    <c:forEach items="${list}" var="stu">
            <tr>
                <td>${stu.stuid}</td>
                <td>${stu.sname}</td>
                <td>${stu.claid}</td>
                <td>
                <button><a href="stu/getStu?stuid=${stu.stuid}">更改</a></button>|
                <button><a href="stu/deleteStu?stuid=${stu.stuid}">删除</a></button>|
                </td>
            </tr>
        </c:forEach>--%>
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
                    签单详细信息
                </h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>签单号</th>
                        <th>商品名称</th>
                        <th>销售数量</th>
                        <th>小&nbsp&nbsp计</th>
                        <%--<th>操&nbsp&nbsp作</th>--%>
                    </tr>
                    </thead>
                    <tbody id="mytbd2"></tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class='btn btn-xs btnUpdate' data-toggle="modal" data-target="#myModal2">更改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>--%>
                <h4 class="modal-title" id="myModalLabel">
                    签单详细信息
                </h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>订单编号</th>
                        <th>商品名称</th>
                        <th>销售数量</th>
                        <th>小&nbsp&nbsp计</th>
                        <%--<th>操&nbsp&nbsp作</th>--%>
                    </tr>
                    </thead>
                    <tbody id="mytbd3"></tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class='btn btn-xs btnUpdate1'>确认</button>
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
            url: "sale/getSaleMaster",
            type: "post",
            dataType: "json",
            data:{"pageNum":pages,"pageSize":pageSize,"saler":$("#selectsap .saler").val(),"proposer":$("#selectsap .proposer").val()},
            success: function (data) {
                dataPage=data;
                var datelist=data.list;
                $("#select").html("");
                for (var i = 0; i < datelist.length; i++) {
                    var tr = "<tr>"
                    tr += "<td>" + datelist[i].saleNo + "</td>";
                    tr += "<td>" + datelist[i].saler + "</td>";
                    tr += "<td>" + datelist[i].saleTime + "</td>";
                    tr += "<td>" + datelist[i].proposer + "</td>";
                    tr += "<td>" + datelist[i].phone + "</td>";
                    tr += "<td>" + datelist[i].totalPrice + "</td>";
                    tr += "<td>" + datelist[i].saleStatus + "</td>";
                    tr += "<td><input  value='"+datelist[i].explains+"' name='explains' readonly/></td>";
                    tr += "<td><button onclick=''type=\"button\" class='btn btn-primary btn-lg delete'>删除</button>" +
                        "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        "<button type=\"button\" class='btn btn-primary btn-lg xiugai'>修改</button>" +
                        "</td>";
                    tr += "</tr>";
                    $("#select").append(tr);
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
        })//del (" + data[i].saleNo + "),select("+data[i].saleNo+")
    }
    var btnxg=false;
    $("#select").on("click",".xiugai",function(){
        if (btnxg){
            btnxg=false;
            $('input[name=explains]').attr("readonly","readonly");
            $.ajax({
                url: "sale/xiugaiExplain",
                type: "post",
                datatype:"text",
                data: {"saleNo": $(this).parent().parent().children("td").eq(0).text(), "explains": $(this).parent().parent().find("input").val()},
                success: function (data) {
                    if (data == "true") {
                        alert("信息修改成功");
                        query(dataPage.pageNum,$("#pageSize").val());
                    }
                    else {
                        alert("信息修改失败");
                        query(dataPage.pageNum,$("#pageSize").val());
                    }
                },
            });
        }
        else {
            btnxg=true;
            $('input[name=explains]').removeAttr("readonly");
            console.log($(this).parent().parent().children("td").eq(0).text() + "---" + $(this).parent().parent().find("input").val());
        }
    })

    $("#select").on("click",".delete",function(){
        $.ajax({
            url: "sale/DeleteSaleMaster",
            type: "post",
            dataType: "text",
            data: {"saleNo": $(this).parent().parent().children("td").eq(0).text()},
            // data: {"saleNo": $(this).parent().parent().children("td").eq(0).text()},
            // dataType: "text",
            success: function (data) {
                if (data=="true") {
                    alert("信息删除成功");
                    query(dataPage.pageNum,$("#pageSize").val());
                }
            },
            error:function(){
                alert("aa");
            }
        })
    })


    var saleNo;
    $("#select").on("click",".getdetail",function(){
        saleNo=$(this).parent().parent().children("td").eq(0).text()
        $.ajax({
            url:"sale/getSaleDetailByNo",
            type:"post",
            data:{"saleNo":$(this).parent().parent().children("td").eq(0).text()},
            dataType:"json",
            success:function(data){
                $("#mytbd2").empty();
                // goodsinfo=data;
                for(var i = 0; i < data.length; i++){
                    var tr="<tr>"
                    tr += "<td>" + data[i].detailId + "</td>";
                    tr += "<td>" + data[i].productName + "</td>";
                    tr += "<td>" + data[i].productNumber + "</td>";
                    tr += "<td>" + data[i].subtotal + "</td>";
                    // tr+="<td><input size='3'/></td>"
                    // tr+="<td><button class='btn btn-xs btnUpdate' data-toggle=\"modal\" data-target=\"#myModal2\">更改</button></td>"
                    tr+="</tr>"
                    $("#mytbd2").append(tr);

                }

            }
        })

    })
    var goodsinfo;
    $("#myModal").on("click",".btnUpdate",function(){
        $('#myModal').modal('hide');
        $.ajax({
            url:"sale/getSaleDetailByNo",
            type:"post",
            data:{"saleNo":saleNo},
            dataType:"json",
            success:function(data){
                $("#mytbd3").empty();
                goodsinfo=data;
                for(var i = 0; i < data.length; i++){
                    var tr="<tr>"
                    tr += "<td>" + data[i].detailId + "</td>";
                    tr += "<td>" + data[i].productName + "</td>";
                    tr+="<td><input size='3' value='"+data[i].productNumber+"'/></td>"
                    tr += "<td>" + data[i].subtotal + "</td>";//+ data[i].subtotal
                    // tr+="<td><button class='btn btn-xs btnUpdate1'>确认</button></td>"
                    tr+="</tr>"
                    $("#mytbd3").append(tr);
                }
                console.log(saleNo);
            }
        })
        $('#myModal2').modal('toggle');
    })
    $("#mytbd3").on("keyup","input",function(){
        var inprice
        for (var i in goodsinfo){
            if (goodsinfo[i].detailId==$(this).parent().parent().children("td").eq(0).text()){
                var inprice=goodsinfo[i].subtotal/goodsinfo[i].productNumber //$(this).parent().prev().text();console.log(dataid);
                break;
            }
        }
        var num= $(this).val();
        $(this).parent().next().text(inprice*num);
    })

    $("#myModal2").on("click",".btnUpdate1",function(){
        // var saleNo=$("#saleNo").val();//订单号
        var saleorderarr=new Array();//采购商品的集合
        var sum=0;//订单总价
        //获取所有的订单详情
        // console.log(saleNo);
        $("#mytbd3 tr").each(function(){
            //每一行都是一个对象
            var saleorder=new Object();
            saleorder.detailId=$(this).children("td").eq(0).text();
            saleorder.productNumber=$(this).find("input").val();
            saleorder.subtotal=$(this).children("td").eq(3).text();
            sum+=Number($(this).children("td").eq(3).text());
            saleorderarr.push(saleorder);//将当前对象存放到数组中
        })
        var jsonstr={"saleNo":saleNo,"sum":sum,"saleorder":saleorderarr}
        alert(JSON.stringify(jsonstr));
        $.ajax({
            url: "sale/update",
            type: 'post',
            contentType: 'application/json',
            data:JSON.stringify(jsonstr),
            session:function (data) {
                alert("JSON.stringify(jsonstr)"+"数据已修改");
                // parent.location.reload();
                $('#myModal2').modal('hide');
            },
            error:function(){
                alert("JSON.stringify(jsonstr)"+"数据修改失败");
            }
        });
        query(dataPage.pageNum,$("  #pageSize").val());
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
            url: "sale/getSaleMaster",
            type: "post",
            dataType: "json",
            data:{"pageNum":pages,"pageSize":pageSize,"saler":$("#selectsap .saler").val(),"proposer":$("#selectsap .proposer").val()},
            success: function (data) {
                dataPage=data;
                var datelist=data.list;
                $("#select").html("");
                for (var i = 0; i < datelist.length; i++) {
                    var tr = "<tr>"
                    tr += "<td>" + datelist[i].saleNo + "</td>";
                    tr += "<td>" + datelist[i].saler + "</td>";
                    tr += "<td>" + datelist[i].saleTime + "</td>";
                    tr += "<td>" + datelist[i].proposer + "</td>";
                    tr += "<td>" + datelist[i].phone + "</td>";
                    tr += "<td>" + datelist[i].totalPrice + "</td>";
                    tr += "<td>" + datelist[i].saleStatus + "</td>";
                    tr += "<td><input  value='"+datelist[i].explains+"' name='explains' readonly/></td>";
                    tr += "<td><button onclick=''type=\"button\" class='btn btn-primary btn-lg delete'>删除</button>" +
                        "<button onclick=''type=\"button\" class='btn btn-primary btn-lg getdetail' data-toggle=\"modal\" data-target=\"#myModal\">详情</button>" +
                        "<button type=\"button\" class='btn btn-primary btn-lg xiugai'>修改</button>" +
                        "</td>";
                    tr += "</tr>";
                    $("#select").append(tr);
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