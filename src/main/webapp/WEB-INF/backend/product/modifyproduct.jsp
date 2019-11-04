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
        <input type="hidden" name="productId" value="${product.productId}">
        <div class="layui-form-item" style="padding-top:20px;">
            <div class="layui-inline">
                <label class="layui-form-label">商品编号</label>
                <div class="layui-input-inline">
                    <input type="text" value="${product.productNo}" readonly name="productNo"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">商品全称</label>
                <div class="layui-input-inline">
                    <input type="text" name="productName" value="${product.productName}" lay-verify="productName"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">商品简称</label>
                <div class="layui-input-inline">
                    <input type="text" name="productShortName" value="${product.productShortName}" lay-verify="productShortName"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">商品规格</label>
                <div class="layui-input-inline">
                    <input type="text" name="productSize"  value="${product.productSize}" lay-verify="productSize"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">商品类型</label>
                <div class="layui-input-inline">
                    <input type="hidden" id="type1"  value="${product.typeNo}"/>
                    <select name="typeNo" id="type" lay-verify="required">

                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">商品进价</label>
                <div class="layui-input-inline">
                    <input type="number" name="productInPrice"   value="${product.productInPrice}" lay-verify="productInPrice"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">商品售价</label>
                <div class="layui-input-inline">
                    <input type="number" name="productOutPrice" value="${product.productOutPrice}" lay-verify="productOutPrice" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">零&nbsp;售价</label>
                <div class="layui-input-inline">
                    <input type="number" name="productRetailPrice" value="${product.productRetailPrice}" lay-verify="productRetailPrice" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">产&nbsp;&nbsp;地</label>
                <div class="layui-input-inline">
                    <input type="productPlace" name="productPlace" value="${product.productPlace}" lay-verify="productPlace" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">计量单位
                </label>
                <div class="layui-input-inline">
                    <input type="text" name="productUnit" lay-verify="productUnit" value="${product.productUnit}" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
            <input type="button" lay-submit="" lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
        </div>
    </form>
    <script src="layui/layui.js"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
    <script>
        layui.use(['form', 'layedit', 'laydate'], function(){
            var form = layui.form
                ,layer = layui.layer
                ,layedit = layui.layedit
                ,laydate = layui.laydate;
            //异步获取所有角色
            var $=layui.$;
            $.ajax({
                url:"product/getTypeList",
                data:{},
                type:"post",
                dataType:"json",
                success:function (data) {
                    var tid=$("#type1").val();
                    var options="<option value=''>—请选择—</option>";
                    for(var i=0;i<data.length;i++){
                        if (tid==data[i].typeNo){
                            options+="<option value='"+data[i].typeNo+"' selected>"+data[i].typeName+"</option>";
                        }else{
                            options+="<option value='"+data[i].typeNo+"'>"+data[i].typeName+"</option>";
                        }
                    }
                    $("#type").html(options);
                    form.render();
                }
            });
            //自定义验证规则
            form.verify({
                productName: function(value){
                    if(value.length <=0){
                        return '商品名称不能为空！';
                    }
                }
                ,productInPrice: function (value) {
                    if (value<=0) {
                        return '进价不能小于等于零';
                    }
                },productOutPrice: function (value) {
                    if (value<=0) {
                        return '售价不能小于等于零';
                    }
                },productRetailPrice: function (value) {
                    if (value<=0) {
                        return '零售价不能小于等于零';
                    }
                },productPlace: function (value) {
                    if (value.length<=0) {
                        return '产地不能为空';
                    }
                },productUnit: function (value) {
                    if (value.length<=0) {
                        return '计量单位不能为空';
                    }
                }
            });

            //监听提交
            form.on('submit(layuiadmin-app-form-submit)', function(data){
                var field = data.field; //获取提交的字段
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引

                //提交 Ajax 成功后，关闭当前弹层并重载表格
                $.ajax({
                    url:"product/modifyProduct",
                    type:"post",
                    data:$("#myform").serialize(),
                    dataType:"text",
                    success:function (data) {
                        if (data=="true"){
                            parent.layer.close(index); //再执行关闭
                            parent.layui.table.reload('productList');//重载表格
                        }else{
                            alert("修改失败");
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>