#Problem1
java.sql.SQLException: The server time zone value '�й���׼ʱ��' is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the 'serverTimezone' configuration property) to use a more specifc time zone value if you want to utilize time zone support.
##Solution
由于mysql-connection-java版本导致时区问题

###解决方法1：
	在连接数据库的配置文件中url后面加上&serverTimezone=Asia/Shanghai或者&serverTimezone=UTC
	如果方法1没有用，使用方法2
###解决方法2：
	登录mysql，输入
	set global time_zone='+8:00'
	将时区改为中国时区
	
#Problem2
**jsp,html前端中链接路径中/的问题:<br>**
不以/开始的相对路径，找资源，以当前资源的路径为基准，进程容易出问题。

##Solution
以/开始的相对路径，找资源，以服务器的路径为标注(Htp://localhost:3306);其需要加上项目名才能找到,例如：<br>
http://localhost:3306/crud<br>
在jsp中可以在页面中加上<br>
``` 
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
    这里的"APP_PATH"是斜线开头，加上项目名，后面没有加个斜线
%>
```
例如：
```
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
```
