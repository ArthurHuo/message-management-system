<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var times=3;
		function window_load(){
		
			setInterval("showInfo()",1000); 
		}
		
		function showInfo(){
			if(times==0){
				window.location.href="<%=basePath%>UserServlet?m=login&id=<%=request.getParameter("id")%>&password=<%=request.getParameter("password")%>";
				return;
			}
			document.getElementById("info").innerHTML=times--;
		}
	</script>
  </head>
  
  <body onload="window_load();">
    注册成功<span id="info"><font color="red">4</font>4</span> 秒后转入登陆，如没有跳转，请点击<a href="UserServlet?m=login&id=<%=request.getParameter("id")%>&password=<%=request.getParameter("password")%>">自动登陆</a>
  </body>
</html>