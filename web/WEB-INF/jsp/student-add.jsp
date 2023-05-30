<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer.js"></script>
</head>
<body>
<form>
    <table class="table" style="width: 100%;text-align: center;">
        <tbody>
        <tr>
            <td>
                <label for="name">姓名</label>
            </td>
            <td>
                <input type="text" class="form-control" id="name" name="name" maxlength="10" required>
            </td>
            <td>
                <label for="sex">性别</label>
            </td>
            <td>
                <select class="form-control" name="sex" id="sex">
                    <option value="男" selected>男</option>
                    <option value="女">女</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                <label for="sno">学号</label>
            </td>
            <td>
                <input type="text" name="sno" class="form-control" id="sno" aria-describedby="textHelp" maxlength="20" required>
            </td>
            <td>
                <label for="stu_class">班级</label>
            </td>
            <td>
                <input type="text" name="stu_class" class="form-control" id="stu_class" maxlength="30" required>
            </td>
        </tr>
        <tr>
            <td><label for="phone">联系方式</label></td>
            <td>
                <input type="text" name="phone" class="form-control" id="phone" minlength="11" maxlength="11" required>
            </td>
            <td><label for="place">家庭住址</label></td>
            <td>
                <input type="text" placeholder="请输入家庭详细地址" name="place" class="form-control" id="place" maxlength="30" required>
            </td>
        </tr>
        <tr>
            <td><label for="dorm1">校区</label></td>
            <td>
                <select class="form-control" name="dorm1" id="dorm1"  required>
                    <option value="东区">东区</option>
                    <option value="南区">南区</option>
                    <option value="北区">北区</option>
                </select>
            </td>
            <td><label for="dorm2">楼栋</label></td>
            <td>
                <select class="form-control" name="dorm2"  id="dorm2"  required>
                    <option value="1栋">1栋</option>
                    <option value="2栋">2栋</option>
                    <option value="3栋">3栋</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="dorm3">宿舍号</label></td>
            <td>
                <input type="text" name="dorm3" placeholder="请直接输入宿舍号,如102" maxlength="3" class="form-control" id="dorm3" required>
            </td>
            <td><label for="dorm4">床号</label></td>
            <td>
                <select class="form-control" name="dorm4" id="dorm4"  required>
                    <option value="1号床">1号床</option>
                    <option value="2号床">2号床</option>
                    <option value="3号床">3号床</option>
                    <option value="4号床">4号床</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="teacher">班主任</label></td>
            <td>
                <select class="form-control" name="teacher" id="teacher" required>
                    <option value="李老师">李老师</option>
                    <option value="王老师">王老师</option>
                    <option value="赵老师">赵老师</option>
                    <option value="陈老师">陈老师</option>
                    <option value="张老师">张老师</option>
                </select>
            </td>
            <td><label for="status">状态</label></td>
            <td>
                <select class="form-control" name="status" id="status">
                    <option value="0" selected>禁用</option>
                    <option value="1">激活</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <button type="button" id="add-student" class="btn btn-primary">确认添加</button>
                <a href="javascript:window.history.back(-1)" target="_self" class="btn btn-default">返回列表</a>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script>
    $(function () {
        //ajax校验学号已被注册
        $("#sno").change(function () {
            //取sno的值
            var sno = $(this).val();
            //ajax异步请求
            $.get("${pageContext.request.contextPath}/student/isExist",{"sno":sno},function (date) {
                //$(".error").html(msg);
                if (date) {
                    layer.msg('学号已被注册，请重新输入！');
                    return false;
                }
            });
        });
    });
    $("#add-student").click(function () {
        var name = $("#name").val().trim();
        var sex = $("#sex").val().trim();
        var sno = $("#sno").val().trim();
        var stu_class = $("#stu_class").val().trim();
        var phone = $("#phone").val().trim();
        var place = $("#place").val().trim();
        var dorm4 = $("#dorm4").val().trim();
        var teacher = $("#teacher").val().trim();
        var status = $("#status").val().trim();

        if (name == 0 || sex == 0 || sno == 0 || stu_class == 0 || phone == 0 || place == 0 || dorm3 == 0 || teacher == 0) {
            layer.msg('字段不能为空');
            return false;
        }
        if (${sessionScope.adminInfo.power < 1}) {
            layer.msg('对不起，您权限不足');
            return false;
        }
        var d1 = $("#dorm1").val();
        var d2 = $("#dorm2").val();
        var d3 = $("#dorm3").val();
        var dorm_id = d1+"  "+d2+"  "+d3+"  "+dorm4;
        //alert(dorm_id);
        $.ajax({
            url: "${pageContext.request.contextPath}/student/add",//要请求的服务器url
            //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
            //data:{method:"ajaxTest",val:value},
            data: {
                name:name,
                sex:sex,
                sno: sno,
                stu_class:stu_class,
                phone: phone,
                place: place,
                dorm_id:dorm_id,
                teacher:teacher,
                status:status
            },
            type: "POST", //请求方式为POST
            dataType: "json",
            success:function(result){  //这个方法会在服务器执行成功时被调用 ，参数data就是服务器返回的值(现在是json类型)
                //alert(result);
                if(result){
                    layer.msg('添加成功！');
                    if (${sessionScope.adminInfo.power == 1}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/byDorm_leader?uid=${sessionScope.adminInfo.uid}';},2000);
                        return false;
                    }
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/findStudent?name=${sessionScope.adminInfo.name}';},2000);
                        return flase;
                    }
                    setTimeout(function () {window.location.href='${pageContext.request.contextPath}/student/findAll';},2000);
                }else {
                    layer.msg('添加失败，请联系管理员');
                    if (${sessionScope.adminInfo.power == 1}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/byDorm_leader?uid=${sessionScope.adminInfo.uid}';},2000);
                        return false;
                    }
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/findStudent?name=${sessionScope.adminInfo.name}';},2000);
                        return flase;
                    }
                    setTimeout(function () {window.location.href='${pageContext.request.contextPath}/student/findAll';},2000);
                }
            }
        });
    });
</script>
</body>
</html>
