<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<meta name="keywords" content="">
<meta name="description" content="">
	<title>mms系统登录</title>
	<style type="text/css">
/*Created by liuyao*/
/*初始化*/
html,body {
	height: 100%;
}

body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,p,blockquote,th,td
	{
	padding: 0;
	margin: 0;
}

body,fieldset,th,td,select,input,textarea {
	font-size: 12px;
	font-family: Arial, "宋体", sans-serif
}

fieldset,img {
	border: 0;
}

table {
	border-collapse: collapse;
	border-spacing: 0;
}

ol,ul {
	list-style: none;
}

address,caption,cite,code,dfn,em,strong,th,var {
	font-weight: normal;
	font-style: normal;
}

caption,th {
	text-align: left;
}

h1,h2,h3,h4,h5,h6 {
	font-weight: normal;
	font-size: 100%;
}

q:before,q:after {
	content: '';
}

abbr,acronym {
	border: 0;
}

label {
	cursor: pointer !important;
	cursor: hand
}

a {
	text-decoration: none;
	color: #087ad3;
}

a:hover {
	text-decoration: underline;
}

.error_color {
	color: #CC0000;
	font-weight: bold;
}
/*图片集成*/
input.smb_btn,a.smb_reg,.re_u,input.ipt-t,.login_mid .us ul li,.tipbox .box_top,.tipbox .box_bottom,.tipbox .box_center em
	{
	background: url('images/bgimg.gif') no-repeat 0 0;
}

.iconb {
	background: url('/images/icon.png') no-repeat 0 0;
}
/*主框架*/
#main_login {
	background: #fff;
	width: 950px;
	margin: 0 auto;
}
/*方案1 用bg01.jpg
方案2用 bg02.jpg
方案3注掉background
*/
.login_mid {
	position: relative;
	min-height: 400px;
	_height: 400px;
	color: #333;
	background: url('/images/bg01.jpg') no-repeat;
}

.login_mid:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
	visibility: hidden;
}

/*头*/
.main_head {
	margin-top: 14px;
	height: 46px;
}

.main_head img {
	float: left;
}

.main_head span {
	text-align: right;
	float: right;
	padding-top: 18px;
}

.main_head span a,.main_head span a:link,.main_head span a:visited {
	color: #333
}

.main_head em {
	color: #e1e1e1;
	padding: 0 7px;
}
/*登录区*/
.login_mid .login_box {
	width: 298px;
	border-right: 1px solid #f0f6fa;
	border-bottom: 1px solid #f0f6fa;
	padding: 0 1px 1px 0;
	background-color: #e0ecf5;
	min-height: 388px;
	_height: 388px;
	float: right;
}
/*.login_mid .login_box{position:absolute;top:0;right:0;width:298px;min-height:388px;border-right:1px solid #f0f6fa;border-bottom:1px solid #f0f6fa;padding:0 1px 1px 0;background-color:#e0ecf5;}*/
.login_mid .login_box .boxbg {
	background-color: #f9fcfd;
	width: 296px;
	min-height: 386px;
	_height: 386px;
	border: 1px solid #bdc8d9;
	color: #666;
}

.login_mid .login_box .boxbg .title {
	width: 250px;
	height: 30px;
	line-height: 30px;
	overflow: hidden;
	margin: 4px 0 12px 15px;
	font-size: 16px;
	font-family: "微软雅黑", "宋体";
}
/*个人信息*/
.introduce {
	width: 640px;
	clear: both;
	margin-top: 339px;
}

.introduce .intro {
	float: left;
	width: 300px;
}

.introduce .intro p {
	line-height: 1.5em;
	margin-bottom: 8px;
}

.introduce .intro p a {
	font-weight: bold;
}

.introduce .us {
	width: 300px;
	float: right;
}

.introduce .us .title {
	font-weight: bold;
	padding: 0 0 1px 9px;
}

.introduce .us ul li {
	height: 21px;
	line-height: 21px;
	padding-left: 9px;
	background-position: 0 -262px;
}

.userinfo {
	font-size: 14px;
	margin-left: 30px;
}

.userinfo ul li {
	height: 30px;
	line-height: 30px;
	margin-bottom: 18px;
	position: relative;
	width: 250px;
}

.userinfo ul li span {
	margin-right: 2px;
}

.userinfo ul li.s_btn {
	height: 30px;
	padding: 10px 0 0 57px;
	width: 194px;
	overflow: hidden;
}

.userinfo ul li.s_btn a {
	font-size: 12px;
	margin-right: 8px;
	float: left;
	white-space: nowrap;
}

.userinfo ul li.valid_num {
	padding-left: 57px;
	_padding-left: 53px;
	margin-top: -18px;
	margin-bottom: 0;
	width: 198px;
	height: 90px;
	_height: 87px;
}

.userinfo ul li .valid_img {
	float: left;
}

.userinfo ul li .valid_tip {
	font-size: 12px;
	color: #999;
	line-height: 28px;
}

