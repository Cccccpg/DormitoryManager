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
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();
            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/dormCheck/findAllCheck?page=1&size="+ pageSize;
        }
        $("#serarch_btn").click(function () {
            var keyword = $("#keyword").val();
            location.href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=1&size=10&keyword="+keyword;
        });
        $("#refresh").click(function () {
            $("#myform").reset();
            location.href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=1&size=10";
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
                            <a class="layui-btn layui-btn-normal" href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=1&size=5"><i class="layui-icon">&#xe669;</i></a>
                        </div>
                    </form>
                </div>
                <xblock>
                    <c:if test="${sessionScope.adminInfo.power > 2}">
                        <a href="${pageContext.request.contextPath}/dormCheck/toAdd" class="layui-btn layui-btn-normal"><i class="layui-icon">&#xe654;</i>添加</a>
                    </c:if>
                    <a onclick="exportInfo(${sessionScope.adminInfo.power})" class="layui-btn layui-btn-warm" href="javascript:;"><i class="layui-icon">&#xe67c;</i>导出</a>
                    <span class="x-right" style="line-height:40px">共有数据：${pageInfo.total} 条</span>
                </xblock>
                <div class="layui-card-body">
                    <table class="layui-table layui-form" style="table-layout: fixed;width: 100%">
                        <thead>
                        <tr style="text-align: center">
                            <th style="text-align: center">ID</th>
                            <th style="text-align: center">宿舍号</th>
                            <th style="text-align: center">宿舍长</th>
                            <th style="text-align: center">查寝日期</th>
                            <th style="text-align: center">查寝分数</th>
                            <th style="text-align: center">查寝详情</th>
                            <c:if test="${sessionScope.adminInfo.power > 2}">
                            <th style="text-align: center">操作</th>
                            </c:if>
                        </thead>
                        <tbody>
                        <%
                            int j = 1;
                        %>
                        <c:forEach items="${pageInfo.list}" var="dorm_check">
                        <tr id="light" style="text-align: center">
                            <td><%=j++%></td>
                            <td>${dorm_check.dorm_id}</td>
                            <td>${dorm_check.dorm_leader}</td>
                            <td style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">${dorm_check.dorm_checkdate}</td>
                            <td style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">${dorm_check.dorm_scores}</td>
                            <td><div style="white-space: nowrap;text-overflow: ellipsis; overflow: hidden;" title="${dorm_check.check_description}">${dorm_check.check_description}</div></td>
                            <c:if test="${sessionScope.adminInfo.power > 2}">
                                <td class="td-manage">
                                    <a title="更新信息" href="${pageContext.request.contextPath}/dormCheck/toUpdate?id=${dorm_check.id}">
                                        <i class="layui-icon">&#xe642;</i>
                                    </a>
                                    <a title="查看详情" onclick="look(${dorm_check.id})" href="javascript:;">
                                        <i class="layui-icon">&#xe60a;</i>
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
                            <a class="next" href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=1&size=${pageInfo.pageSize}&keyword=${param.keyword}">首页</a>
                            <c:if test="${pageInfo.pageNum > 1}">
                                <a class="prev" href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}&keyword=${param.keyword}">上一页</a>
                            </c:if>
                            <c:forEach var="i" begin="${begin}" end="${end}" step="1">
                                <c:if test="${pageInfo.pageNum == i}">
                                    <span class="current">${i}</span>
                                </c:if>
                                <c:if test="${pageInfo.pageNum != i}">
                                    <a class="num" href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=${i}&size=${pageInfo.pageSize}&keyword=${param.keyword}">${i}</a>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pageInfo.pageNum < pageInfo.pages}">
                                <a class="next" href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}&keyword=${param.keyword}">下一页</a>
                            </c:if>
                            <a class="next" href="${pageContext.request.contextPath}/dormCheck/findAllCheck?page=${pageInfo.pages}&size=${pageInfo.pageSize}&keyword=${param.keyword}">尾页</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    //查看详情
    function look(id) {
        layer.open({
            type: 2,
            title:'查寝详情',
            skin: 'layui-layer-rim', //加上边框
            area: ['800px', '430px'], //宽高
            content: '${pageContext.request.contextPath}/dormCheck/look?id='+id
        });
    }
    //导出Excel操作
    function exportInfo(power) {
        if (power < 3) {
            layer.msg('对不起，您没有权限导出查寝结果');
            return false;
        }
        layer.confirm('确定导出所有查寝数据吗？',function (index) {
            location.href="${pageContext.request.contextPath}/dormCheck/export";
            layer.close(index);
        });
    }
</script>
</body>
</html>
