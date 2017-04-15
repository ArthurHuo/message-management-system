<%@ page language="java" import="java.util.*,org.leadfar.mms.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%Message message = (Message)request.getAttribute("message"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script charset="utf-8" src="kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="kindeditor/lang/zh_CN.js"></script>
		<script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link']
				});
			});
		</script>
  
  
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
		function reply(id){
			window.location.href="<%=basePath%>MessageServlet?m=reply&msgId="+id;
			
		}
		function toOther(id){
		
			window.location.href="<%=basePath%>MessageServlet?m=forward&msgId="+id;
			
		}
	</script>
  </head>
  
  <body>
<div id=content>
  <div id=sm>
	接收消息
  </div>
<div><input type="button" value="回复" class="btn_submit" onclick="reply(<%=message.getId()%>)"><input type="button" value="转发" class="btn_submit" onclick="toOther(<%=message.getId() %>)"></div>
<div id="stylized" class="myform">

<table>
  <tr>
  <td width = "80%">
    <form id="form" name="form" method="post" action="MessageServlet?m=add">
    	<table>
    		<tr>
    			<td width = "100">
    				<label>消息来源
			        </label>
    			</td>
    			<td>
    				发送者:<%=message.getSender().getId() %>[<%=message.getSender().getName() %>]<br/>
    				送达时间:<%=message.getSendTime() %><br/>
    			</td>
    		</tr>

    		<tr>
    			<td>
    				<label>标题
			       </label>
    			</td>
    			<td>
    				<%=message.getTitle() %>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<label>内容
			       </label>
    			</td>
    			<td>
    				<!-- <textarea rows="20" cols="70" name="content" disabled font-size="20px"><%=message.getContent() %></textarea>-->
    				<textarea name="content" style="width:700px;height:200px;visibility:hidden;"><%=message.getContent() %></textarea>
    			</td>
    		</tr>

    	</table>
    	
       
       <div class="spacer"></div>
    </form>
    
    </td>
    </td>
      </tr>
    </table>
</div>

 </div>
</body>

</html>
