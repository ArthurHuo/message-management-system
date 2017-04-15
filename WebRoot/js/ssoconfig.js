sinaSSOConfig = new function() {
	this.entry = "account";
	this.isCheckLoginState = false;
	this.scriptLoginHttps = true;
	this.setDomain = true;
	if (location.protocol == "https:") {
		this.loginType = 1;
		this.crossDomain = false;
	} else {
		this.crossDomain = true;
	}
	
	var pined = false;
	
	this.customLoginCallBack = function(loginStatus) {
		if (!loginStatus.result) {
			if ( loginStatus.errno == "4010"){
				loginStatus.reason = "帐号尚未激活，请<a href=\"/signup/signupmail1.php\">点此激活</a>";
			}
			//验证码错误处理
			if( loginStatus.errno == '2070' ) {
				hideTip();
				changePincode();
				custom_alert("door", loginStatus.reason);
				return false;
			}
			//异地登陆
			if( loginStatus.errno === '4049' ){
				var door = document.getElementById('door');
				document.getElementById('door_content1').style.display = '';
				document.getElementById('door_content2').style.display = '';
				//清空验证码
				door.value = '';
				//重新激活验证字段
				door.disabled = false;
				//设置验证码图片src
				var random = Math.floor( Math.random()*100000000 ) ;
				document.getElementById("check_img").src = "http://login.sina.com.cn/cgi/pin.php?r=" + random + "&s=0";
				pined = true;
				//设置提示信息
				loginStatus.reason = !!loginStatus.reason ? loginStatus.reason : "请输入验证码";
				//隐藏其他的提示框
				hideTip();
				//显示验证码提示
				custom_alert("door", loginStatus.reason);
				return false;
			}
			//微盾动态码
			if( loginStatus.errno === '5025' || loginStatus.errno === '5024' ) {
				var vdun = document.getElementById('vsn_content'),
					username = document.getElementById('username'),
					password = document.getElementById('password'),
					vsncode = document.getElementById('vsncode');
					
				if( vdun.style.display === 'none' ) {
					vdun.style.display = '';
					username.setAttribute('readonly', 'true');
					password.setAttribute('readonly', 'true');                                                                                 
					//vsncode.focus();
				}
				
				vsncode.disabled = false;
				hideTip();
				custom_alert("vsncode", loginStatus.reason);
				return false;
			}
			
			changePincode();
			custom_alert("username", loginStatus.reason);
		} else {
			if(document.getElementById("save_btn").checked) {
				setCookie("cREMloginname",encodeURIComponent(document.getElementById("username").value),30*24*3600);
			}
			else {
				deleteCookie("cREMloginname");
			}
			
			if (this.crossDomain) {
				window.location.replace('/' + window.location.search);
				return true;
			}
			window.location.replace("http://login.sina.com.cn/crossdomain2.php?action=login&r=/"/* + window.location.search*/);
			return true;
		}
	};
	//cookie  函数
	var setCookie = function (name, value, time) { 
		var expdate = new Date(); 
		expdate.setTime(expdate.getTime() + time); 
		document.cookie = name + "=" + value + "; expires=" + expdate.toGMTString() + ';path=/'; 
	};
	var deleteCookie = function(name) { 
		var expdate = new Date(); 
		expdate.setTime(expdate.getTime() - (86400 * 2000 * 1)); 
		document.cookie = name + "=; expires=" +expdate.toGMTString() + ';path=/'; 
	}; 
        var getCookie = function( name ) {
                var Res = eval('/'+ name +'=([^;]+)/').exec(document.cookie);
                return Res == null ? null : Res[1];
        };
	var init = function() {
		var username = getCookie("cREMloginname");
		if (username) {
			document.getElementById("username").value = decodeURIComponent(username);
			document.getElementById('save_btn').checked = "checked";
		}
	};
	var changePincode = function() {
		if( pined ) { 
			var random = Math.floor( Math.random()*100000000 ) ;
			var pin = document.getElementById("check_img");
			pin.src = "http://login.sina.com.cn/cgi/pin.php?r=" + random + "&s=0";
		}
	}
	var hideTip = function() {
		var username = document.getElementById('username'),
			usernameTip = document.getElementById('username_tip');
		if( usernameTip.style.display != 'none' ) {
			usernameTip.style.display = 'none';
			username.className = 'ipt-t';
		}
	}
	init();
};