.userinfo ul li .valid_change {
	font-size: 12px;
	padding-left: 8px;
	line-height: 50px;
}

.astip ul li.s_btn {
	padding-top: 0;
}
/*.userinfo ul li.s_state {font-size:12px;height:18px;line-height:18px;padding-left:57px;_padding-left:53px;width:194px; margin:-2px 0 20px 0; z-index:10;}*/
.userinfo ul li.s_state {
	font-size: 12px;
	height: 18px;
	line-height: 18px;
	padding-left: 57px;
	_padding-left: 53px;
	width: 194px;
	margin: -2px 0 20px 0;
	z-index: 10;
	clear: left;
}

.userinfo ul li.s_state a {
	margin-left: 25px;
}

input.tl {
	margin-right: 3px;
	padding: 0;
	vertical-align: -2px;
	_vertical-align: 0px;
}

.userinfo ul li.s_state .login_tip {
	width: 181px;
	height: 31px;
	padding: 10px;
	overflow: hidden;
	background: url(/images/login_tip_bg.png) no-repeat;
	color: #dc0006;
	position: absolute;
	right: 29px;
	*right: 15px;
	top: 16px;
}
/*提示框*/
.tipbox {
	font-size: 12px;
	width: 203px;
	position: absolute;
	bottom: 30px;
	left: 50px;
	color: #CC0000
}

.tipbox .box_top {
	background-position: 0 -160px;
	height: 2px;
	overflow: hidden;
}

.tipbox .box_center {
	width: 182px;
	border-left: 1px solid #c6c6c6;
	border-right: 1px solid #c6c6c6;
	background: #ffffe3;
	padding: 4px 7px 5px 10px;
	padding-bottom: 0\9;
	line-height: 1.2em;
	zoom: 1;
	overflow: hidden;
}

.tipbox .box_bottom {
	background-position: 0 -186px;
	height: 7px;
	overflow: hidden;
	clear: both;
}

.tipbox .box_center span {
	float: left;
	width: 170px;
}

.tipbox .box_center em {
	background-position: -210px -167px;
	cursor: pointer;
	float: right;
	height: 9px;
	line-height: 999em;
	overflow: hidden;
	width: 8px;
}

.tipbox .box_center label {
	color: #087AD3;
	cursor: default;
}
/*验证码*/
.astip ul li {
	margin-bottom: 6px;
}

.code {
	width: 60px;
	height: 21px;
	position: absolute;
	top: 5px;
	right: 37px;
}
/*input & btn*/
input.ipt-c {
	color: #bbbbbb;
}

input.ipt-t {
	font-size: 14px;
	width: 150px;
	height: 19px;
	padding: 4px 5px 1px;
	background-position: 0 -105px;
	border: 1px solid #4b80a5;
	margin-left: 0;
	margin-left: 3px\9;
	margin-left: 0\0;
	margin: 1px;
}

input.ipt-active {
	color: #333;
	border: 2px solid #5b8eb1;
	margin: 0;
}

input.ipt-error {
	border: 2px solid #e54246;
	margin: 0;
}

input.code-t {
	width: 80px;
}

input.smb_btn {
	border: 0;
	background-position: 0 0;
	width: 107px;
	height: 30px;
	cursor: pointer;
}

a:hover input.smb_btn {
	background-position: -140px 0;
}

a.smb_reg {
	border: 0;
	background-position: 0 -40px;
	width: 129px;
	height: 34px;
	cursor: pointer;
	margin-top: 8px;
	display: block;
	margin-left: 87px;
	margin-bottom: 14px;
}

a.smb_reg:hover {
	background-position: -140px -40px;
	display: block;
}
/*新用户*/
.re_u {
	height: 33px;
	line-height: 33px;
	width: 279px;
	overflow: hidden;
	background-position: 0 -208px;
	clear: both;
	margin-top: 30px;
	padding-left: 15px;
}
/*介绍*/
.new_introduce {
	width: 640px;
	min-height: 400px;
	_height: 400px;
	zoom: 1;
	overflow: hidden;
	float: left;
}
/*.new_introduce{min-height:400px;_height:400px;height:auto;width:640px;zoom:1;overflow:hidden;}*/
/*介绍带图*/
.iconb {
	width: 50px;
	height: 50px;
	overflow: hidden;
	float: left;
}

ul.i_b li {
	zoom: 1;
	overflow: hidden;
	padding-top: 30px;
	min-height: 50px;
	_height: 50px;
	height: auto;
}

ul.i_b li p {
	line-height: 1.5em;
	float: left;
	width: 420px;
	padding-left: 15px;
}
/*介绍带图 s*/
ul.i_bs li {
	float: left;
	height: 100px;
	width: 307px;
	border-right: 1px solid #e3e3e3;
	padding: 0 0 0 10px;
}

ul.i_bs li p {
	line-height: 1.5em;
	float: left;
	width: 225px;
	margin-left: 10px;
	height: 100px;
	overflow: hidden;
	color: #666;
	line-height: 22px;
}

