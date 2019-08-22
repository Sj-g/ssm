<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/17
  Time: 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="addemp.jsp" %>
<%@include file="updata.jsp" %>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">&nbsp&nbsp新增</button>
            <button type="button" class="btn btn-primary" id="flush">
                &nbsp&nbsp<span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>
            </button>
            <a href="${pageContext.request.contextPath}/login/exit"><button type="button" class="btn btn-warning">退出</button></a>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="pa">
                    <tr>
                        <th class="empId">${pa.empId}</th>
                        <th>${pa.empName}</th>
                        <th>
                            <c:if test="${pa.gender=='M'}">
                                男
                            </c:if>
                            <c:if test="${pa.gender!='M'}">
                                女
                            </c:if>
                        </th>
                        <th>${pa.email}</th>
                        <th class="depName">${pa.department.deptName}</th>
                        <th>
                            <button type="button" class="btn btn-success" id="btn_edit" edit-id="${pa.empId}">编辑</button>
                            &nbsp&nbsp
                            <a href="${pageContext.request.contextPath}/user/empDelete?empId=${pa.empId}&pn=${pageInfo.pageNum}" id="delete_dept">
                                <button type="button" class="btn btn-danger">删除</button>
                            </a>
                        </th>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <%@include file="paging.jsp" %>
</div>
</body>
<script type="text/javascript">
    $(document).on("click", "#btn_edit", function (){
        // alert()
            // 查出部门信息, 查出之后再设置select的状态, 否则先设置了select的状态, 再初始化部门信息会导致select错乱
            getDepts("#empUpdateModal select");
            var emp=this.parentNode.parentNode.querySelector('.empId').innerHTML;
            getEmp(emp);
            // 把员工的id传递给模态框的更新按钮
            $("#btn_update_emp").attr("edit-id",emp);
            // 弹出模态框
            $('#empUpdateModal').modal({
                backdrop: 'static'
            });
        });
    function getEmp(emp) {
        // var depName=this.parentNode.parentNode.querySelector('.depName').innerHTML;
        var s={"emp":emp};
        $.ajax({
            url:"${pageContext.request.contextPath}/user/findOne",
            type:"post",
            data:s,
            dataType:"json",
            success: function (result) {
                var emp = result.stringObjectMap.emp;
                $("#empname_update_static").text(emp.empName);
                $("#email_update_input").val(emp.email);
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                $("#empUpdateModal select").val(emp.dId);
            }
        });
    }

    $("#btn_update_emp").click(function () {
        console.log( $("#empUpdateModal form").serialize());
        // 更新保存员工
        $.ajax({
            url: "${pageContext.request.contextPath}/user/update?empId="+$(this).attr("edit-id"),
            type: "POST",
            data:$("#empUpdateModal form").serialize(),
            // contentType: 'application/json',
            success: function (result) {
                if (200 === result.state) {
                    $('#empUpdateModal').modal('hide');
                    alert("更新成功");
                }else{
                    alert(result.stringObjectMap.mes)
                }
            }
        });
    });
    //刷新
    $("#flush").click(function () {
       location.reload()
    });
    // 点击新增按钮弹出模态框
    $('#emp_add_modal_btn').click(function () {
        // 清除表单数据以及样式
        // resetForm("#empAddModal form");
        // 发送ajax请求,查出部门信息,显示在下拉列表
        getDepts("#empAddModal select");
        // 弹出模态框
        $('#empAddModal').modal({
            backdrop: 'static'
        });
    });

    //获得部门下拉框
    function getDepts(ele) {
        // 清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${pageContext.request.contextPath}/depts",
            type: "GET",
            success: function (result) {
                // 显示部门信息在下拉列表中
                $.each(result, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });

            }
        });
    }

    //保存
    $("#btn_save_emp").click(function () {
        // 保存员工
        $.ajax({
            url: "${pageContext.request.contextPath}/user/emp",
            type: "POST",
            data: $('#empAddModal form').serialize(),
            success: function (result) {
                if (200 === result.state) {
                    $('#empAddModal').modal('hide');
                    alert("保存成功")
                }else{
                    alert(result.stringObjectMap.mes)
                }
            }
        });
    });
</script>
</html>
