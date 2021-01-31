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

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="depts"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>&nbsp;
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>

<script type="text/javascript">
    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_Page(1)
    });
    
    function to_Page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn="+pn,
            type: "GET",
            success: function (result) {
                // console.log(result)
                //1.解析并显示员工信息
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result)
            }
        })
    }

    //解析并显示员工信息
    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append("<span></span>").addClass("lyphicon glyphicon-trash").append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }
    
    //解析并显示分页信息
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum +"页，总共"+result.extend.pageInfo.pages+"页,总"+ result.extend.pageInfo.total+"条记录")
    }

    //解析并显示分页条
    function build_page_nav(result) {
        //清空分页条
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination")

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        }else {
            //为元素添加点击翻页的事件
            firstPageLi.click(function() {
                to_Page(1)
            })
            prePageLi.click(function () {
                to_Page(result.extend.pageInfo.pageNum-1)
            })
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
        if (result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        }else{
            //为元素添加点击翻页的事件
            nextPageLi.click(function() {
                to_Page(result.extend.pageInfo.pageNum+1)
            })
            lastPageLi.click(function () {
                to_Page(result.extend.pageInfo.pages)
            })
        }


        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);

        //1，2,3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,page_Num) {
            var numLi = $("<li></li>").append($("<a></a>").append(page_Num))
            if (result.extend.pageInfo.pageNum == page_Num){
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_Page(page_Num)
            })
            ul.append(numLi);
        })

        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav元素
        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area")
    }
    
    $("#emp_add_modal_btn").click(function () {
        $("#depts").empty()
        //发送ajax请求，查出部门信息,显示在下拉列表中
        getDepts();

         //弹出模态框
         $("#empAddModal").modal({
             backdrop:"static"
         });
    })

    function getDepts() {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result)
                //显示部门信息在下拉列表中
                $.each(result.extend.depts,function (index, dept) {
                    var optionEle = $("<option></option>").append(dept.deptName).attr("value",dept.deptId);
                    optionEle.appendTo($("#depts"))
                })

            }
        })
    }
    
    $("#emp_save_btn").click(function () {
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                alert(result.msg)
            }
        })
    })
</script>
</body>
</html>
