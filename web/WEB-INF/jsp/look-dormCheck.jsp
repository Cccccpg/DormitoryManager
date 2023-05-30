<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <td style="text-align: center"><label>宿舍号</label></td>
            <td colspan="3" style="text-align: center">${dormCheck.dorm_id}</td>
        </tr>
        <tr>
            <td style="text-align: center"><label>宿舍长</label></td>
            <td colspan="3" style="text-align: center">${dormCheck.dorm_leader}</td>
        </tr>
        <tr>
            <td style="text-align: center"><label>查寝日期</label></td>
            <td colspan="3" style="text-align: center">${dormCheck.dorm_checkdate}</td>
        </tr>
        <tr>
            <td style="text-align: center"><label>查寝分数</label></td>
            <td colspan="3" style="text-align: center">${dormCheck.dorm_scores}</td>
        </tr>
        <tr>
            <td style="text-align: center"><label>查寝详情</label></td>
            <td colspan="3" style="text-align: center">${dormCheck.check_description}</td>
        </tr>
        </tbody>
    </table>
</form>

</body>
</html>
