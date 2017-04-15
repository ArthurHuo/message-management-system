<%@ page language="java" import="java.util.*,org.leadfar.mms.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	Message message=(Message)request.getAttribute("message");

%>

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
    
    <title>发送消息</title>
    
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
	function userShow(){
	if(document.getElementById("tdUser").style.display==""){
				document.getElementById("tdUser").style.display="none";
			}else{
				document.getElementById("tdUser").style.display="";
			}
	}

</script>

  </head>
  
  <body>
<div id=content>
  <div id=sm>
  	回复消息
  </div>

<div id="stylized" class="myform">

<table>
  <tr>
  <td width = "80%">
    <form id="form" name="form" method="post" action="MessageServlet?m=add">
    	<table>
    		<tr>
    			<td width = "100">
    				<label>收件人
			       </label>
    			</td>
    			<td>
      				<input type="text" id="receiver" name="receiver" maxlength="255" size="70" />
      				<input type="button" value="请选择收信人" onclick="userShow()" style="float:left;" class="btn_submit">
      			</td>
    		</tr>

    		<tr>
    			<td>
    				<label>标题
			       </label>
    			</td>
    			<td>
    				<input type="text" name="title" maxlength="255" size="70" value="<%=(message!=null)?"转发:"+message.getTitle():"" %>"/>
   			</td>
    		</tr>
    		<tr>
    			<td>
    				<label>内容
			            <span class="small">请输入消息的内容</span>
			       </label>
    			</td>
    			<td>

    				<textarea name="content" style="width:700px;height:200px;visibility:hidden;"><%=(message!=null)?message.getContent():"" %></textarea>
    				
    				<ckeditor:replace replace="editor1" basePath="/ckeditor/" />
    			</td>
    		</tr>
    		
    		<tr><td></td>
    			<td colspan="2"  align="center">
    				<input type="submit" value="发送消息"  class="btn_submit">
    			</td>
    		</tr>
    	</table>
    	
       
       <div class="spacer"></div>
    </form>
    <td id="tdUser" style="display:none;"  valign="top"><iframe src="UserServlet?m=list" width="100%" height="300" frameborder="0"></iframe>
    </td>
    </td>
      </tr>
    </table>
</div>

 </div>
</body>

</html>
