<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>采购申请</title>
    <base href="http://localhost:8080/jxc/"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<button id="submit">提交</button>
<form role="form" class="form-inline">
    <div class="form-group">
        <label for="saleNo">销售订单编号</label>
        <input type="text" class="form-control" id="saleNo" readonly>
    </div>
    <%--<div class="form-group">
        <label for="saleTime">销售时间</label>
        <input type="text" class="form-control" id="saleTime">
    </div>--%>
    <div class="form-group">
        <label for="saler">销售人</label>
        <input type="text" class="form-control" id="saler" value="${emp.empName}">
    </div>
    <div class="form-group">
        <label for="proposer">买家</label>
        <input type="text" class="form-control" id="proposer">
    </div>
    <div class="form-group">
        <label for="phone">买家联系电话</label>
        <input type="text" class="form-control" id="phone">
    </div>
    <div class="form-group">
        <label for="explains">签单备注</label>
        <input type="text" class="form-control" id="explains">
    </div>
</form>
<button id="btn">添加商品</button>
<table class="table">
    <thead>
    <tr>
        <th>产品编号</th>
        <th>商品名称</th>
        <th>商品类别</th>
        <th>规格型号</th>
        <th>计量单位</th>
        <th>售价</th>
        <th>销售数量</th>
        <%--<th>库存总数</th>--%>
        <th>小计(￥元)</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="mytbd">


    </tbody>

</table>


