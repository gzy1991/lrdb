/*
 * base.js
 * 基本设置
 */
define(["PDUtilDir/util", 'jquery', "JQuery.validate", "JQuery.validate.message", "JQuery.validate.extra", "Bootstrap"],function(Util){
    /**
     * 对jquery.ajax进行包装（不改变使用方式）
     * 目的是统一处理公共需求
     */
	(function(){
		//session超时标志、授权验证标志
		var SessionOutFlag = false,
			AuthFlag = false;
		
		//ajax方法clone
		var _ajax = $.ajax;
		
		//ajax方法重新定义
		$.ajax = function(param) {
			//ajax deferred promise 保持原有promise操作
			var promise;
			
			var _param = $.extend({}, {autoWrap : true}, param);
			
			//如果不需要默认的封装:autoWrap = false;
			if (!_param.autoWrap) {
				promise = _ajax(_param);
				//直接返回
				return promise;
			}
			
			//默认ajax options
			var defaultOpts = {
				type: "POST",
				dataType: "json",
				cache: false,
				headers: {
					"CSRFToken" : getCSRFToken()
				}
			};
			//deep extend
			_param = $.extend(true, defaultOpts, _param);
			
			//add t
			if (!_param.cache) {
				var _url = _param.url || ""; 
				var date = new Date();
				var PD_T = "PD_T=" + date.getFullYear() + date.getMonth() + date.getDate() + date.getHours() + date.getMinutes() + date.getSeconds() + date.getMilliseconds();
				if (_url.indexOf("?") != -1) {
					_url += "&" + PD_T;
				} else {
					_url += "?" + PD_T;
				}
				_param.url = _url;
			}
			
			if (_param.success) {
				_param.callback = _param.success;
				delete _param.success;
			}
			
			promise = _ajax($.extend({
				success:function(response){
					var code = response.status || response.code || "200";
					//状态码控制
					switch(code){
						case "200":
							if (_param.callback) {
								response.hasOwnProperty("model") ? _param.callback(response.model) : _param.callback(response);
							}
							break;
						case "401":
							//需要认证：登录超时或未登录
							if (!SessionOutFlag) {
								Util.alert("登录过期，请重新登录<a href='" + getServer() + "/sword/login'>点此登录</a>")
								SessionOutFlag = true;
								//过一段时间再设置成false
								setTimeout(function(){
									SessionOutFlag = false;
								}, 2000);
							}
							break;
						case "400":
							//客户端错误：受到攻击或者请求异常
							Util.alert("请求异常！");
							break;
						case "403":
							//未授权
							if (!AuthFlag) {
								Util.alert("请求的资源未授权！");
								AuthFlag = true;
								//过一段时间再设置成false
								setTimeout(function(){
									AuthFlag = false;
								}, 2000);
							}
							break;
						case "500":
							Util.alert("<code>500:</code>服务器端异常,请联系管理员.<br/>"+(response.msg || response.message));
							break;
						default :
							Util.alert("<code>"+code+":</code>服务器端异常,请联系管理员.<br/>"+(response.msg || response.message));
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					console.log("ajax error:" + textStatus);
				}
			}, _param));
			
			return promise;
		};
	})();
	
    /*
     * 全局ajax监听
     */
	(function(){
		var startTimer = null;
		var endTimer = null;
		$(document).ajaxStart(function(){
			/*
			clearTimeout(startTimer);
			//延迟出现，如果时间比较短就不出现了
			startTimer = setTimeout(function(){
				Util.loading.show();
				endTimer = setTimeout(function(){
					Util.loading.hide();
					console.log("ajax请求超时，请检查……");
				}, 200);
			}, 100);
			*/
		}).ajaxSend(function(evt, request, settings){
			//console.log("ajax send");
		}).ajaxSuccess(function(evt, request, settings){
			//console.log("ajax success");
		}).ajaxComplete(function(evt, request, settings){
			//console.log("ajax complete");
		}).ajaxError(function(evt, request, settings){
			//请求出错时关闭等待信息
			//console.log("ajax error");
		}).ajaxStop(function(){
			//请求结束时关闭等待信息
			/*
			clearTimeout(startTimer);
			clearTimeout(endTimer);
			Util.loading.hide();
			*/
		});
	})();
    
    /*
     * 全局表单验证
     */
    $.validator.setDefaults({
        errorElement : 'span',
        errorClass : 'cs-help-block',
        highlight : function(target) {
            var fg =  $(target).closest('.form-group');
            //直接是输入框时，修改输入框的边框样式，比如table中的输入框验证
            fg.length ? fg.addClass('has-error') : $(target).addClass('cs-error-border');
        },
        success : function(message) {
            var fg =  message.closest('.form-group');
            fg.length ? fg.removeClass('has-error') : message.prev().removeClass('cs-error-border');
            message.remove();
        }
    });
    
    return {}
});