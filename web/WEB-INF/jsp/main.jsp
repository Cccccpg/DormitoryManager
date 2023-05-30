<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!doctype html>
<html>
<head>
    <title>宿舍后台管理平台</title>
    <link rel="shortcut  icon" href="${pageContext.request.contextPath}/images/dormitory.ico" type="image/x-icon" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iconfont.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme2571.min.css"><%--灰色管理员主题 --%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        // 是否开启刷新记忆tab功能
        var is_remember = true;
    </script>
</head>
<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a>
            <img src="${pageContext.request.contextPath}/images/logo-1.png" style="height: 44px; margin-top: 6px;">
            <b>宿舍管理系统</b>
        </a>
    </div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="iconfont"> &#xe668;</i></a>
    </div>
    <ul class="layui-nav right" lay-filter="" style="margin-top: -5px;">
<%--        <li class="layui-nav-item">--%>
<%--            <a href="javascript:;">我的消息</a>--%>
<%--            <dl class="layui-nav-child">--%>
<%--                <!-- 二级菜单 -->--%>
<%--                <dd>--%>
<%--                    <a onclick="power()">&nbsp;&nbsp;消息</a>--%>
<%--                </dd>--%>

<%--            </dl>--%>
<%--        </li>--%>
        <li class="layui-nav-item">
            <a href="javascript:;">${sessionScope.adminInfo.name}</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="xadmin.add_tab('修改密码','${pageContext.request.contextPath}/to_changeInfo')">修改信息</a></dd>
                <dd>
                    <a href="${pageContext.request.contextPath}/loginOut">切换帐号</a></dd>
                <dd>
                    <a href="${pageContext.request.contextPath}/loginOut">退出登录</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item to-index">
            <a href="http://www.jxau.edu.cn/" target="_blank"><i class="layui-icon">&#xe64c;</i>友情链接</a>
        </li>
    </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav" style="height: 92%";>
    <div id="side-nav">
        <ul id="nav">
            <c:if test="${sessionScope.adminInfo.power > 1}">
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="学生管理">&#xe66f;</i>
                    <cite>学生管理</cite>
                    <i class="iconfont nav_right"></i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('学生信息','${pageContext.request.contextPath}/student/findAll')">
                            <i class="iconfont">&#xe609;</i>
                            <cite>学生信息</cite></a>
                    </li>
                </ul>
            </li>
            </c:if>
            <c:if test="${sessionScope.adminInfo.power > 3}">
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="管理员管理">&#xe612;</i>
                    <cite>管理员管理</cite>
                    <i class="iconfont nav_right"></i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('管理员列表','${pageContext.request.contextPath}/findAllAdmin')">
                            <i class="iconfont">&#xe609;</i>
                            <cite>管理员列表</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('修改密码','${pageContext.request.contextPath}/passwordEdit')">
                            <i class="iconfont">&#xe609;</i>
                            <cite>修改密码</cite></a>
                    </li>
                </ul>
            </li>
            </c:if>
            <li>
                <c:if test="${sessionScope.adminInfo.power > 1}">
                    <a href="javascript:;">
                        <i class="iconfont left-nav-li" lay-tips="宿舍管理">&#xe68e;</i>
                        <cite>宿舍管理</cite>
                        <i class="iconfont nav_right"></i></a>
                    <ul class="sub-menu">
                        <c:if test="${sessionScope.adminInfo.power > 2}">
                            <li>
                                <a onclick="xadmin.add_tab('宿舍列表','${pageContext.request.contextPath}/dorm/findAll')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>宿舍列表</cite></a>
                            </li>
                        </c:if>
                            <%--寝室长只能看到自己所在宿舍的人员信息--%>
                        <c:if test="${sessionScope.adminInfo.power == 2}">
                            <li>
                                <a onclick="xadmin.add_tab('宿舍信息','${pageContext.request.contextPath}/dorm/look?uid=${sessionScope.adminInfo.uid}')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>宿舍信息</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('人员信息','${pageContext.request.contextPath}/dorm/byDorm_leader?uid=${sessionScope.adminInfo.uid}')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>人员信息</cite></a>
                            </li>
                        </c:if>
                    </ul>
                </c:if>
            </li>
            <c:if test="${sessionScope.adminInfo.power > 0}">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont left-nav-li" lay-tips="宿舍卫生">&#xe640;</i>
                        <cite>宿舍卫生</cite>
                        <i class="iconfont nav_right"></i></a>
                    <ul class="sub-menu">
                        <li>
                            <a onclick="xadmin.add_tab('查寝结果','${pageContext.request.contextPath}/dormCheck/findAllCheck')">
                                <i class="iconfont">&#xe609;</i>
                                <cite>查寝结果</cite></a>
                        </li>
                    <!-- 只有宿管、老师、系统管理员才能发布查寝结果 -->
