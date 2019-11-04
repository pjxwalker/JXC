<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/30
  Time: 11:20
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
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">订单编号</label>
                <div class="layui-input-inline">
                    <input type="text" id="purchaseNo" readonly name="purchaseNo" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">采购人</label>
                <div class="layui-input-inline">
                    <input type="text" id="purchaser"  name="purchaser" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">采购时间</label>
                <div class="layui-input-inline">
                    <input type="text" id="date"  lay-verify="date" name="purchaseTime" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">申请人</label>
                <div class="layui-input-inline">
                    <input type="text" id="proposer" value="${emp.empName}"  name="proposer" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">申请部门</label>
                <div class="layui-input-inline">
                    <input type="text" id="applyBranch"  name="applyBranch" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">说&nbsp;&nbsp;明</label>
                <div class="layui-input-inline">
                    <input type="text" id="explain"  name="explain" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
    </form>
    <form class="layui-form" >
        <table class="layui-table">
            <colgroup>
                <col width="160">
                <col width="180">
                <col width="160">
                <col width="130">
                <col width="130">
                <col width="150">
                <col width="160">
                <col width="150">
                <col width="160">
                <col width="100">
                <col>
            </colgroup>
            <thead>
            <tr>
                <td colspan="8">
                    <button type="button" id="addRow" class="layui-btn layui-btn-normal">增加</button>
                </td>
                <td colspan="2" align="right">
                    <button type="button" id="submit" class="layui-btn layui-btn-danger">提交</button>
                </td>
            </tr>
            <tr>
                <th align="center">商品编号</th>
                <th>商品名称</th>
                <th>商品类别</th>
                <th>规格型号</th>
                <th>计量单位</th>
                <th>商品进价</th>
                <th>申请数量</th>

                <th>小&nbsp;&nbsp;计</th>
                <th></th>
            </tr>
            </thead>
            <tbody id="tbdy" >

            </tbody>
        </table>
    </form>

    <script src="layui/layui.js"></script>
    <script>
        layui.use(['element','form','laydate'], function() {
            var row=0;
            var form = layui.form
                ,laydate = layui.laydate;
            var $ = layui.$;
            //日期
            laydate.render({
                elem: '#date'
            });
            //获取采购订单编号
            $.ajax({
                url:"purchase/getPurchaseNo",
                type:"post",
                dataType:"text",
                success:function (data) {
                    $("#purchaseNo").val(data);
                    form.render();
                }
            })
            $("#addRow").click(function () {
                var trs="<tr>";
                trs+="<td><input type='text' readonly class='layui-input'></td>";
                trs+="<td><select class='productName' lay-filter='update' lay-search=''></select></td>";
                trs+="<td><input type='text' readonly class='layui-input'></td>";
                trs+="<td><input type='text' readonly class='layui-input'></td>";
                trs+="<td><input type='text' readonly class='layui-input'></td>";
                trs+="<td><input type='text' readonly class='layui-input'></td>";
                trs+="<td><input type='text' class='num layui-input'></td>";

                trs+="<td><input type='text' readonly class='layui-input' value='0'></td>";
                trs+="<td align='center'><button type='button' class='removeRow layui-btn layui-btn-warm'>删除</button></td>";
                trs+="</tr>";
                $("#tbdy").append(trs);
                getProductList();
            });
            $("#tbdy").on("keyup",".num",function () {
                //alert($(this).val());
                var inprice=$(this).parent().prev().children().val();
                var number=$(this).val();
                $(this).parent().parent().children("td").eq(8).children().val(inprice*number);
            })
            $("#tbdy").on("click",".removeRow",function () {
                if (confirm("确定要删除本行吗？")){
                    $(this).parent().parent().remove();
                    row--;
                }
            });
            $("#tbdy").on("blur",".num",function () {
                var number=$(this).val();
                if (number<=0){
                    alert("数量不能小于等于0！");
                    $("#submit").attr("disabled",true);
                }
                else{
                    $("#submit").attr("disabled",false);
                }
            })
            $("#submit").click(function () {
                var total=0;
                var purchaseNo=$("#purchaseNo").val();
                var purchaser=$("#purchaser").val();
                var purchaseTime=$("#date").val();
                var proposer=$("#proposer").val();
                var applyBranch=$("#applyBranch").val();
                var explain=$("#explain").val();
                var list=new Array();
                $("#tbdy tr").each(function () {
                    var oj=new Object();
                    oj.purchaseNo=purchaseNo;
                    oj.productNo=$(this).children("td").eq(0).children().val();
                    oj.productNumber=$(this).children("td").eq(6).children().val();
                    oj.subtotal=$(this).children("td").eq(8).children().val();
                    total+=Number($(this).children("td").eq(8).children().val());
                    list.push(oj);
                })
                var jsonstr={"purchaseNo":purchaseNo,"purchaser":purchaser,"purchaseTime":purchaseTime,
                    "proposer":proposer,"applyBranch":applyBranch,"explains":explain,"totalPrice":total,"goods":list}
                $.ajax({
                    url:"purchase/addPurchase",
                    type:"post",
                    data:JSON.stringify(jsonstr),
                    contentType:"application/json",
                    dataType:"text",
                    success:function (data) {
                        if (data=="true"){
                            alert("添加成功！");
                            $("#submit").attr("disabled",true);
                        } else{
                            alert("对不起,添加失败！");
                        }
                    }
                })
            });
            form.on('select(update)',function (data) {
                $.ajax({
                    url: "purchase/getProductList",
                    type: "post",
                    data: {productNo:data.value},
                    dataType: "json",
                    success: function (data1) {
                        if (data1.length<=1){
                            data.othis.parent().parent().children("td").eq(0).children().val(data1[0].productNo);
                            data.othis.parent().parent().children("td").eq(2).children().val(data1[0].typeName);
                            data.othis.parent().parent().children("td").eq(3).children().val(data1[0].productSize);
                            data.othis.parent().parent().children("td").eq(4).children().val(data1[0].productUnit);
                            data.othis.parent().parent().children("td").eq(5).children().val(data1[0].productInPrice);

                        } else{
                            data.othis.parent().parent().children("td").children().val("");
                        }
                    }
                });
            });
            function getProductList() {
                $.ajax({
                    url:"purchase/getProductList",
                    type:"post",
                    data:{},
                    dataType:"json",
                    success:function (data) {
                        $("#tbdy .productName").eq(row).html("");
                        var options="<option value=''>-请选择-</option>";
                        for(var i=0;i<data.length;i++){
                            options+="<option value='"+data[i].productNo+"'>"+data[i].productName+"</option>";
                        }
                        $("#tbdy .productName").eq(row++).html(options);
                        form.render();
                    }
                })
            }
        });

    </script>
</body>
</html>
