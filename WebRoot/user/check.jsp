<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'check.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	<%if (request.getAttribute("info") != null) {
	     if(((String)request.getAttribute("info")).indexOf("验证码") > -1){
		    if (request.getAttribute("isOk") == "true") {%>
		   	    parent.document.getElementById("codeInfo").innerHTML="<font color='green'><%=request.getAttribute("info")%></font>"
	    <%} else {%>
			    parent.document.getElementById("codeInfo").innerHTML="<font color='red'><%=request.getAttribute("info")%></font>"
               <%}%>
	  <%}else{
	        if (request.getAttribute("isOk") == "true") {%>
	  			 parent.document.getElementById("idInfo").innerHTML="<font color='green'><%=request.getAttribute("info")%></font>"
	    <%} else {%>
			    parent.document.getElementById("idInfo").innerHTML="<font color='red'><%=request.getAttribute("info")%></font>"
               <%}%>
	  
	  
	  		<%}%>
    <%}%>
	
</script>
</head>

<body>
	This is my JSP page.
	<br>
</body>
</html>
