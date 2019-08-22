<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/21
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>登陆</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="container">
        <div class=".col-md-4">
            <h2>登陆</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 col-md-offset-3">
            <form class="form-inline">
                <div class="form-group">
                    <label class="sr-only" for="exampleInputName">Username</label>
                    <input type="text" class="form-control" id="exampleInputName" placeholder="name">
                </div>
                <div class="form-group">
                    <label class="sr-only" for="exampleInputPassword">Password</label>
                    <input type="password" class="form-control" id="exampleInputPassword" placeholder="Password">
                </div>
            </form>
        </div>
        <button type="submit" class="btn btn-success" id="sign_in">Sign in</button>
        <a href="${pageContext.request.contextPath}/login/registration">
            <button type="button" class="btn btn-primary" id="Registration">Registration</button>
        </a>
        <div class="col-md-3 col-md-offset-3">
            <span id="prompt_message"></span>
        </div>
    </div>
</div>
</body>
<script type=text/javascript>
    $("#sign_in").click(function (){
        var name = $("#exampleInputName").val();
        var password = $("#exampleInputPassword").val();
        var s = {"username": name, "password": password};
        console.log("账户和密码："+name+"&&"+password)
        $.ajax({
            url: "${pageContext.request.contextPath}/login/verify",
            dateType: "json",
            contentType: "application/json",
            data: JSON.stringify(s),
            type: "post",
            success: function (result) {
                // console.log(result);
                if (result.state === 200) {
                    window.location.href = "${pageContext.request.contextPath}/user/employee";
                } else {
                    showValidateMsg("#prompt_message",result.stringObjectMap.mes);
                }
            }
        });
    });

    // /给前端页面添加特效
    function showValidateMsg(ele,msg) {
        // 清除当前元素的校验状态
        $(ele).removeClass("label label-danger");
        $(ele).text("");
        $(ele).addClass("label label-danger");
        $(ele).text(msg);
    }
</script>
</html>
