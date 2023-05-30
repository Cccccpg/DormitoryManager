<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layer.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer.js"></script>
</head>
<body style="width: 97%;">
<br><br>
<div class="row form-horizontal">
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">用户名:</label>
        <div class="col-sm-8">
            <input  class="form-control"  value="${sessionScope.adminInfo.username}" name="username" id="username">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">姓名:</label>
        <div class="col-sm-8">
            <input  class="form-control" readonly value="${sessionScope.adminInfo.name}" name="name" id="name">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">学/工号:</label>
        <div class="col-sm-8">
            <input  class="form-control" readonly value="${sessionScope.adminInfo.uid}" name="uid" id="uid">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">电话:</label>
        <div class="col-sm-8">
            <input  class="form-control"  value="${sessionScope.adminInfo.phone}" name="phone" id="phone">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">邮箱:</label>
        <div class="col-sm-8">
            <input  class="form-control"  value="${sessionScope.adminInfo.email}" name="email" id="email">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">密码:</label>
        <div class="col-sm-8">
            <input  class="form-control"  value="${sessionScope.adminInfo.password}" name="password" id="password">
        </div>
    </div>
</div>
<div class="row">
    <div class="form-group btn-group col-md-offset-5">
        <button class="btn btn-warning btn-default" onclick="toValidate()">确认修改</button>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script>
    function toValidate(){
        var val = new validate({
            /*rules里面是检验规则，
               *key为需要检验的input的id,
               *value为此input对应的检验规则
            */
            rules:{
                username:"notEmpty",
                phone:"mobile",
                email:"email",
                password:"notEmpty",
            },
            /*submitFun里面为检验成功后要执行的方法*/
            submitFun:function(){
                toSubmit();
            }
        })
    }
    function toSubmit(){
        var username = $("#username").val().trim();
        var phone = $("#phone").val().trim();
        var email = $("#email").val().trim();
        var uid = ${sessionScope.adminInfo.uid};
        var password = $("#password").val().trim();
        layer.confirm('确定要修改吗',function (index) {
            $.ajax({
                url: "${pageContext.request.contextPath}/changeInfo",//要请求的服务器url
                //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
                //data:{method:"ajaxTest",val:value},
                data: {
                    username:username,
                    phone: phone,
                    email:email,
                    uid: uid,
                    password: password,
                },
                type: "POST", //请求方式为POST
                dataType: "json",   //服务器返回的数据是什么类型
                success: function(result){  //这个方法会在服务器执行成功时被调用 ，参数result就是服务器返回的值(现在是json类型)
                    if(result){
                        layer.msg('修改成功');
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/to_changeInfo';},2000);
                    }else {
                        layer.msg('修改失败');
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/to_changeInfo';},2000);
                    }
                }
            });
        });
    }
</script>
</body>
</html>
