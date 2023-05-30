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
<form action="${pageContext.request.contextPath}/visitor/addLogin" method="post" name="myform">
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
                <label for="sno">学号</label>
            </td>
            <td>
                <input type="text" name="sno" class="form-control" id="sno" aria-describedby="textHelp" maxlength="20" required>
            </td>
        </tr>
        <tr>
            <td><label for="phone">联系方式</label></td>
            <td>
                <input type="text" name="phone" class="form-control" id="phone" minlength="11" maxlength="11" required>
            </td>
        </tr>
        <tr>
            <td><label for="dorm1">访问校区</label></td>
            <td>
                <select class="form-control" name="dorm1" id="dorm1"  required>
                    <option value="东区">东区</option>
                    <option value="南区">南区</option>
                    <option value="北区">北区</option>
                </select>
            </td>
            <td><label for="dorm2">访问楼栋</label></td>
            <td>
                <select class="form-control" name="dorm2"  id="dorm2"  required>
                    <option value="一栋">一栋</option>
                    <option value="二栋">二栋</option>
                    <option value="三栋">三栋</option>
                    <option value="四栋">四栋</option>
                    <option value="五栋">五栋</option>
                    <option value="六栋">六栋</option>
                    <option value="七栋">七栋</option>
                    <option value="八栋">八栋</option>
                    <option value="九栋">九栋</option>
                    <option value="十栋">十栋</option>
                    <option value="十一栋">十一栋</option>
                    <option value="十二栋">十二栋</option>
                    <option value="十三栋">十三栋</option>
                    <option value="十四栋">十四栋</option>
                    <option value="十五栋">十五栋</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="dorm3">访问宿舍号</label></td>
            <td>
                <input type="text" name="dorm3" placeholder="请直接输入宿舍号" maxlength="3" class="form-control" id="dorm3" required>
            </td>
            <td>

            </td>
        </tr>
        <tr>
            <td><label for="visit_result">到访原因</label></td>
            <td>
                <input type="text" class="form-control" value="" id="visit_result" name="visit_result" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <input type="button" id="sub-btn" class="btn f30 btn-primary radius10 p2 w50" value="提交登记" />
                <a href="${pageContext.request.contextPath}/visitor/findAll" target="_self" class="btn btn-default">返回列表</a>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script>
    $("#sub-btn").click(function () {
            var name = $("#name").val().trim();
            var sno = $("#sno").val().trim();
            var phone = $("#phone").val().trim();
            var d1 = $("#dorm1").val();
            var d2 = $("#dorm2").val();
            var d3 = $("#dorm3").val();
            var dorm_id = d1+"  "+d2+"  "+d3;
            var place = dorm_id.trim();
            var visit_result = $("#visit_result").val().trim();

        if (name == null || sno == null || phone == null || place == null || visit_result == null
            || name.length == 0 || sno.length == 0 || phone.length == 0 || place.length == 0 || visit_result.length == 0) {
            layer.msg('字段不能为空');
            return false;
        }
        if (${sessionScope.adminInfo.power < 1}) {
            layer.msg('对不起，您权限不足');
            return false;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/visitor/addLogin",//要请求的服务器url
            //这是一个对象，表示请求的参数，两个参数：method=ajax&val=xxx，服务器可以通过request.getParameter()来获取
            //data:{method:"ajaxTest",val:value},
            data: {
                name:name,
                sno: sno,
                phone: phone,
                place: place,
                visit_result: visit_result
            },
            type: "POST", //请求方式为POST
            dataType: "json",
            success:function(result){  //这个方法会在服务器执行成功时被调用 ，参数data就是服务器返回的值(现在是json类型)
                //alert(result);
                if(result){
                    layer.msg('添加成功！');
                }else {
                    layer.msg('添加失败，请联系管理员');
                }
            }
        });
    });
</script>
</body>
</html>