<%--                        <c:if test="${sessionScope.adminInfo.power > 2}">--%>
<%--                            <li>--%>
<%--                                <a onclick="xadmin.add_tab('发布查寝结果','${pageContext.request.contextPath}/dormCheck/publish')">--%>
<%--                                    <i class="iconfont">&#xe609;</i>--%>
<%--                                    <cite>发布查寝结果</cite></a>--%>
<%--                            </li>--%>
<%--                        </c:if>--%>
                    </ul>
                </li>
            </c:if>
                <li>
                    <a href="javascript:;">
                        <i class="iconfont left-nav-li " lay-tips="宿舍报修">&#xe631;</i>
                        <cite>宿舍报修</cite>
                        <i class="iconfont nav_right"></i></a>
                    <ul class="sub-menu">
                        <c:if test="${sessionScope.adminInfo.power > 2}">
                            <li>
                                <a onclick="xadmin.add_tab('报修信息','${pageContext.request.contextPath}/repair/findAll')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>报修信息</cite>
                                </a>
                            </li>
                        </c:if>
                        <li>
                            <a onclick="xadmin.add_tab('报修登记','${pageContext.request.contextPath}/repair/login')">
                                <i class="iconfont">&#xe609;</i>
                                <cite>报修登记</cite></a>
                        </li>
                        <c:if test="${sessionScope.adminInfo.power > 1}">
                            <li>
                                <a onclick="xadmin.add_tab('报修日志','${pageContext.request.contextPath}/repair/log?page=1&size=10')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>报修日志</cite></a>
                            </li>
                        </c:if>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;">
                        <i class="iconfont left-nav-li" lay-tips="访客管理">&#xe63a;</i>
                        <cite>访客管理</cite>
                        <i class="iconfont nav_right"></i></a>
                    <ul class="sub-menu">
                        <c:if test="${sessionScope.adminInfo.power > 2}">
                            <li>
                                <a onclick="xadmin.add_tab('访客信息','${pageContext.request.contextPath}/visitor/findAll')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>访客信息</cite>
                                </a>
                            </li>
                        </c:if>
                            <li>
                                <a onclick="xadmin.add_tab('来访登记','${pageContext.request.contextPath}/visitor/login')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>来访登记</cite>
                                </a>
                            </li>
                        <c:if test="${sessionScope.adminInfo.power > 2}">
                            <li>
                                <a onclick="xadmin.add_tab('访客日志','${pageContext.request.contextPath}/visitor/log?page=1&size=10')">
                                    <i class="iconfont">&#xe609;</i>
                                    <cite>访客日志</cite>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;">
                        <i class="iconfont left-nav-li" lay-tips="缴纳费用">&#xe65e;</i>
                        <cite>缴纳费用</cite>
                        <i class="iconfont nav_right"></i></a>
                    <ul class="sub-menu">
                        <li>
                            <a href="http://tyzfpt.jxau.edu.cn/" target="_blank">
                                <i class="iconfont">&#xe609;</i>
                                <cite>缴纳学费</cite></a>
                        </li>
                    </ul>
                </li>

        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home">
                <i class="layui-icon">&#xe68e;</i>我的桌面
            </li>
        </ul>
        <div class="layui-tab-content"><%--中间的空白面板--%>
            <div class="layui-tab-item layui-show o_div" >
                <c:if test="${sessionScope.adminInfo.power > 0}">
                    <jsp:include page="welcome.jsp"></jsp:include>
                </c:if>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="page-content-bg"></div>
<style id="theme_style"></style>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
<!-- 底部开始 -->
<!-- 底部结束 -->
</body>
<script>
    function power() {
        layer.msg('该功能暂未开放');
        return false;
    }
</script>
</html>
