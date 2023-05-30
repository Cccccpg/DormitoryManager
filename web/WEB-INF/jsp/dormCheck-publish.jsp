<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                        <legend>上传文件</legend>
                        <form method="post"  enctype="multipart/form-data" id="form1" action="${pageContext.request.contextPath}/dormCheck/fileUpload.do">
                            <table>
                                <tr>
                                    <td><input  id="upfile" type="file" name="upfile" accept=".xls,.xlsx" style="margin-left: 30px"/></td>
                                    <td><input  class="layui-btn layui-btn-normal" type="submit" value="提交" onclick="return checkData()" /></td>
                                </tr>
                            </table>
                        </form>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    //JS校验form表单信息
    function checkData(){
        var fileDir = $("#upfile").val();
        var suffix = fileDir.substr(fileDir.lastIndexOf("."));
        if("" == fileDir){
            alert("选择需要导入的Excel文件！");
            return false;
        }
        if(".xls" != suffix && ".xlsx" != suffix ){
            alert("选择Excel格式的文件导入！");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
