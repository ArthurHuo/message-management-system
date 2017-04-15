<%@ page language="java" import="java.util.*,org.leadfar.mms.model.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<% User loginUser = (User)request.getSession().getAttribute("LOGIN_USER"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/index.css">


</head>

<body>


	<div id=top>

		<div id=logo>
			<img src="images/logo.gif" width="145" height="50" />
		</div>



		<div id=hy>

			<strong><%=loginUser.getId() %>【<%=loginUser.getName() %>】
			</strong><br />

			<ul>
				<li>一款超牛的消息管理系统</li>
			</ul>

		</div>
		<div id="s">
			<span><a href="UserServlet?m=loginOut" target="_top">注销</a>| <a href="user/changepassword.jsp" target="_top">修改密码</a> | 个人信息 | 帮助</span>
			<form action="MessageServlet?m=list" method="post" target="rightFrame">
				<input type="image" src="images/inputbg_02.gif" style="float:right; margin-top:20px;">
				<input type="text"class="input1" size="50" name="title" margin-top:20px;>
			</form>
		</div>
	</div>
</body>
</html>
