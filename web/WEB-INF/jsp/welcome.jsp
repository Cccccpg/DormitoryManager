<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>欢迎页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>系统时间</legend>
</fieldset>

<blockquote class="layui-elem-quote" id="mytime"></blockquote>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>基于SSM框架下的宿舍后台管理系统</legend>
</fieldset>

<div style="padding: 20px; background-color: #F2F2F2;">
    <div class="layui-row layui-col-space15">

        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">使用框架</div>
                <div class="layui-card-body">
                    Spring<br>
                    SpringMVC<br>
                    Mybatis<br>
                    LayUI + Bootstrap
                </div>
            </div>
        </div>

        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">开发环境</div>
                <div class="layui-card-body">
                    开发工具：Intellij IDEA 2019.3.1 <br>
                    开发环境：Tomcat 9.0.17 + JDK 1.8 + Windows 10 <br>
                    数据库：MySql 5.7<br>
                    数据库工具：Navicat for MySQL
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function showTime(){
        var nowtime =new Date();
        var year=nowtime.getFullYear();
        var month=nowtime.getMonth()+1;
        var date=nowtime.getDate();
        var h = nowtime.getHours();
        var m = nowtime.getMinutes();
        var s = nowtime.getSeconds();
        document.getElementById("mytime").innerText=year+"  年   "+month+"  月    "+date+"   日    "+"       "+h+"    时    "+m+"  分    "+s+"  秒    ";
    }
    setInterval("showTime()",1000);
</script>
</body>
</html>
