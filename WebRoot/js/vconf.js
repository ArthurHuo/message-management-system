/**
 * @fileoverview 表单验证类 验证规则配置对象，与validator.js配合实现表单验证
 * @author xs | zhenhau1@staff.sina.com.cn
**/
(function(){

	// 判断年月日部分
	//写在onReady事件里是因为判断和年月日下拉部分代码所用框架与当前所用框架不是一套，逻辑执行顺序有变化，
	//考过来用这种方法保证$('year')不为null
	
	/**
	 *  计算密码强度方法1
	 */
	function CharMode(iN) {
		if (iN >= 65 && iN <= 90) return 2;
		if (iN >= 97 && iN <= 122) return 4;
		else return 1;
	}
	
	/**
	 *  计算密码强度方法2
	 */
	function bitTotal(num) {
		var modes = 0;
		for (var i=0;i<3;i++) {
			if (num & 1) modes++;
			num >>>= 1;
		}
		return modes;
	}
	

	
	
	/**
	 * 表单验证类 验证规则配置对象
	 */
	var conf = {
		/**
		 *  当表单提交时执行的函数
		 */
		//'submitFn': function(el){
			
		//},
		/**
		 *  获取焦点时执行的函数
		 *  其中判断强度需要有相应HTML结构支持
		 */
		'focusFn': function(el, v){
			var alt = el.alt;
			var arg = /focusFn{([^}].+?)}/.exec(alt);
			arg = (arg == null) ? false : arg[1];
			$removeClassName($(arg), 'hide');
		},
		'长度': {						
			msg: '{name}长度应为{range}位'
		},
		'相同': {						
			msg: '{name}不一致'
		},
		'支付密码不同于密码': {						
			msg: '为保护您的资金安全，支付密码和登录密码不能相同',
	        fn : function(e, v){
				var val = e.value;
				if(!val) return '';
				return ($('password').value == $('paypassword').value)?this.msg:'';
	        }
		},
		"无内容": {
			msg: '请输入{name}',
			fn:  function(e, v){
				var val = e.value;
				if(e.id == "checkName" || e.id == "changeName"){
					val = document.getElementById("emailname").value;
				}
				return (val!="点此显示验证码" && /./.test(val)) ? 'clear' : this.msg;
			}
		},
		"无内容sel": {
			msg: '请选择{name}',
			reg: /./
		},
		"全数字": {
			msg: '{name}不能为全数字',
			reg: /[^\d]+/
		},
		"有数字": {
			msg: '{name}不能有数字',
			reg: /^[^\d]+$/
		},
		"有空格": {
			msg: '{name}不能包含空格符',
			reg: /^[^ 　]+$/
		},
		"邮箱地址": {
			msg: '邮箱地址格式不正确',
			reg: /^[0-9a-z][_.0-9a-z-]{0,31}@([0-9a-z][0-9a-z-]{0,30}\.){1,4}[a-z]{2,4}$/
		},
		"手机号码": {
			msg: '{name}不正确',
			reg: /^1(3\d{1}|5[389])\d{8}$/
		},
		"证件号码": {
			msg: '{name}不正确',
			reg: /^(d){5,18}$/
		},
		"有大写": {
			msg: '{name}不能有大写字母',
			reg: /[A-Z]/,
			regFlag: true
		},
		"有全角": {
			msg: '{name}不能包含全角字符',
			reg: /[\uFF00-\uFFFF]/,
			regFlag: true
		},
		"首尾不能是空格": {
			msg: '首尾不能是空格',
			reg: /(^\s+)|(\s+$)/,
			regFlag: true
		},
		"怪字符": {
			msg: '{name}不能包含特殊字符',
			reg: />|<|,|\[|\]|\{|\}|\?|\/|\+|=|\||\'|\\|\"|:|;|\~|\!|\@|\#|\*|\$|\%|\^|\&|\(|\)|`/i ,
			regFlag : true
		},
		"怪字符pwd": {
			msg: '密码请勿使用特殊字符',
			reg:/[\w\~\!\@\#\$\%\^\&\*\(\)\+\`\-\=\[\]\\\{\}\|\;\'\:\"\,\.\/\<\>\?]/i,
			regFlag : false
		},
		"全部怪字符": {
			msg: '{name}不能包含特殊字符',
			reg: />|<|,|\[|\]|\{|\}|\?|\/|\+|=|\||\'|\\|\"|:|;|\~|\!|\@|\#|\*|\$|\%|\^|\&|\(|\)|\-|\—|\.|`/i ,
			regFlag : true
		},
		"有中文": {
			msg: '{name}不支持中文',
			reg: /[\u4E00-\u9FA5]/i,
			regFlag : true
		},
		"特殊字符": {
			msg: '{name}不支持特殊字符',
			reg: /[^a-zA-Z\.·\u4E00-\u9FA5\uFE30-\uFFA0]/i,
			regFlag : true
		},
		"下划线": {
			msg: '下划线不能在最后',
			fn:  function(e, v){
				var val = e.value;
				return (val.slice(val.length-1)=="_") ? this.msg : '';
			}
		},
		"首尾不能是下划线": {
			msg: '首尾不能是下划线',
			reg: /(^_+)|(_+$)/,
			regFlag: true
		},
		"有下划线": {
			msg: '不能包含下划线',
			fn:  function(e, v){
				var val = e.value;
				return (val.search("_") >= 0) ? this.msg : '';
			}
		},
		"可为空": {
			fn:  function(e, v){
				if(!e.value){
					e.style.background = '';
					return 'custom';
				}else { 
					return ''; 
				}
			}
		},
		"数字字母": {
			msg: '不能包含数字和英文字母以外的字符',
			reg: /[^0-9a-zA-Z]/i,
			regFlag : true
		},
		"数字字母中文": {
			msg: '不能包含数字、英文字母和汉字以外的字符',
			reg: /[^0-9a-zA-Z\u4E00-\u9FA5]/,
			regFlag : true
		},
		"数字字母中文空格下划线": {
			msg: '不能包含全角字符',
			reg: /[^0-9a-zA-Z\u4E00-\u9FA5\_\ ]/,
			regFlag : true
		},

		"无选中": {
			msg: '请选择{name}',
			fn: function(e,v) {
				switch (e.type.toLowerCase()) {
					case 'checkbox':
						return e.checked ? 'clear' : this.msg;
					case 'radio':
						var radioes = document.getElementsByName(e.name);
						for(var i=0; i<radioes.length; i++) {
							if(radioes[i].checked) return 'clear';
						}
						return this.msg;
					default:
						return 'clear';
				}
			}
		},
			"无选择": {
			msg: '请选择{name}',
			fn: function(e,v) {
				switch (e.type.toLowerCase()) {
					case 'select-one':
							return e.value ? 'clear': this.msg;
					default:
						return 'clear';
				}
			}
		},
		"条款": {
			msg: '{name}',
			fn: function(e,v) {
				switch (e.type.toLowerCase()) {
					case 'checkbox':
						return e.checked ? 'clear' : this.msg;
					case 'radio':
						var radioes = document.getElementsByName(e.name);
						for(var i=0; i<radioes.length; i++) {
							if(radioes[i].checked) return 'clear';
						}
						return this.msg;
					default:
						return 'clear';
				}
			}
		},
		"判断强度": {
			fn: function(e,v) {
				for (var i=1;i<=3;i++) {
					try {
						$removeClassName($("passW" + i), "passWcurr");
					}catch (e) {}
				}
				var password = e.value;
				var Modes = 0;
				var n = password.length;
				for (var i=0;i<n;i++) {
					Modes |= CharMode(password.charCodeAt(i));
				}
				var btotal = bitTotal(Modes);
				if (n >= 10) btotal++;
				switch(btotal) {
					case 1:
						try {
							$addClassName($("passW1"), "passWcurr");
						}catch (e) {}
						return;
					case 2:
						try {
							$addClassName($("passW2"), "passWcurr");
						}catch (e) {}
						return;
					case 3:
						try {
							$addClassName($("passW3"), "passWcurr");
						}catch (e) {}
						return;
					case 4:
						try {
							$addClassName($("passW3"), "passWcurr");
						}catch (e) {}
						return;
					default:
						return;
				}
			}
		},
		"判断强度2": {
			fn: function(e,v) {
				for (var i=4;i<=6;i++) {
					try {
						$removeClassName($("passW" + i), "passWcurr");
					}catch (e) {}
				}
				var password = e.value;
				var Modes = 0;
				var n = password.length;
				for (var i=0;i<n;i++) {
					Modes |= CharMode(password.charCodeAt(i));
				}
				var btotal = bitTotal(Modes);
				if (n >= 10) btotal++;
				switch(btotal) {
					case 1:
						try {
							$addClassName($("passW4"), "passWcurr");
						}catch (e) {}
						return;
					case 2:
						try {
							$addClassName($("passW5"), "passWcurr");
						}catch (e) {}
						return;
					case 3:
						try {
							$addClassName($("passW6"), "passWcurr");
						}catch (e) {}
						return;
					case 4:
						try {
							$addClassName($("passW6"), "passWcurr");
						}catch (e) {}
						return;
					default:
						return;
				}
			}
		},

		"排重": { fn: checkUsername },
		"邮箱注册排重": { fn: checkFreemail },
		"查域名": { fn: checkDomain },
		"验证生日": { fn: checkDate },
		"连续字符" : {
			msg : '密码不能为连续字符',
			fn : function(e,v) {
				var n = '012345678909876543210';
				var c = 'abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba';
				var el = e;
				c += c.toUpperCase();
				if(n.indexOf(el.value) != -1 || c.indexOf(el.value) != -1){
					return '密码不能为连续字符';
				}else if(el.value.match(/^(\d+)([a-zA-Z]+)$/)){
					var arrStr = el.value.match(/^(\d+)([a-zA-Z]+)$/);
					if(n.indexOf(arrStr[1]) != -1 && c.indexOf(arrStr[2]) != -1){return '密码不能为连续字符';}else{return false;}
				}else if(el.value.match(/^([a-zA-Z]+)(\d+)$/)){
					var arrStr = el.value.match(/^([a-zA-Z]+)(\d+)$/);
					if(c.indexOf(arrStr[1]) != -1 && n.indexOf(arrStr[2]) != -1){return '密码不能为连续字符';}else{return false;}
				}else{
					return false;
				}
			}
		},
		"重复字符" : {
			msg : '密码不能全为相同字符',
			fn : function(e,v) {
				var newStr = e.value.replace(/(.)\1+/,'a');
				if(newStr.length == 1){
					return '密码不能全为相同字符';
				}else{
					return false;
				}
			}
		}	
	}
	
	//注册全局conf对象
	if (window.$vconf == null) window.$vconf = conf;
})();