ul.i_bs li p em {
	display: block;
	height: 22px;
	background: url(/images/login_dot.gif) left 48% no-repeat;
	padding-left: 8px;
}

ul.i_bs li.last {
	border: 0;
}

ul.i_bs li.last p {
	width: 240px;
}

ul.i_bs li span,ul.i_b li span {
	font-size: 14px;
	font-weight: bold;
	color: #087ad3;
	line-height: 2em;
	display: block;
}

.b01 {
	background-position: 0 0;
}

.b02 {
	background-position: -80px 0;
}

.b03 {
	background-position: -160px 0;
}

.b04 {
	background-position: -240px 0;
}

.b05 {
	background-position: -320px 0;
}

.b06 {
	background-position: -400px 0;
}
/*尾*/
.footer {
	border-top: 1px solid #f3f3f3;
	line-height: 1.8em;
	padding: 18px 0;
	color: #999;
	clear: both;
	margin-top: 20px;
}

.footer em {
	color: #cbcbcc;
	padding: 0 7px;
}

.footer a:link,.footer a:visited {
	color: #666;
}

.footer p {
	float: left;
}

.footer div {
	float: right;
	text-align: right;
}

</style>
<script type="text/javascript">
		if(window!=top){
			top.location=window.location;
		}
	</script>
</head>
<body >

	<!--main-->
	<div id="main_login">
		<!--头-->
		<div class="main_head">
			<span> </span>
		</div>
		<!--中-->
		<div class="login_mid">
			<!--介绍-->
			<!-- 注：方案1去掉整个new_introduce层-->
			<!--介绍 /-->
			<!--登录-->
			<div class="login_box">

				<div class="boxbg">

					<div class="title"></div>
					<form id="loginForm" action="LoginServlet?m=login" method="post"
						onsubmit="check();return false;">
						<div class="userinfo">
							<ul>
								<li>登录名：<input type="text" onblur="checkUserMail(this)"
									maxlength="50" id="id" name="id" class="ipt-c ipt-t" value=""
									autocomplete="off" tabindex="2">
										<div style="display: none;" id="username_tip" class="tipbox">
											<div class="box_top"></div>
											<div class="box_center"></div>
											<div class="box_bottom"></div>
										</div>
								</li>
								<li><span>密&nbsp;&nbsp;&nbsp;码：</span><input
									type="password" maxlength="50" id="password" name="password"
									class="ipt-t" value="" tabindex="2">
										<div style="display: none;" id="password_tip" class="tipbox">
											<div class="box_top"></div>
											<div class="box_center"></div>
											<div class="box_bottom"></div>
										</div>
								</li>

								<li style="display:none" id="vsn_content"><span>动态码：</span><input
									type="text" autocomplete="off" disabled="disabled" value=""
									class="ipt-t" name="vsncode" id="vsncode" maxlength="6"
									tabindex="2"> <!--错误提示-->
										<div class="tipbox" id="vsncode_tip" style="display: none;">
											<div class="box_top"></div>
											<div class="box_center">
												<span id="vsncode_tip_text">动态码不能为空</span><a
													href="http://login.sina.com.cn/#" title="关闭"
													onclick="document.getElementById(&#39;vsncode_tip&#39;).style.display=&#39;none&#39;;"><em>关闭</em>
												</a>
											</div>
											<div class="box_bottom"></div>
										</div> <!--错误提示 end-->
								</li>

								<li id="door_content1" style="display:none">验证码：<input
									type="text" value="" class="ipt-t" id="door" autocomplete="off"
									disabled="disabled" tabindex="2"> <!--错误提示-->
										<div style="display: none;" id="door_tip" class="tipbox">

											<div class="box_top"></div>
											<div class="box_center">
												<span id="door_tip_text">验证码不能为空</span><a
													onclick="document.getElementById(&#39;door_tip&#39;).style.display=&#39;none&#39;;"
													title="关闭" href="http://login.sina.com.cn/#"><em>关闭</em>
												</a>
											</div>
											<div class="box_bottom"></div>
										</div> <!--错误提示 end-->
								</li>
								<li class="valid_num" style="display:none" id="door_content2">
									<p class="valid_tip">按下面图符填写，不区分大小写</p>
									<div class="valid_img">
										<img src="" width="100" height="40" id="check_img">
									</div> <span class="valid_change"><a
										href="javascript:con_code();">看不清，换一换</a> </span></li>

								

								<label><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=(request.getAttribute("info") != null) ? request
					.getAttribute("info") : ""%></font> </label>


								<li class="s_btn"><a href="javascript:void(0);"><input
										type="submit" class="smb_btn" value="">
								</a><a href="user/lostpassword.jsp">找回密码</a>
								</li>
							</ul>
						</div>
					</form>
					<div class="re_u">还没有注册？</div>
					<a id="reg" title="立即注册" class="smb_reg" href="LoginServlet?m=regInput"
						target="_blank"></a>
				</div>
			</div>
		</div>
	</div>


	<div>
		<ul class="passCard" id="sinaNote" style="display: none; "></ul>
	</div>
</body>
</html>