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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();
            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/student/findAll?page=1&size="+ pageSize;
        }
        $("#serarch_btn").click(function () {
            var keyword = $("#keyword").val();
            location.href="${pageContext.request.contextPath}/student/findAll?page=1&size=10&keyword="+keyword;
        });
        $("#refresh").click(function () {
            $("#myform").reset();
            location.href="${pageContext.request.contextPath}/student/findAll?page=1&size=10";
        });
    </script>
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form id="myform" class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block">
                            <input class="layui-input" type="text" autocomplete="off" placeholder="请输入关键字" name="keyword" id="keyword" value="${param.keyword}">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <button class="layui-btn"  id="serarch_btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                        </div>
                        <div class="layui-inline layui-show-xs-block x-right">
                            <a class="layui-btn layui-btn-normal" href="${pageContext.request.contextPath}/student/findAll?page=1&size=10"><i class="layui-icon">&#xe669;</i></a>
                        </div>
                    </form>
                </div>
                <xblock>
                    <c:if test="${sessionScope.adminInfo.power > 2}">
                        <a href="${pageContext.request.contextPath}/student/addStudent" class="layui-btn layui-btn-normal">
                            <i class="layui-icon">&#xe654;添加</i>
                        </a>
                    </c:if>
                    <a onclick="exportInfo()" class="layui-btn layui-btn-warm" href="javascript:;">
                        <i class="layui-icon">&#xe601;导出</i>
                    </a>
                    <span class="x-right" style="line-height:40px">共有数据：${pageInfo.total} 条</span>
                </xblock>
                <div class="layui-card-body">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr style="text-align: center">
                            <th style="text-align: center">ID</th>
                            <th style="text-align: center">姓名</th>
                            <th style="text-align: center">性别</th>
                            <th style="text-align: center">学号</th>
                            <th style="text-align: center">班级</th>
                            <th style="text-align: center">联系方式</th>
                            <th style="text-align: center">宿舍号</th>
                            <th style="text-align: center">班主任</th>
                            <th style="text-align: center">状态</th>
                            <c:if test="${sessionScope.adminInfo.power > 2}">
                            <th style="text-align: center">操作</th>
                            </c:if>
                        </thead>
                        <tbody>
                        <%
                            int j = 1;
                        %>
                        <c:forEach items="${pageInfo.list}" var="student">
                        <tr id="light" style="text-align: center">
                            <td><%=j++%></td>
                            <td>${student.name}</td>
                            <td>${student.sex}</td>
                            <td>${student.sno}</td>
                            <td>${student.stu_class}</td>
                            <td>${student.phone}</td>
                            <td>${student.dorm_id}</td>
                            <td>${student.teacher}</td>
                            <c:if test="${student.status == 1}">
                                <td><button class="layui-btn layui-btn-normal layui-btn-sm">已激活</button></td>
                            </c:if>
                            <c:if test="${student.status == 0}">
                                <td><button class="layui-btn layui-btn-danger layui-btn-sm">禁用</button></td>
                            </c:if>
                            <c:if test="${sessionScope.adminInfo.power > 2}">
                            <td class="td-manage">
                                <a title="编辑" href="${pageContext.request.contextPath}/student/editStudent?sno=${student.sno}">
                                    <i class="layui-icon">&#xe642;</i>
                                </a>
                                <a title="删除" onclick="member_del(this,${student.sno},${sessionScope.adminInfo.power})" href="javascript:;">
                                    <i class="layui-icon">&#xe640;</i>
                                </a>
                            </td>
                            </c:if>
                            </c:forEach>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="layui-card-body pull-left">
                    <div class="form-group form-inline" style="margin-top: 5px;">
                        共&nbsp;${pageInfo.pages}&nbsp;页&emsp;当前页：${pageInfo.pageNum}&nbsp;/&nbsp;${pageInfo.pages}&emsp; 每页
                        <select class="form-control" id="changePageSize" onchange="changePageSize()">
                            <option value="1">${pageInfo.size}</option>
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                        </select> 条
                    </div>
                </div>
                <c:choose>
                    <c:when test="${pageInfo.pages < 5}">
                        <c:set var="begin" value="1">
                        </c:set>
                        <c:set var="end" value="${pageInfo.pages}">
                        </c:set>
                    </c:when>
                    <c:when test="${pageInfo.pageNum <= 3}">
                        <c:set var="begin" value="1">
                        </c:set>
                        <c:set var="end" value="5">
                        </c:set>
                    </c:when>
                    <c:when test="${pageInfo.pageNum > 3 and pageInfo.pageNum <= pageInfo.pages-2}">
                        <c:set var="begin" value="${pageInfo.pageNum - 2}">
                        </c:set>
                        <c:set var="end" value="${pageInfo.pageNum + 2}">
                        </c:set>
                    </c:when>
                    <c:otherwise>
                        <c:set var="begin" value="${pageInfo.pages - 4}">
                        </c:set>
                        <c:set var="end" value="${pageInfo.pages}">
                        </c:set>
                    </c:otherwise>
                </c:choose>
                <div class="layui-card-body pull-right" style="height: min-content">
                    <div class="page form-inline" style="margin-top: 0;">
                        <div>
                            <a class="next" href="${pageContext.request.contextPath}/student/findAll?page=1&size=${pageInfo.pageSize}&keyword=${param.keyword}">首页</a>
                            <c:if test="${pageInfo.pageNum > 1}">
                                <a class="prev" href="${pageContext.request.contextPath}/student/findAll?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}&keyword=${param.keyword}">上一页</a>
                            </c:if>
                            <c:forEach var="i" begin="${begin}" end="${end}" step="1">
                                <c:if test="${pageInfo.pageNum == i}">
                                    <span class="current">${i}</span>
                                </c:if>
                                <c:if test="${pageInfo.pageNum != i}">
                                    <a class="num" href="${pageContext.request.contextPath}/student/findAll?page=${i}&size=${pageInfo.pageSize}&keyword=${param.keyword}">${i}</a>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pageInfo.pageNum < pageInfo.pages}">
                                <a class="next" href="${pageContext.request.contextPath}/student/findAll?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}&keyword=${param.keyword}">下一页</a>
                            </c:if>
                            <a class="next" href="${pageContext.request.contextPath}/student/findAll?page=${pageInfo.pages}&size=${pageInfo.pageSize}&keyword=${param.keyword}">尾页</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    // var upload = layui.upload; //得到 upload 对象
    // upload.render({
    //     elem: '.upload'
    //     ,done: function(res, index, upload){
    //         //获取当前触发上传的元素，一般用于 elem 绑定 class 的情况，注意：此乃 layui 2.1.0 新增
    //         var item = this.item;
    //     }
    // })

    //删除操作
    function member_del(obj,sno,power){
        layer.confirm('确认要删除吗？',function(index){
            if (power < 3){
                layer.msg('对不起，您没有权限！');
                return false;
            }
            //发异步删除数据
            $.get("${pageContext.request.contextPath}/student/delete",{"sno":sno},function (data) {
                if(data){
                    layer.msg('删除成功!',{icon:1,time:2000});
                    setTimeout(function () {window.location.href='${pageContext.request.contextPath}/student/findAll';},2000);

                }else {
                    layer.msg('删除失败!',{icon:1,time:2000});
                    setTimeout(function () {window.location.href='${pageContext.request.contextPath}/student/findAll';},2000);
                }
            });
        });
    }
    //导出Excel操作
    function exportInfo() {
        if (${sessionScope.adminInfo.power < 3}) {
            layer.msg('对不起，您权限不足');
            return false;
        }
        layer.confirm('确定导出所有学生数据吗？',function (index) {
            location.href="${pageContext.request.contextPath}/student/export";
            layer.close(index);
        });
    }

       function uploadFile() {
           var file = $("#upload").val();
           file = file.substring(file.lastIndexOf('.'), file.length);
           if (file == '') {
               alert("上传文件不能为空！");
           } else if (file != '.xlsx' && file != '.xls') {
               alert("请选择正确的excel类型文件！");
           } else {
               ajaxFileUpload();
           }
       }
       function ajaxFileUpload() {

           var formData = new FormData();
           var name = $("#upload").val();
           formData.append("file", $("#upload")[0].files[0]);
           formData.append("name", name);
           $.ajax({
               url : "${pageContext.request.contextPath}/student/importStudentList",
               type : "post",
               async : false,
               data : formData,
               processData : false,
               contentType : false,
               beforeSend : function() {
                   console.log("正在进行，请稍候");
               },
               success : function(e) {
                   if (e == "02") {
                       alert("导入失败");
                   } else {
                       alert(e);
                   }
               }
           });
       }

</script>
</body>
</html>
