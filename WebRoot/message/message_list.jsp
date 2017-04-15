<%@ page language="java" import="java.util.*,org.leadfar.mms.model.*,org.leadfar.mms.utils.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% Page p = (Page)request.getAttribute("page"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    

<link rel="stylesheet" type="text/css" href="css/index.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
		//function go(no){
		//	window.location.href="<%=basePath%>MessageServlet?m=receive&pageNo="+no
		//}
		function go(no){
			//window.location.href="<%=basePath%>MessageServlet?m=receive&pageNo="+no
			document.getElementById("pageNo").value=no;
			document.getElementById("f").submit();
		}
		
		function checkAll(chk){
			var cs=document.getElementsByName("c");
			for(var i=0;i<cs.length;i++){
				cs[i].checked=chk.checked;
			}
		}
		function delBatch(){
			document.getElementById("m").value="delBatch";
			document.getElementById("f").submit();
		}
		function truncate(){
			document.getElementById("m").value="truncate";
			document.getElementById("f").submit();
		}
		function restore(){
			document.getElementById("m").value="restore";
			document.getElementById("f").submit();
		}
	</script>
  </head>
  
  <body>
  <form id="f" action="MessageServlet" method="post">
<div id=content>
  <div id=sm>
<% String m=""; if(p.getMode()==MessageListMode.RECEIVE) {m="receive";%>
  	收新消息：您有【<%=p.getRowCount() %>】条未读消息
  	<%}else if(p.getMode()==MessageListMode.LIST) { m="list"; %>
  	检索结果：共有【<%=p.getRowCount() %>】条消息
  	<%}else if(p.getMode()==MessageListMode.INBOX){ m="inbox"; %>
  	收件箱：共有【<%=p.getRowCount() %>】条消息
  	<%}else if(p.getMode()==MessageListMode.OUTBOX){ m="outbox"; %>
  	垃圾箱：共有【<%=p.getRowCount() %>】条消息
	<%} %>  	
  		<input type="hidden" name="m" id="m" value="<%=m%>">
  		<input type="hidden" name="title" value="<%=(request.getParameter("title")==null)?"": request.getParameter("title")%>">
  		<input type="hidden" name="pageNo" id="pageNo" value="<%=p.getPageNo() %>">
  		<input type="hidden" name="mode" id="mode" value="<%=m%>">
  	

  	
  	
  </div>
<div><% if(p.getMode()==MessageListMode.OUTBOX){ %>
	<input type="button" value="彻底删除" onclick="truncate();" class="btn_submit"><input type="button" value="恢复" onclick="restore();" class="btn_submit"></div>
	<%} else{ %>
		<input type="button" value="删除" onclick="delBatch();" class="btn_submit">
	<%} %>
  <div>
  <div>
	    <table>
	    	<tr>
	    		<th><input type="checkbox" onclick="checkAll(this)">全选</th>
	    		<th width="10%">状态</th>
	    		<th width="40%">标题</th>
	    		<th>发送者</th>
	    		<th>发件时间</th>
	    		
	    	</tr>
	    	<% 
	    		List<MessageLog> logs=(List<MessageLog>)request.getAttribute("logs");
	    		for(MessageLog log:logs){
	    	
	    	%>
	    	<tr>
	    		<% if(p.getMode()==MessageListMode.OUTBOX){ %>
	        	<td><input type="checkbox" name="c" value="<%=log.getId() %>"></td>
	           <%} else{ %>
	    		<td><input type="checkbox" name="c" value="<%=log.getId() %>" <%=log.isDel()?"disabled":"" %>></td>
	    		<%} %>
	    		<td><%=log.isRead()?"已读":"未读" %></td>
	    		<td><a href="MessageServlet?m=read&logId=<%=log.getId()%>"><%=log.getMessage().getTitle() %></a></td>
	    		<td><%=log.getMessage().getSender().getId() %></td>
	    		<td><%=log.getMessage().getSendTime() %></td>
	    		
	    	</tr>

		<%} %>
	    </table>
	</div>
	<br>
	<p align=center>
	<%if(p.getPageNo()>1){ %><a href="javascript:go(1)">首页</a><%}else if(p.getPageNo() == 1){ %>
	首页<%} %>
	<%if(p.getPageNo()>1){ %><a href="javascript:go(<%=p.getPageNo()-1%>)">上一页</a><%} else if(p.getPageNo() == 1){%>
	上一页<%} %>
	<select onchange="go(this.value);">
		<% for(int i=1;i<=p.getPageSum();i++){ %>
		<option value="<%=i %>" <%=(p.getPageNo()==i)?"selected":""%>  > 第<%=i%>页</option>
		<%} %>
	</select>
	<%if(p.getPageNo()<p.getPageSum()){ %><a href="javascript:go(<%=p.getPageNo()+1%>)">下一页</a><%} else if(p.getPageNo()>=p.getPageSum()){%>
	下一页<%} %>
	<%if(p.getPageNo()<p.getPageSum()){ %><a href="javascript:go(<%=p.getPageSum()%>)">尾页</a><%} else if(p.getPageNo()>=p.getPageSum()){%>
	尾页<%} %>
	<p>

</div>
  	</form>
  </body>
</html>
