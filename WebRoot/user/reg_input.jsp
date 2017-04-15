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
<!-- saved from url=(0057)https://login.sina.com.cn/signup/signupmail.php?entry=sso -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>注册新用户</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="common/common.js"></script>

<!-- 
<script type="text/javascript" src="js/vconf.js"></script> 
<script type="text/javascript" src="js/validator.js"></script>
-->
<script type="text/javascript">
	
	function check(){
		var id = document.getElementById("id").value;
		if(id == ""){
			return;
		}else{
			i.location.href="UserServlet?m=check&id="+id;
		}
	}
	
	function reloadImg(){
		document.getElementById("codeImg").src = "check.jpg?id="+Math.random();
	}
	
	function checkc(){
		var code = document.getElementById("checkCode").value;
		if(code == ""){
			return;
		}else{
			i.location.href="UserServlet?m=checkCode&checkCode="+code;
		}
	}
	
	function checkForm(){
		var checkid = document.getElementById("id").value
		if(checkid == null || checkid == ""){
			alert("用户名不能为空！");
			return false;
		}
		if(checkid.length < 4 || checkid.length > 20){
			alert("用户名要在4-20字符内！");
			return false;
		}
		
		if(document.getElementById("password").value != document.getElementById("password2").value){
			alert("两次输入的密码不一致！");
			return false;
		}
		
		if(document.getElementById("password").value.length < 6 || document.getElementById("password").value.length > 16){
			alert("密码在6-16个字符之间！");
			return false;
		}
		
		if(document.getElementById("password").value == checkid){
			alert("密码不能与用户名相同！");
			return false;
		}

		
		var question = document.getElementById("question").value;
		if(question == "00"){
			alert("请选择密码保护问题！");
			return false;
		}
		
		var checkanswer = document.getElementById("answer").value
		if(checkanswer == null || checkanswer == ""){
			alert("密码保护答案不能为空！");
			return false;
		}
		
		var checknick = document.getElementById("nick").value
		if(checknick == null || checknick == ""){
			alert("昵称不能为空！");
			return false;
		}
		
		var checkname = document.getElementById("name").value
		if(checkname == null || checkname == ""){
			alert("真实姓名不能为空！");
			return false;
		}
		
		var checkmobile = document.getElementById("mobile").value
		if(checkmobile == null || checkmobile == ""){
			alert("手机号码不能为空！");
			return false;
		}
		if(checkmobile.length < 11 || checkmobile.length > 11){
			alert("请输入11位手机号码");
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
				mms新用户注册
				<p class="title_note red"></p>
			</div>
			<div class="headlink">
				<a href="http://">首页</a> | <a href="https://l">帮助</a>
			</div>
			<div class="clearit"></div>
		</div>

		<div class="main">
			<form action="UserServlet" method="post" target="i" id="vForm"
				name="vForm" onsubmit="return checkForm();">
				<input type="hidden" name="m" value="reg"> <input
					type="hidden" id="act" name="act" value="1"> <input
					type="hidden" id="entry" name="entry" value="sso"> <input
					type="hidden" id="r" name="reference" value="">
				<div class="logoicon"></div>
				<div class="main_top">
					<p class="notice link" style="width:470px;">
						<span class="fb">提示：</span>如果已经注册，您可以<a href="https://">直接登录</a>
					</p>
					<p class="title_note red"></p>
				</div>
				<div class="main_cen">
					<p class="title">新用户注册</p>
					<ul class="maintable">
						<li>
							<div class="mt_l">
								<span class="red">*</span>用户名：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="id"
											name="id" type="text" maxlength="64"
											value=""> </cite> </span>
								</div>
								<div id="idInfo"></div>
								<input type="button" value="检查用户名是否可用" onclick=check()>
								<span id="usernametip"></span>

								<div class="inputtxt zi_9">请输入您的用户名,在4-20个字符之间</div>
							</div>
						</li>
						<li>
							<div class="mt_l">
								<span class="red">*</span>密码：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="password"
											name="password" type="password"
											value=""> </cite> </span>
								</div>
								<span class="inputfloat" id="passW">
									<div class="passW" id="passW1">
										<span class="passW_w"></span><span class="passW_t">弱</span>
									</div>
									<div class="passW" id="passW2">
										<span class="passW_w"></span><span class="passW_t">中</span>
									</div>
									<div class="passW" id="passW3">
										<span class="passW_w"></span><span class="passW_t">强</span>
									</div> </span> <span id="passwordtip"></span>
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
							<div class="mt_l">
								<span class="red">*</span>密码提示问题：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite> <select id="question"
											name="question">
												<option value="00">请选择一个问题</option>
												<%
													List<Question> qs = (List<Question>)request.getAttribute("questions"); 
																																										 for(Question q:qs){
												%>
												<option value="<%=q.getId()%>"><%=q.getTitle()%></option>
												<%
													}
												%>
										</select> </cite> </span>
								</div>
								<span id="password2tip"></span>
								<div class="inputtxt zi_9">请选择提示问题，以便找回密码</div>
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
						<!--add info 添加用户注册信息 -->
						<!--add end-->
					</ul>
					<p class="title">填写个人资料</p>
					<ul class="maintable">
						<li>
							<div class="mt_l">
								<span class="red">*</span>昵称：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="nick"
											name="nick" type="text" value="">
									</cite> </span>
								</div>
								<span id="nicktip"></span>
								<div class="inputtxt zi_9"></div>
							</div>
						</li>
						<li>
							<div class="mt_l">
								<span class="red">*</span>真实姓名：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="name"
											name="name" type="text"
											value=""> </cite> </span>
								</div>
								<span id="password2tip"></span>
							</div>
						</li>

						<li>
							<div class="mt_l">
								<span class="red">*</span>手机号码：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite><input id="mobile"
											name="mobile" type="text"
											value=""> </cite> </span>
								</div>
								<span id="password2tip"></span>
							</div>
						</li>
					</ul>
					<!-- 先注释掉，不确定是否能下
-->
					<p class="title">填写验证码</p>
					<ul class="maintable">
						<li>
							<div class="mt_l">
								<span class="red">*</span>验证码：
							</div>
							<div class="mt_r">
								<div class="inputbox">
									<span class="input"><cite> <input
											autocomplete="off" id="checkCode" name="checkCode"
											type="text" value="" onblur="checkc()"> </cite> </span>
								</div>

								<img src="check.jpg" id="codeImg" onclick="reloadImg();">
								<span id="codeInfo"></span>
							</div>
						</li>
						<li>
							<div class="mt_l"></div>
							<div class="mt_r">
								<div class="inputacc">
									<input id="after" name="after" type="checkbox"
										alt="请确认您已看过并同意《mms服务使用协议》:条款/errArea{aftertip}"
										checked="checked">&nbsp;我已经看过并同意《<a href="https://"
										target="_blank">mms服务使用协议</a>》
								</div>
								<span id="aftertip"></span>
							</div>
						</li>
						<li>
							<div class="mt_l"></div>
							<div class="mt_r">
								<input type="submit" class="btn_submit" value="提交">
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

	<iframe id="i" name="i" src="" width=0></iframe>

	<script type="text/javascript">
		function con_code() {
			var qq = Math.round((Math.random()) * 100000000);
			$("check_img").src = '/cgi/pin.php?r=' + qq;
		}
		onReady(function() {
			var conf = (typeof $vconf == 'undefined') ? {} : $vconf;
			var v = new Validator(conf);
			v.init('vForm');
		});
		//在标签内加入 onfocus="suozaidi_onfocus(this)"
		function suozaidi_onfocus(m) {
			$addClassName(m.parentNode.parentNode, "inputGreen");
		}
		//在标签内加入 onblur="suozaidi_onblur(this)"
		function suozaidi_onblur(m) {
			$removeClassName(m.parentNode.parentNode, "inputGreen");
		}
	</script>


</body>
</html>