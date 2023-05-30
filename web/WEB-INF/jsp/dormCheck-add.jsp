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
<br />
<form>
    <table class="table" style="width: 100%;text-align: center;">
        <tbody>
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
                <input type="text" name="dorm3" placeholder="例如：101" maxlength="3" class="form-control" id="dorm3" required>
            </td>
        </tr>
        <tr>
            <td>
                <label for="dorm_leader">宿舍长</label>
            </td>
            <td colspan="3">
                <input type="text" name="dorm_leader" class="form-control" id="dorm_leader" required>
            </td>
        </tr>
        <tr>
            <td>
                <label for="dorm_checkdate">查寝日期</label>
            </td>
            <td colspan="3">
                <input type="text" name="dorm_checkdate" class="form-control" id="dorm_checkdate" required>
            </td>
        </tr>
        <tr>
            <td>
                <label for="dorm_scores">查寝分数</label>
            </td>
            <td colspan="3">
                <input type="text" name="dorm_scores" class="form-control" id="dorm_scores" required>
            </td>
        </tr>
        <tr>
            <td><label for="check_description">查寝详情</label></td>
            <td colspan="3">
                <textarea class="form-control" id="check_description" name="check_description" cols="2" maxlength="80" placeholder="请输入查寝详情" required="required"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <button type="button" id="add-dormCheck" class="btn btn-primary">确认添加</button>
                <a href="javascript:window.history.back(-1)" target="_self" class="btn btn-default">返回列表</a>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script>
    $("#dorm_checkdate").change(function () {
        var d1 = $("#dorm1").val();
        var d2 = $("#dorm2").val();
        var dorm3 = $("#dorm3").val().trim();
        var dorm_id = d1+"  "+d2+"  "+dorm3;
        var dorm_checkdate = $("#dorm_checkdate").val().trim();
        $.ajax({
            url: "${pageContext.request.contextPath}/dormCheck/isExistSameDormCheckDate",//要请求的服务器url
            //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
            //data:{method:"ajaxTest",val:value},
            data: {
                dorm_id:dorm_id,
                dorm_checkdate: dorm_checkdate,
            },
            type: "POST", //请求方式为POST
            dataType: "json",
            success:function(result){  //这个方法会在服务器执行成功时被调用 ，参数data就是服务器返回的值(现在是json类型)
                //alert(result);
                if(result){
                    layer.msg('该宿舍此日期查寝结果已存在，请重新输入！');
                }
            }
        });
    });
    $("#add-dormCheck").click(function () {
        var dorm3 = $("#dorm3").val().trim();
        var dorm_leader = $("#dorm_leader").val().trim();
        var dorm_checkdate = $("#dorm_checkdate").val().trim();
        var dorm_scores = $("#dorm_scores").val().trim();
        var check_description = $("#check_description").val().trim();

        if (dorm3.length == 0 || dorm_checkdate.length == 0 || dorm_scores.length == 0 || dorm_leader == 0 || check_description.length == 0) {
            layer.msg('字段不能为空');
            return false;
        }
        if (${sessionScope.adminInfo.power < 2}) {
            layer.msg('权限不足');
            return false;
        }
        var d1 = $("#dorm1").val();
        var d2 = $("#dorm2").val();
        var d3 = $("#dorm3").val();
        var dorm_id = d1+"  "+d2+"  "+d3;
        //alert(dorm_id);
        $.ajax({
            url: "${pageContext.request.contextPath}/dormCheck/add",//要请求的服务器url
            //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
            //data:{method:"ajaxTest",val:value},
            data: {
                dorm_id:dorm_id,
                dorm_leader:dorm_leader,
                dorm_checkdate: dorm_checkdate,
                dorm_scores:dorm_scores,
                check_description: check_description,
            },
            type: "POST", //请求方式为POST
            dataType: "json",
            success:function(result){  //这个方法会在服务器执行成功时被调用 ，参数data就是服务器返回的值(现在是json类型)
                //alert(result);
                if(result){
                    layer.msg('添加成功');
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/byTeacher?uid=${sessionScope.adminInfo.uid}';},2000);
                        return flase;
                    }
                    setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/findAllCheck';},2000);
                }else {
                    layer.msg('添加失败，请重新添加');
                    if (${sessionScope.adminInfo.power == 2}) {
                        setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/byTeacher?uid=${sessionScope.adminInfo.uid}';},2000);
                        return flase;
                    }
                    setTimeout(function () {window.location.href='${pageContext.request.contextPath}/dormCheck/findAllCheck';},2000);
                }
            }
        });
    });
</script>
</body>
</html>
