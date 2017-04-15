<%@ page language="java" import="java.util.*,org.leadfar.mms.model.*" pageEncoding="UTF-8"%>
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

<title></title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="css/index.css">

<script type="text/javascript">
	function check(obj){
			if(obj.checked){
				//alert(parent.document.getElementById("receiver").value);
				parent.document.getElementById("receiver").value+=obj.value+";";
				
			}else{
				parent.document.getElementById("receiver").value=parent.document.getElementById("receiver").value.replace(obj.value+";","");
			}
		}

</script>


</head>

<body>
	<table>
	<% List<User> users = (List<User>)request.getAttribute("users");
		for(User u : users){
	 %>
	<tr><td><input type="checkbox" onclick="check(this)" value="<%=u.getId()%>"></td><td><%=u.getId() %>【<%=u.getName() %>】</td></tr>
	<%} %>
	</table>
</body>

</html>
