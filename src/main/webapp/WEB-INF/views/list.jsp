<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2021/1/30
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--引入jquery--%>
    <script src="${APP_PATH}/static/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <%--搭建显示页面--%>
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
               <button class="btn btn-primary">新增</button>&nbsp;
               <button class="btn btn-danger">删除</button>
           </div>
       </div>
       <%--显示表格数据--%>
       <div class="row">
           <div class="col-md-12">
               <table class="table table-striped table-hover">
                   <tr>
                       <th>#</th>
                       <th>empName</th>
                       <th>gender</th>
                       <th>email</th>
                       <th>deptName</th>
                       <th>操作</th>
                   </tr>
                   <c:forEach items="${pageInfo.list}" var="emp">
                       <tr>
                           <td>${emp.empId}</td>
                           <td>${emp.empName}</td>
                           <td>${emp.gender=="M"?"男":"女"}</td>
                           <td>${emp.email}</td>
                           <td>${emp.department.deptName}</td>
                           <td>
                               <button class="btn btn-primary btn-sm">
                                   <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                   编辑
                               </button>
                               <button class="btn btn-danger btn-sm">
                                   <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                   删除
                               </button>
                           </td>
                       </tr>
                   </c:forEach>
               </table>
           </div>
       </div>
        <%--显示分页信息--%>
       <div class="row">
           <%--分页文字信息--%>
           <div class="col-md-6">
               当前${pageInfo.pageNum}页，总${pageInfo.pages},总${pageInfo.total}条记录
           </div >
           <%--分页条信息--%>
           <div class="col-md-6">
               <nav aria-label="Page navigation">
                   <ul class="pagination">
                       <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                       <c:if test="${pageInfo.hasPreviousPage}">
                           <li>
                           <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                               <span aria-hidden="true">&laquo;</span>
                           </a>
                       </li>
                       </c:if>

                       <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                           <c:if test="${page_Num == pageInfo.pageNum }">
                               <li class="active"><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                           </c:if>
                           <c:if test="${page_Num != pageInfo.pageNum }">
                               <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                           </c:if>

                       </c:forEach>

                       <c:if test="${pageInfo.hasNextPage}">
                           <li>
                               <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                   <span aria-hidden="true">&raquo;</span>
                               </a>
                           </li>
                       </c:if>

                       <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                   </ul>
               </nav>
           </div>
       </div>
    </div>
</body>
</html>
