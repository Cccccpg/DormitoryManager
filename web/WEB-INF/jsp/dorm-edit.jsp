<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer.js"></script>
</head>
<body style="width: 97%;">
<br />
<form>
    <table class="table" style="width: 100%;text-align: center;">
        <tbody>
        <tr>
            <td><label for="dorm_id">宿舍号</label></td>
            <td>
                <input type="hidden" id="id" name="id" value="${dorm.id}">
                <input type="text" name="dorm_id" placeholder="" value="${dorm.dorm_id}" class="form-control" id="dorm_id" required>
            </td>
        </tr>
        <tr>
            <td><label for="dorm_intro">宿舍简介</label></td>
            <td colspan="3">
                <input class="form-control" id="dorm_intro" value="${dorm.dorm_intro}" name="dorm_intro" cols="2" maxlength="80" placeholder="请输入宿舍简介" required="required">
            </td>
        </tr>
        <tr>
            <td>
                <label for="dorm_rps">宿舍奖惩</label>
            </td>
            <td colspan="3">
                <select class="form-control" name="dorm_rps" id="dorm_rps">
                    <option value="无" selected>无</option>
                    <option value="年度最佳宿舍" >年度最佳宿舍</option>
                    <option value="年度活跃宿舍">年度活跃宿舍</option>
                    <option value="年度文明宿舍">年度文明宿舍</option>
                    <option value="最佳学习宿舍">最佳学习宿舍</option>
                    <option value="卫生最佳宿舍">卫生最佳宿舍</option>
                    <option value="最佳骨干宿舍">最佳骨干宿舍</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                <label for="dorm_leader">宿舍长</label>
            </td>
            <td colspan="3">
                <input type="text" name="dorm_leader" value="${dorm.dorm_leader}" class="form-control" id="dorm_leader" required>
            </td>
        </tr>
        <tr>
            <td><label for="teacher">班主任</label></td>
            <td colspan="3">
                <select class="form-control" name="teacher" id="teacher">
                        <option value="李老师">李老师</option>
                        <option value="王老师">王老师</option>
                        <option value="赵老师">赵老师</option>
                        <option value="陈老师">陈老师</option>
                        <option value="张老师">张老师</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <button type="button" id="update-dorm" class="btn btn-warning">确认修改</button>
                <a href="javascript:window.history.back(-1)" target="_self" class="btn btn-default">返回列表</a>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script>
    $("#update-dorm").click(function () {
        var id = $("#id").val().trim();
        var dorm_id = $("#dorm_id").val().trim();
        var dorm_intro = $("#dorm_intro").val().trim();
        var dorm_rps = $("#dorm_rps").val().trim();
        var dorm_leader = $("#dorm_leader").val().trim();
        var teacher = $("#teacher").val().trim();

        if (id.length == 0 || dorm_id.length == 0 || dorm_intro.length == 0 || dorm_rps.length == 0 || dorm_leader == 0 || teacher.length == 0) {
            layer.msg('字段不能为空');
            return false;
        }
        if (${sessionScope.adminInfo.power < 1}) {
            layer.msg('权限不足');
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/dorm/update",//要请求的服务器url
            //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
            //data:{method:"ajaxTest",val:value},
            data: {
                id:id,
                dorm_id:dorm_id,
                dorm_intro:dorm_intro,
                dorm_rps: dorm_rps,
                dorm_leader:dorm_leader,
                teacher: teacher,
            },
            type: "POST", //请求方式为POST
            dataType: "json",
            success:function(result){  //这个方法会在服务器执行成功时被调用 ，参数data就是服务器返回的值(现在是json类型)
                //alert(result);
                if(result){
                    layer.msg('修改成功！');
                    if (${sessionScope.adminInfo.power == 1}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/look?uid=${sessionScope.adminInfo.uid}';},2000);
                    }
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/byTeacher?uid=${sessionScope.adminInfo.uid}';},2000);
                        return flase;
                    }
                    if (${sessionScope.adminInfo.power > 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/findAll';},2000);
                    }
                }else {
                    layer.msg('修改失败，请联系管理员');
                    if (${sessionScope.adminInfo.power == 1}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/look?uid=${sessionScope.adminInfo.uid}';},2000);
                    }
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/byTeacher?uid=${sessionScope.adminInfo.uid}';},2000);
                        return flase;
                    }
                    if (${sessionScope.adminInfo.power > 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dorm/findAll';},2000);
                    }
                }
            }
        });
    });
</script>
</body>
</html>
