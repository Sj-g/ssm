<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/19
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--显示分页信息--%>
<div class="row">
    <%--分页文字信息--%>
    <div class="col-md-6" id="page_info_area">
        当前是<span class="label label-default">第${pageInfo.pageNum}页</span>，本页的有<span class="label label-default">${pageInfo.size}条记录</span>，总共有<span class="label label-default">${pageInfo.pages}页</span>；
    </div>
    <%--分页条信息--%>
    <div class="col-md-6" id="page_nav_area">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li><a href="${pageContext.request.contextPath}/user/employee?pn=1">首页</a></li>
                <c:if test="${pageInfo.isFirstPage==true}">
                    <li class="previous disabled"><a href="javascript:void(0)"><span aria-hidden="true">&laquo;</span></a></li>
                </c:if>
                <c:if test="${pageInfo.isFirstPage==false}">
                    <li class="next"><a href="${pageContext.request.contextPath}/user/employee?pn=${pageInfo.pageNum-1}"><span aria-hidden="true">&laquo;</span></a></li>
                </c:if>
                <C:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                    <c:if test="${page_Num==pageInfo.pageNum}">
                        <li class="active"><a
                                href="${pageContext.request.contextPath}/user/employee?pn=${page_Num}">${page_Num}</a>
                        </li>
                    </c:if>
                    <C:if test="${page_Num!=pageInfo.pageNum}">
                        <li>
                            <a href="${pageContext.request.contextPath}/user/employee?pn=${page_Num}">${page_Num}</a>
                        </li>
                    </C:if>
                </C:forEach>
                <c:if test="${pageInfo.isLastPage==true}">
                    <li class="previous disabled"><a href="javascript:void(0)"><span aria-hidden="true">&raquo;</span></a></li>
                </c:if>
                <c:if test="${pageInfo.isLastPage==false}">
                    <li class="next"><a href="${pageContext.request.contextPath}/user/employee?pn=${pageInfo.pageNum+1}"><span aria-hidden="true">&raquo;</span></a></li>
                </c:if>
                <li><a href="${pageContext.request.contextPath}/user/employee?pn=${pageInfo.pages}">末页</a></li>
            </ul>
        </nav>
    </div>
</div>