</body>
</html>
<script>
    var num = 0;//区分到底是第几行
    //点击添加商品时
    $("#btn").click(function () {
        var tr = "<tr>"
        tr += "<td></td>";
        tr += "<td><select class='goodsname'><option>--选择商品--</option></select></td>";
        tr += "<td></td>";
        tr += "<td></td>";
        tr += "<td></td>";
        tr += "<td></td>";
        tr += "<td><input/></td>";
        // tr += "<td></td>";
        tr += "<td>0</td>";
        tr += "<td><button class='btn'>删除</button></td>";
        tr += "</tr>";
        //新增的tr追加到
        $("#mytbd").append(tr)
        getGoods();
    });


    //动态读取商品信息
    var goodsinfo;

    function getGoods() {
        $.ajax({
            url: "sale/getproduct",
            contextType: "application/json",
            type: "post",
            dataType: "json",
            success: function (data) {
                goodsinfo = data;
                //清空下拉框中的子元素

                for (var i in data) {
                    var option = "<option value='" + data[i].productNo + "'>" + data[i].productName + "</option>";
                    $("#mytbd .goodsname").eq(num).append(option);//当前行只会影响，不会影响其他行

                }
                num++;//每添一行num自增1
                /*  var oldVal="";
                       $("#mytbd select").each(function() {
                           if ($(this).find("option:selected")) {
                               var _thisVal = $(this).find('option:selected').val();
                               oldVal=$(this).attr("old",_thisVal)
                               $(this).parent().siblings("td").find("option[value="+_thisVal+"]").not("option[value=0]").hide()
                           }
                           $("#mytbd select").change(function(){
                               oldVal=$(this).attr("old");
                               var _thisVal=$(this).find('option:selected').val();
                               var id=$(this).attr("id");
                               $(this).parent().siblings("td").find("option[value="+_thisVal+"]").not("option[value=0]").hide();
                               $(this).parent().siblings("td").find("option[value="+oldVal+"]").show();
                               $(this).find("option[value="+oldVal+"]").show();
                               $(this).attr("old",_thisVal)
                           })*/
            }
        })
    }

    //因为下拉框时动态生成的，所有不能直接使用change,B必须使用时间绑定
    //下拉框改变时，将对应的商品信息查询出来记载到对应的td中
    $("#mytbd").on("change", ".goodsname", function () {
        /*  var oldVal="";
          $("#mytbd select").each(function() {
              if ($(this).find("option:selected")) {
                  var _thisVal = $(this).find('option:selected').val();
                  oldVal=$(this).attr("old",_thisVal)
                  $(this).parent().siblings("td").find("option[value="+_thisVal+"]").not("option[value=0]").hide()
              }
              $("#mytbd select").change(function(){
                  oldVal=$(this).attr("old");
                  var _thisVal=$(this).find('option:selected').val();
                  var id=$(this).attr("id");
                  $(this).parent().siblings("td").find("option[value="+_thisVal+"]").not("option[value=0]").hide();
                  $(this).parent().siblings("td").find("option[value="+oldVal+"]").show();
                  $(this).find("option[value="+oldVal+"]").show();
                  $(this).attr("old",_thisVal)
              })*/
        //循环进行匹配
        for (var i in goodsinfo) {
            if ($(this).val() == goodsinfo[i].productNo) {
                //$(this).parent().prev().text();
                // $(this).parent().next().text(goodsinfo[i].typeName);
                $(this).parent().parent().children("td").eq(0).text(goodsinfo[i].productNo);
                $(this).parent().parent().children("td").eq(2).text(goodsinfo[i].typeName);
                $(this).parent().parent().children("td").eq(3).text(goodsinfo[i].productSize);
                $(this).parent().parent().children("td").eq(4).text(goodsinfo[i].productUnit);
                $(this).parent().parent().children("td").eq(5).text(goodsinfo[i].productOutPrice);
                // $(this).parent().parent().children("td").eq(6).text(goodsinfo[i].productCount);


            }

        }

    })

    //删除
    $("#mytbd").on("click", ".btn", function () {
        if (confirm("是否删除?")) {
            $(this).parent().parent().remove();
            num--;
        }

    })
    /* // 下拉框隐藏已选的选项
     $(function(){
         var oldVal="";
         $("#mytbd").on("each", ".goodsname", function () {
             if ($(this).find("option:selected")) {
                 var _thisVal = $(this).find('option:selected').val();
                 oldVal=$(this).attr("old",_thisVal)
                 $(this).parent().siblings("td").find("option[value="+_thisVal+"]").not("option[value=0]").hide()
             }
         })

         $("#mytbd").on("change", ".goodsname", function () {
             oldVal=$(this).attr("old");
             var _thisVal=$(this).find('option:selected').val();
             var id=$(this).attr("id");
             $(this).parent().siblings("td").find("option[value="+_thisVal+"]").not("option[value=0]").hide();
             $(this).parent().siblings("td").find("option[value="+oldVal+"]").show();
             $(this).find("option[value="+oldVal+"]").show();
             $(this).attr("old",_thisVal)
         })
     })*/


    $("#mytbd").on("keyup","input",function(){
        var inprice= $(this).parent().prev().text();
        var num= $(this).val();
        $(this).parent().next().text(inprice*num);
    })


    //点击提交按钮时
    $("#submit").click(function(){
        var saleNo=$("#saleNo").val();//销售签单号
        // var saleTime=$("#saleTime").val();//销售日期
        var saler=$("#saler").val();//销售人
        var proposer=$("#proposer").val();//买家
        var phone=$("#phone").val();//买家电话
        var explains=$("#explains").val();//签单备注
        var saleorderarr=new Array();//采购商品的集合
        var sum=0;//订单总价
        //获取所有的订单详情
        $("#mytbd tr").each(function(){
            //每一行都是一个对象
            var saleorder=new Object();
            saleorder.productNo=$(this).children("td").eq(0).text();
            saleorder.saleNo=saleNo;
            saleorder.productNumber=$(this).find("input").val();
            saleorder.subtotal=$(this).children("td").eq(7).text();
            sum+=Number($(this).children("td").eq(7).text());
            saleorderarr.push(saleorder);//将当前对象存放到数组中
        })
        var jsonstr={"saleNo":saleNo,"saler":saler,"explains":explains,"proposer":proposer,"phone":phone,"sum":sum,"saleorder":saleorderarr}
        console.log(phone+""+proposer);
        if(saleorderarr.length>0 && proposer!=null&&phone!=null && proposer!="" && phone!=""){
            console.log($(this).children("option").text());
            for(var i in saleorderarr){
                if(saleorderarr[i].productNumber==null||saleorderarr[i].productNumber==""){
                    alert("请先添加商品数量");
                    break;
                }
                /*else if($(this).children("td").eq(1).text()=="--选择商品--"){
                    alert("请先添选择商品");
                    break;
                }*/
                else {
                    $.ajax({
                        url: "sale/addso",
                        type: 'post',
                        contentType: 'application/json',
                        data:JSON.stringify(jsonstr),
                        success:function (data) {
                            alert("签单已添加");
                            $("#submit").prop("disabled",true);
                        }
                    });
                }
            }
        }
        if(saleorderarr.length<=0){
            alert("请先添加商品");
        }
        if(proposer==null || phone==null||proposer=="" || phone==""){
            alert("请先添加买家信息");
        }
    })

    $(function(){
        $.ajax({
            url:"sale/getNo",
            type:"post",
            dataType:"text",
            success:function(data){
                $("#saleNo").val(data);
            }
        })
    })
</script>