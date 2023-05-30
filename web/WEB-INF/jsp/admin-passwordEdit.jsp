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
            <input type="text" class="form-control"  value="${ad.username}" name="username" id="username">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">姓名:</label>
        <div class="col-sm-8">
            <input type="text"  value="${ad.name}" class="form-control" name="name" id="name">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">学/工号:</label>
        <div class="col-sm-8">
            <input type="text" class="form-control"  value="${ad.uid}" name="uid" id="uid">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">手机号:</label>
        <div class="col-sm-8">
            <input type="text" value="${ad.phone}" class="form-control" name="phone" id="phone">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">邮箱:</label>
        <div class="col-sm-8">
            <input type="text" value="${ad.email}" class="form-control" name="email" id="email">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">新密码</label>
        <div class="col-sm-8">
            <input type="password" class="form-control"  value="${newPassword}" name="newPassword" id="newPassword">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label form-label">确认密码</label>
        <div class="col-sm-8">
            <input type="password" class="form-control" value="${newPasswordAgain}" name="newPasswordAgain" id="newPasswordAgain">
        </div>
    </div>
</div>
<div class="row">
    <div class="form-group btn-group col-md-offset-5">
        <button class="btn btn-warning btn-default" onclick="toValidate()">确认修改</button>
        <a type="button" href="${pageContext.request.contextPath}/findAllAdmin" class="btn btn-primary btn-default">返回列表</a>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script>
    function toValidate(){
        var newPassword = $("#newPassword").val();
        var newPasswordAgain = $("#newPasswordAgain").val();
        if(newPassword != newPasswordAgain){
            $("#newPassword").val("");
            $("#newPasswordAgain").val("");
            layer.msg("两次密码不一致，请重新输入");
            return false;
        }else{
            var val = new validate({
                /*rules里面是检验规则，
                *key为需要检验的input的id,
                *value为此input对应的检验规则
                */
                rules:{
                    username:'notEmpty',
                    name:'notEmpty',
                    uid:"notEmpty",
                    phone:"mobile",
                    email:"email",
                    newPassword:"notEmpty",
                    newPasswordAgain: "notEmpty"
                },
                /*submitFun里面为检验成功后要执行的方法*/
                submitFun:function(){
                    toSubmit();
                }
            })
        }
    }
    function toSubmit(){
        var id = $("#id").val();
        var username = $("#username").val().trim();
        var name = $("#name").val().trim();
        var uid = $("#uid").val().trim();
        var phone = $("#phone").val().trim();
        var email = $("#email").val().trim();
        var password = $("#newPassword").val().trim();
        layer.confirm('确定要修改吗',function (index) {
            if (${sessionScope.adminInfo.power < 3}) {//非超级管理员不能修改管理员信息
                layer.msg('对不起，您权限不足');
                layer.close(index);
                return false;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/editPassword",//要请求的服务器url
                //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
                //data:{method:"ajaxTest",val:value},
                data: {
                    id:id,
                    username:username,
                    name:name,
                    uid:uid,
                    phone: phone,
                    email: email,
                    password: password
                },
                type: "POST", //请求方式为POST
                dataType: "json",   //服务器返回的数据是什么类型
                success: function(result){  //这个方法会在服务器执行成功时被调用 ，参数result就是服务器返回的值(现在是json类型)
                    if(result){
                        layer.msg('修改成功');
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/findAllAdmin';},2000);
                    }else {
                        layer.msg('修改失败，请联系管理员');
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/passwordEdit';},2000);
                    }
                }
            });
        });
    }
</script>
</body>
</html>
