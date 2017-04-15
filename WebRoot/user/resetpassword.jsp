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
		function checkForm(){

		
		
		if(document.getElementById("resetPassword").value != document.getElementById("password2").value){
			alert("两次输入的密码不一致！");
			return false;
		}
		
		if(document.getElementById("resetPassword").value.length < 6 || document.getElementById("password2").value.length > 16){
			alert("密码在6-16个字符之间！");
			return false;
		}
		
		
	}

</script>

</head>

<body>

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
			

				<div class="logoicon"></div>
				<div class="main_top">
					<p class="notice link" style="width:470px;">
						<span class="fb">密码找回</span>
					</p>
					<p class="title_note red"></p>
				</div>
				<div class="main_cen">
					<p class="title">密码找回</p>
			<form action="UserServlet" method="post" id="vForm" name="vForm" onsubmit="return checkForm();">
				<input type="hidden" name="m" value="resetPassword">
			<ul class="maintable">
			
			
				<li>
					<div class="mt_l">
						<span class="red">*</span>请输入新密码：
					</div>
					<div class="mt_r">
						<div class="inputbox">
							<span class="input"><cite><input id="resetPassword"
									name="resetPassword" type="password" maxlength="64" value="">
							</cite> </span>
						</div>
						<div id="idInfo"></div>

						<span id="usernametip"></span>

						<div class="inputtxt zi_9">
							6-16位字符（字母、数字、符号），区分大小写<br>为了您的帐号安全，请不要使用与您用户名相同的登录密码
						</div>
					</div>
				</li>
				<li>
							<div class="mt_l">
								<span class="red">*</span>密码确认：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="password2"
											name="password2" type="password"
											value=""> </cite> </span>
								</div>
								<span id="password2tip"></span>
							</div>
						</li>


				<li>



				<li>
					<div class="mt_l">

						<div class="mt_l">
							<input type="submit" value="提交" class="btn_submit">
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

</body>
</html>