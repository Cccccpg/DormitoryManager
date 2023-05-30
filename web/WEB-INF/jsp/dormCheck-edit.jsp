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
                <input type="hidden" id="id" name="id" value="${dormCheck.id}">
                <input type="text" readonly name="dorm_id" placeholder="" value="${dormCheck.dorm_id}" class="form-control" id="dorm_id" required>
            </td>
        </tr>
        <tr>
            <td><label for="dorm_leader">宿舍长</label></td>
            <td colspan="3">
                <input type="text" class="form-control" readonly id="dorm_leader" value="${dormCheck.dorm_leader}" name="dorm_leader" cols="2"  required>
            </td>
        </tr>
        <tr>
            <td><label for="dorm_checkdate">查寝日期</label></td>
            <td colspan="3">
                <input type="text" class="form-control" readonly id="dorm_checkdate" value="${dormCheck.dorm_checkdate}" name="dorm_checkdate" cols="2" placeholder="例如：2021-01-08" required>
            </td>
        </tr>
        <tr>
            <td>
                <label for="dorm_scores">查寝分数</label>
            </td>
            <td colspan="3">
                <input type="text" name="dorm_scores" value="${dormCheck.dorm_scores}" class="form-control" id="dorm_scores" required>
            </td>
        </tr>
        <tr>
            <td>
                <label for="check_description">查寝详情</label>
            </td>
            <td colspan="3">
                <input type="text" name="check_description" value="${dormCheck.check_description}" class="form-control" maxlength="80" placeholder="请输入查寝详情" id="check_description" required>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <button type="button" id="update-dormCheck" class="btn btn-warning">确认修改</button>
                <a href="javascript:window.history.back(-1)" target="_self" class="btn btn-default">返回列表</a>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script>
    $("#update-dormCheck").click(function () {
        var id = $("#id").val().trim();
        var dorm_id = $("#dorm_id").val().trim();
        var dorm_leader = $("#dorm_leader").val().trim();
        var dorm_checkdate = $("#dorm_checkdate").val().trim();
        var dorm_scores = $("#dorm_scores").val().trim();
        var check_description = $("#check_description").val().trim();

        if (id.length == 0 || dorm_id.length == 0 || dorm_leader.length == 0 || dorm_checkdate.length == 0 || dorm_scores == 0 || check_description.length == 0) {
            layer.msg('字段不能为空');
            return false;
        }
        if (${sessionScope.adminInfo.power < 1}) {
            layer.msg('权限不足');
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/dormCheck/update",//要请求的服务器url
            //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
            //data:{method:"ajaxTest",val:value},
            data: {
                id:id,
                dorm_id:dorm_id,
                dorm_leader:dorm_leader,
                dorm_checkdate: dorm_checkdate,
                dorm_scores:dorm_scores,
                check_description: check_description
            },
            type: "POST", //请求方式为POST
            dataType: "json",
            success:function(result){  //这个方法会在服务器执行成功时被调用 ，参数data就是服务器返回的值(现在是json类型)
                //alert(result);
                if(result){
                    layer.msg('修改成功！');
                    if (${sessionScope.adminInfo.power == 1}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/look?uid=${sessionScope.adminInfo.uid}';},2000);
                    }
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/byTeacher?uid=${sessionScope.adminInfo.uid}';},2000);
                        return flase;
                    }
                    if (${sessionScope.adminInfo.power > 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/findAllCheck';},2000);
                    }
                }else {
                    layer.msg('修改失败，请联系管理员');
                    if (${sessionScope.adminInfo.power == 1}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/look?uid=${sessionScope.adminInfo.uid}';},2000);
                    }
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/byTeacher?uid=${sessionScope.adminInfo.uid}';},2000);
                        return flase;
                    }
                    if (${sessionScope.adminInfo.power > 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/findAllCheck';},2000);
                    }
                }
            }
        });
    });
</script>
</body>
</html>
