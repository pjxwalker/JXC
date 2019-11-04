//JavaScript代码区域
layui.use(['element','layer'], function(){
    var element = layui.element;
    layer=layui.layer;
    var $=layui.$;
    $.ajax({
        url:"getmenus",
        type:"post",
        data:{},
        dataType:"json",
        success:function (data) {
            var menu = ""; //定义变量存储
            for(var i = 0;i<data.length;i++){
                menu += "<li class='layui-nav-item '>"
                if(data[i].funParent == 0){ //取出父元素的菜单，拼进页面
                    menu += "<a href='javascript:;'>"+data[i].funName+"</a>"
                    for(var j = 0;j<data.length;j++){ //继续遍历这几条数据
                        if(data[j].funParent==data[i].funId){ //取出这个父元素所对应的子元素
                            menu += "<dl class='layui-nav-child'>"
                            menu +=     "<dd>"
                            menu +=         "<a class=\"site-demo-active\" href='javascript:;' data-url='"+data[j].funPath+"' data-title='"+data[j].funName+"'  data-id='"+data[j].funId+"'>"+'&nbsp;&nbsp;&nbsp;'+data[j].funName+"</a>"
                            menu +=      "</dd>"
                            menu +=  "</dl>"
                        }
                    }
                }
                menu += "</li>";
            }
            $("#nav").html(menu);
            element.init()//初始化element事件，使菜单展开
        }
    });

    //触发事件
    var active = {
        //在这里给active绑定几项事件，后面可通过active调用这些事件
        tabAdd: function(url,id,name) {
            console.log(url+"="+id+"=="+name);
            //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
            //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
            element.tabAdd('demo', {
                title: name,
                content: '<iframe data-frameid="'+id+'" scrolling="auto" frameborder="0" src="'+url+'" style="width:100%;height:99%;"></iframe>',
                id: id //规定好的id
            })
            // CustomRightClick(id); //给tab绑定右击事件
            FrameWH();  //计算ifram层的大小
        }
        ,tabChange: function(id) {
            //切换到指定Tab项
            element.tabChange('demo', id); //根据传入的id传入到指定的tab项
        }
        ,tabDelete: function (id) {
            element.tabDelete("demo", id);//删除
        }
        ,tabDeleteAll: function (ids) {//删除所有
            $.each(ids, function (i,item) {
                element.tabDelete("demo", item); //ids是一个数组，里面存放了多个id，调用tabDelete方法分别删除
            })
        }
    };
    //当点击有site-demo-active属性的标签时，即左侧菜单栏中内容 ，触发点击事件
    $('#nav').on('click',".site-demo-active", function() {
        var dataid = $(this);
        //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
        if ($(".layui-tab-title li[lay-id]").length <= 0) {
            //如果比零小，则直接打开新的tab项
            active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
        } else {
            //否则判断该tab项是否以及存在

            var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
            $.each($(".layui-tab-title li[lay-id]"), function () {
                //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                    isData = true;
                }
            })
            if (isData == false) {
                //标志为false 新增一个tab项
                active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
            }
        }
        //最后不管是否新增tab，最后都转到要打开的选项页面上
        active.tabChange(dataid.attr("data-id"));
    });
    //计算iframe大小
    function FrameWH() {
        var h = $(window).height() -41- 10 - 60 -10-44 -10;
        $("iframe").css("height",h+"px");
    }

    $(window).resize(function () {
        FrameWH();
    })

    $("#empinfo").on("click",function () {
        layer.open({
            type: 2
            ,title: '基本信息'
            ,content: 'getEmployeeInfo'
            ,maxmin: true
            ,area: ['700px', '350px']
            ,btn: ['确定修改', '取消']
            ,yes: function(index, layero){
                //点击确认触发 iframe 内容中的按钮提交
                var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                submit.click();
            }
        });
    });

    $("#updPwd").on("click",function () {
        layer.open({
            type: 2
            ,title: '用户重置密码'
            ,content: ['updPwd','no']
            ,maxmin: true
            ,area: ['500px', '350px']
            ,btn: ['确定', '取消']
            ,yes: function(index, layero){
                //点击确认触发 iframe 内容中的按钮提交
                var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                submit.click();
            }
        });
    });

    $("#logout").on("click",function () {
        if (confirm("确定退出系统吗？")) {
            //window.location.href="logout";
            $.ajax({
                url:"logout",
                type:"post",
                data:{},
                dataType:"text",
                success:function (data) {
                    if (data=="true"){
                        window.location.href="index.html";
                    }else{
                        layer.open({
                            offset: 't'
                            ,content: '对不起，退出系统失败！'
                        });
                    }
                }
            })
        }
    })
});