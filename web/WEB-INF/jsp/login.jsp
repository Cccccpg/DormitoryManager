<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/usersLogin.css">
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
    <title>登录页面--LOGIN</title>
    <style>

        .captcha-img img {height:34px;border:1px solid #e6e6e6;height:36px;width:100%;}
        .input-val {
            width: 63%;
            background: #ffffff;
            height: 2.8rem;
            padding: 0 2%;
            border-radius: 5px;
            border: none;
            border: 1px solid rgba(0,0,0,.2);
            font-size: 0.9rem;
        }
        #canvas {
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 8px;

        }
    </style>
    <script type="text/javascript">
        $(function () {
            //ajax校验用户名是否存在
            $("#username").change(function () {
                //取username的值
                var u_name = $(this).val();
                //ajax异步请求
                $.get("${pageContext.request.contextPath}/checkUserName",{"u_name":u_name},function (msg) {
                    $(".error").html(msg);
                    if (msg != "账号可用") {
                        layer.msg('账号不存在');
                    }
                });
            });
        });
    </script>
</head>
<body>
<form action="${pageContext.request.contextPath}/login" name="myform" method="post">
<div id="particles-js">
    <div class="login">
        <div class="login-top">
            宿舍管理后台登录
        </div>
        <div class="login-center clearfix">
            <div class="login-center-img"><img src="${pageContext.request.contextPath}/images/name.png"/></div>
            <div class="login-center-input">
                <input type="text" id="username" name="username" placeholder="请输入您的用户名" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的用户名'"/>
                <div class="login-center-input-text">用户名</div>
            </div>
        </div>
        <div class="login-center clearfix">
            <div class="login-center-img"><img src="${pageContext.request.contextPath}/images/password.png"/></div>
            <div class="login-center-input">
                <input type="password" id="password" name="password" placeholder="请输入您的密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的密码'"/>
                <div class="login-center-input-text">密码</div>
            </div>
        </div>
        <div class="login-center clearfix">
            <div class="login-center-img"><img src="${pageContext.request.contextPath}/images/captcha.png"/></div>
            <div class="login-center-input">
                <input type="text" placeholder="请输入验证码" class="input-val">
                <div class="login-center-input-text">验证码</div>
                <canvas id="canvas" width="100" height="30"></canvas>
            </div>
        </div>
        <div class="login-button" onclick="check()">
            登录
        </div>
        <span style="text-align: center;color: red;"><br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${msg}</span>
    </div>
    <div class="sk-rotating-plane"></div>
</div>
</form>
<script src="${pageContext.request.contextPath}/js/particles.min.js"></script>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
<script type="text/javascript" >
    var show_num = [];
    function check() {
        var username = $("#username").val().trim();
        var password = $("#password").val().trim();
        if (username == null || username == "" || username.length == 0) {
            layer.msg('请输入用户帐号',{icon: 6});
            return false;
        }
        if (password == null || password == "" || password.length == 0) {
            layer.msg('请输入登录密码');
            return false;
        }
        if (password.length < 4 || password.length > 20) {
            layer.msg('密码格式有误（4-20位字符）');
            return false;
        }

        //验证

        var val = $(".input-val").val().toLowerCase();
        var num = show_num.join("");
        if(val==''){
            layer.msg('请输入验证码！');
            return false;
        }else if(val == num){
            $(".input-val").val('');
        }else{
            layer.msg('验证码错误！请重新输入！');
            $(".input-val").val('');
            draw(show_num);
            return false;
        }
        document.myform.submit();
    }




    //显示验证码
    $(function(){
        draw(show_num);
        $("#canvas").on('click', function () {
            draw(show_num);
        })
    });

    //验证码生成函数
    function draw(show_num) {
        var canvas_width = $('#canvas').width();
        var canvas_height = $('#canvas').height();
        var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
        var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
        canvas.width = canvas_width;
        canvas.height = canvas_height;
        var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
        var aCode = sCode.split(",");
        var aLength = aCode.length;//获取到数组的长度

        for (var i = 0; i <= 3; i++) {
            var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
            var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
            var txt = aCode[j];//得到随机的一个内容
            show_num[i] = txt.toLowerCase();
            var x = 10 + i * 20;//文字在canvas上的x坐标
            var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
            context.font = "bold 23px 微软雅黑";

            context.translate(x, y);
            context.rotate(deg);

            context.fillStyle = randomColor();
            context.fillText(txt, 0, 0);

            context.rotate(-deg);
            context.translate(-x, -y);
        }
        for (var i = 0; i <= 5; i++) { //验证码上显示线条
            context.strokeStyle = randomColor();
            context.beginPath();
            context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.stroke();
        }
        for (var i = 0; i <= 30; i++) { //验证码上显示小点
            context.strokeStyle = randomColor();
            context.beginPath();
            var x = Math.random() * canvas_width;
            var y = Math.random() * canvas_height;
            context.moveTo(x, y);
            context.lineTo(x + 1, y + 1);
            context.stroke();
        }
    }

    function randomColor() {//得到随机的颜色值
        var r = Math.floor(Math.random() * 256);
        var g = Math.floor(Math.random() * 256);
        var b = Math.floor(Math.random() * 256);
        return "rgb(" + r + "," + g + "," + b + ")";
    }

</script>
</body>
</html>
