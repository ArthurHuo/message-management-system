<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.leadfar.mms.model.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<base href="<%=basePath%>">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>找回密码</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="common/common.js"></script>
<script type="text/javascript">
	function next(){
        var id = document.getElementById("id").value;
		window.location.href="<%=basePath%>LoginServlet?m=lostPassword&id="+id;

	}
	function next2(){
		var id = document.getElementById("id").value;
		alert(id);
        var id = document.getElementById("answer").value;
		window.location.href="LoginServlet?m=checkAnswer&answer="+id;

	}
</script>

</head>

<body>
<%if(request.getAttribute("info") == null){ %>
	<div id="wrap">
		<div class="head">
			<div class="logo"></div>
			<div class="logotxt">
			
				<p class="title_note red"></p>
			</div>
			<div class="headlink">
				<a href="http://">首页</a> | <a href="https://l">帮助</a>
			</div>
			<div class="clearit"></div>
		</div>

		<div class="main">
			<form action="UserServlet" method="post" target="i" id="vForm"
				name="vForm">
				<input type="hidden" name="m" value="reg"> <input
					type="hidden" id="act" name="act" value="1"> <input
					type="hidden" id="entry" name="entry" value="sso"> <input
					type="hidden" id="r" name="reference" value="">
				<div class="logoicon"></div>
				<div class="main_top">
					<p class="notice link" style="width:470px;">
						<span class="fb">密码找回</span>
					</p>
					<p class="title_note red"></p>
				</div>
				<div class="main_cen">
					<p class="title">密码找回</p>
					<ul class="maintable">
						<li>
							<div class="mt_l">
								<span class="red">*</span>请输入要找回的用户名：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="id"
											name="id" type="text" maxlength="64"
											value=""> </cite> </span>
								</div>
								<div id="idInfo"></div>
								
								<span id="usernametip"></span>

								<div class="inputtxt zi_9">请输入您的用户名,在4-20个字符之间</div>
							</div>
						</li>
						
						

						
						<li>
							<div class="mt_l">

								<input type="button" value="下一步" onclick="next()" class="btn_submit">
							</div>

						</li>

					</ul>
		
					
					

				</div>
				<div class="main_bottom"></div>
			</form>
		</div>

		<div class="Footer">
			<p>&nbsp;</p>
			<p>
				Copyright &#169; HJT Corporation, All Rights Reserved HJT <a
					target="_blank" href="http://">版权所有</a>
			</p>

		</div>
	</div>

<%} else {%>
	<%User userlost = (User)request.getAttribute("userlost"); %>
	<%request.setAttribute("userlost",(User)request.getAttribute("userlost")); %>

	<input type="hidden" id="userlost" value="">
	<div id="wrap">
		<div class="head">
			<div class="logo"></div>
			<div class="logotxt">
			
				<p class="title_note red"></p>
			</div>
			<div class="headlink">
				<a href="http://">首页</a> | <a href="https://l">帮助</a>
			</div>
			<div class="clearit"></div>
		</div>

		<div class="main">
			<form action="LoginServlet" method="post" id="lForm"
				name="lForm" >
				<input type="hidden" id="m" name="m" value="checkAnswer">

				 <input	type="hidden" id="userlost" name="userlost" value="<%=request.getParameter("id")%>"> 
				<div class="logoicon"></div>
				<div class="main_top">
					<p class="notice link" style="width:470px;">
						<span class="fb">密码找回</span>
					</p>
					<p class="title_note red"></p>
				</div>
				<div class="main_cen">
					<p class="title">密码找回</p>
					<ul class="maintable">
						<li>
							<div class="mt_l">
							<span class="red">*</span>密码保护问题：
					
						
							</div>
							<div class="mt_r">
							<span class="red"><%=userlost.getQuestion().getTitle() %></span>
					
						
							</div>
											
						</li>
						
						<li>
							<div class="mt_l">
								<span class="red">*</span>问题答案：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="answer"
											name="answer" type="text"
											value=""> </cite> </span>
								</div>
								<span id="password2tip"></span>
							</div>
						</li>

						
						<li>
							<div class="mt_l">

								
								<div class="mt_l">
								<input type="submit"  value="下一步" class="btn_submit">
							</div>
							</div>

						</li>

					</ul>
		
					
					

				</div>
				<div class="main_bottom"></div>
			</form>
		</div>

		<div class="Footer">
			<p>&nbsp;</p>
			<p>
				Copyright &#169; HJT Corporation, All Rights Reserved HJT <a
					target="_blank" href="http://">版权所有</a>
			</p>

		</div>
	</div>
<%} %>


</body>
</html>