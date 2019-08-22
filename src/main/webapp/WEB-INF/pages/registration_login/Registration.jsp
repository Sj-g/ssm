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
<div class="container" id="register_save">
    <div class="container">
        <div class=".col-md-4">
            <h3>注册</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 col-md-offset-3">
            <form>
                <div class="form-group">
                    <label for="exampleInputUserName">UserName</label>
                    <input type="text" class="form-control" id="exampleInputUserName" placeholder="userName">
                    <span></span>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">ConfirmPassword</label>
                    <input type="password" class="form-control" id="exampleInputPassword2" placeholder="Password">
                    <span></span>
                </div>
            </form>
            <button type="submit" class="btn btn-success" id="registtration" ajax-va="error" ajax-va2="error">Submit</button>
            <a href="${pageContext.request.contextPath}/login/loginpages"><button type="button" class="btn btn-danger">退出</button></a>
        </div>
    </div>
</div>
</body>
<script type=text/javascript>
    $("#registtration").click(function () {
        var empName = $("#exampleInputUserName").val();
        var password = $("#exampleInputPassword1").val();
        var password2 = $("#exampleInputPassword2").val();
        if (empName===""){
            showValidateMsg("#exampleInputUserName", "error", "用户名不能为空");
            $("#registtration").attr("ajax-va2", "error");
        }
        if (password2===""){
            showValidateMsg("#exampleInputPassword2", "error", "密码不能为空");
            $("#registtration").attr("ajax-va", "error");
        }
        if($("#registtration").attr("ajax-va")==="success"){
            if($("#registtration").attr("ajax-va2")==="success"){
                var s = {"username": empName, "password": password};
                $.ajax({
                    url: "${pageContext.request.contextPath}/login/save",
                    data: JSON.stringify(s),
                    type: "post",
                    contentType: "application/json",
                    success: function (result) {
                        if(result.state===200){
                            alert("注册完成");
                            location.reload()
                        }else{
                            // alert("错误");
                            showValidateMsg("#exampleInputUserName", "error",result.stringObjectMap.errormessage.username);
                            $("#registtration").attr("ajax-va2", "error");
                        }
                    }
                });
            }

        }
    });
    //判断密码是否一致
    $("#exampleInputPassword2").change(function () {
        var password = $("#exampleInputPassword1").val();
        var password2 = $("#exampleInputPassword2").val();
        if (password == password2) {
            showValidateMsg("#exampleInputPassword2", "success", "");
            $("#registtration").attr("ajax-va", "success");
        } else {
            showValidateMsg("#exampleInputPassword2", "error", "密码不一样");
            $("#registtration").attr("ajax-va", "error");
        }
    });
    // 判读密码是否一致
    $("#exampleInputPassword1").change(function (){
        // console.log($("#registtration").attr("ajax-va"));
        var password = $("#exampleInputPassword1").val();
        var password2 = $("#exampleInputPassword2").val();
        if(password2!=="") {
            if (password === password2) {
                $("#registtration").attr("ajax-va", "success");
                showValidateMsg("#exampleInputPassword2", "success", "");

            } else {
                $("#registtration").attr("ajax-va", "error");
                showValidateMsg("#exampleInputPassword2", "error", "密码不一样");
            }
        }
    });
    //查看用户名是否重复
    $("#exampleInputUserName").change(function () {
        if (validateAddForm()) {
            var empName = $("#exampleInputUserName").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/login/checkuser",
                data: "empName=" + empName,
                type: "POST",
                success: function (result) {
                    console.log(result);
                    if (result.state === 200) {
                        // console.log(result)
                        showValidateMsg("#exampleInputUserName", "success", "用户名可用");
                        $("#registtration").attr("ajax-va2", "success");
                    } else {
                        showValidateMsg("#exampleInputUserName", "error", result.stringObjectMap.message);
                        $("#registtration").attr("ajax-va2", "error");
                    }
                }

            });
        }

    });

//给前端页面添加特效
    function showValidateMsg(ele, status, msg) {
        // 清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" === status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
//检验
    function validateAddForm() {
        var empName = $("#exampleInputUserName").val();
        // console.log(empName);
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // 应该清空这个元素之前的样式
            showValidateMsg("#exampleInputUserName", "error", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
            $("#registtration").attr("ajax-va2", "error");
            return false;
        } else {
            showValidateMsg("#exampleInputUserName", "success", "");
            $("#registtration").attr("ajax-va2", "success");
        }
        return true;
    }
</script>
</html>
