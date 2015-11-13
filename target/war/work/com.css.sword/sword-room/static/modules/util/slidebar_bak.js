/**
 * Created by weijy on 2015/6/26
 * 使用方法
 * require(["slidebar], function(slidebar){
 * 		var obj = slidebar({
 * 			"id":"",            //页面模板id
 *          "url":"",           //远程模板url
 *          "width":300,		//侧边栏宽度
 *          "cache":false,		//是否缓存[默认不缓存]
 *          "close":false,      //点击侧边栏之外的区域是否能关闭侧边栏[默认不关闭]
 *          "allowClick":[],	//设置某些UI元素操作时不自动关闭侧边栏[close:true时有用]
 *    		"afterLoad":null,	//模板加载完成回调
 *    		"afterOpen":null,	//侧边栏打开完成回调
 *    		"afterClose":null,	//侧边栏关闭完成回调
 *    		"onDestroy":null	//侧边栏销毁时回调
 * 		});
 * 		obj.close();
 * })
 */
define(["jquery", "css!PDUtilDir/css/slidebar"], function(){
	
	var cache = {}; //缓存对象
	
	function init(config) {
		config =  $.extend({
			"sid": Slidebar.getSId(),			//组件唯一id，用来缓存key和组件dom的id
			"id":"",            //页面模板id
            "body": "",			//模板内容
            "url":"",           //远程模板url
            "urlCache":true,  	//是否缓存远程模板[默认缓存,url设置时有效]
            "cache":false,		//是否缓存组件[默认不缓存]
            "width":300,		//侧边栏宽度[默认300]
    		"afterLoad":null,	//模板加载完成回调
    		"afterOpen":null,	//侧边栏打开完成回调
    		"afterClose":null,	//侧边栏关闭完成回调
    		"onDestroy":null	//侧边栏销毁时回调
		}, config);
		
		var slidebar;
		//判断缓存
		if (config.cache && cache[config.sid]) {
			slidebar = cache[config.sid];
			slidebar.open();
			return slidebar;
		}
		
		slidebar = new Slidebar(config);
		slidebar.open();
		return slidebar;
	}
	
	function Slidebar(config) {
		this.options = config;

		Slidebar.init.call(this);
	}
	
	var idCache = {}; //id缓存对象
	var jqCache = {}; //jq缓存对象
	var urlCache = {};//url缓存对象
	
	//定义侧边栏template
	var template = 	"<div class='cs-slidebar'>" +
					"<div class='cs-slidebar-left'><i class='cs-slidebar-close glyphicon glyphicon-chevron-right'></i></div>" + 
					"<div class='cs-slidebar-content'></div>" +
				   	"</div>";
	var templateMask = "<div class='cs-slidebar-mask modal-backdrop fade'></div>";
	
	Slidebar.init = function() {
		var _this = this;
		
		if (_this.options.id) {
			Slidebar.renderById.call(_this);
		} else if (_this.options.url) {
			Slidebar.renderByUrl.call(_this);
		} else if (_this.options.body) {
			Slidebar.renderByBody.call(_this);
		}
		
		/*
		if (_this.options.id || _this.options.url) {
			var sId = _this.sId =  Slidebar.getSId.call(_this);
			var sDom = document.getElementById(sId);
			if (sDom) {
				_this.$slidebar = jqCache[sId];
			}
			Slidebar.render.call(_this);
		}
		*/
	}
	
	Slidebar.getSId = function() {
		var sid = "slidebar" + date.getFullYear() + date.getMonth() + date.getDate() + date.getHours() + date.getMinutes() + date.getSeconds() + date.getMilliseconds();
		return sid;
	}
	
	Slidebar.renderById = function() {
		
	}
	
	Slidebar.renderByUrl = function() {
		Slidebar.loadHtml.call(_this, function(html){
			if (_this.$slidebar) { //已经存在
				_this.destroy();
			}
			//初始化侧边栏JQ对象，并将template加载至body
			var $slidebar = _this.$slidebar = $(template).appendTo($(document.body));
			//将dom添加至侧边栏template中
			$slidebar.find(".cs-slidebar-content").html(html);
			
			$slidebar.after($(templateMask));
			
			//设置id
			$slidebar.attr("id", _this.sId);
			
			//初始化侧边栏样式
			$slidebar.css({
				"width" : parseInt(options.width) + "px",
				"right" : "-" + parseInt(options.width) + "px"
			});
			
			//初始化事件
			Slidebar.bindEvt.call(_this);
			
			//触发afterLoad事件
			$slidebar.trigger("afterLoad");
			
			//做缓存
			jqCache[_this.sId] = $slidebar;
			
			//侧边栏弹出
			_this.open();
		})
	}
	
	Slidebar.renderByBody = function() {
		
	}
	
	Slidebar.render = function() {
		var _this = this,
			options = _this.options;
		
		if (_this.options.id) {
			var target = document.getElementById(options.id);
			if (!target) {
				console.log("侧边栏通过id加载html失败，请确认id属性是否设置正确！");
				return ;
			}
			
			if (_this.$slidebar) { //已经存在
				var $slidebar = _this.$slidebar;
				
				//注册事件
				Slidebar.bindEvt.call(_this);
				
				$slidebar.trigger("afterLoad");
				
				_this.open();
			} else {
				$(target).wrap("<div id='" + _this.sId + "'></div>");
				var $wrapper = $("#" + _this.sId);
				
				//初始化侧边栏JQ对象
				var $slidebar = _this.$slidebar = $(template);
				$slidebar.find(".cs-slidebar-content").append($(target));
				$wrapper.replaceWith($slidebar);
				
				$slidebar.after($(templateMask));
				
				//显示target
				$(target).show();
				
				//设置id
				$slidebar.attr("id", _this.sId);
				//初始化侧边栏样式
				$slidebar.css({
					"width" : parseInt(options.width) + "px",
					"right" : "-" + parseInt(options.width) + "px"
				});
				
				//初始化事件
				Slidebar.bindEvt.call(_this);
				
				//触发afterLoad事件
				$slidebar.trigger("afterLoad");
				
				//做缓存
				jqCache[_this.sId] = $slidebar;
				
				//侧边栏弹出
				_this.open();
			}
		} else if(_this.options.url){
			Slidebar.loadHtml.call(_this, function(html){
				if (_this.$slidebar) { //已经存在
					_this.destroy();
				}
				//初始化侧边栏JQ对象，并将template加载至body
				var $slidebar = _this.$slidebar = $(template).appendTo($(document.body));
				//将dom添加至侧边栏template中
				$slidebar.find(".cs-slidebar-content").html(html);
				
				$slidebar.after($(templateMask));
				
				//设置id
				$slidebar.attr("id", _this.sId);
				
				//初始化侧边栏样式
				$slidebar.css({
					"width" : parseInt(options.width) + "px",
					"right" : "-" + parseInt(options.width) + "px"
				});
				
				//初始化事件
				Slidebar.bindEvt.call(_this);
				
				//触发afterLoad事件
				$slidebar.trigger("afterLoad");
				
				//做缓存
				jqCache[_this.sId] = $slidebar;
				
				//侧边栏弹出
				_this.open();
			})
		}
	}
	
	/**
	 * 远程加载html
	 */
	Slidebar.loadHtml = function(callback) {
		var _this = this,
			options = _this.options;
		
		var html;
		var load = function() {
    		var deferred = $.Deferred();
    		
    		var url = _this.options.url;
			if (url) {
				if (options.cache) { //启用缓存
					html = urlCache[url];
					if (html) {
						deferred.resolve();
					} else {
						require(['text!' + url],function(result){
							html = urlCache[url] = result;
							deferred.resolve();
						})
					}
				} else { //未启用缓存
					require(['text!' + url],function(result){
						html = result;
						deferred.resolve();
					})
				}
			}
    		
    		return deferred.promise();
		};
		
		//监听
    	$.when(load()).done(function(){
    		typeof callback == "function" && callback(html);
    	}).fail(function(){
    		console.log("侧边栏通过url加载html失败，请确认url属性是否设置正确！");
    	});
	}
	
	Slidebar.bindEvt = function() {
		var _this = this,
			$slidebar = _this.$slidebar,
			options = _this.options;
		
		//先移除事件绑定
		Slidebar.unbindEvt.call(_this);
		
		//监听关闭按钮
		$slidebar.find(".cs-slidebar-left").on("click", function(){ _this.close(); });
		
		//监听mask点击关闭事件
		$slidebar.next(".cs-slidebar-mask").on("click", function(){ _this.close(); });
		
		//注册afterLoad事件
		$slidebar.on("afterLoad", function(){
			typeof(options.afterLoad)=="function" && options.afterLoad($slidebar);
		})
		
		//打开
		$slidebar.on("afterOpen", function() {
			typeof options.onOpen == "function" && options.onOpen.call(null); 
		})
		
		//关闭
		$slidebar.on("afterClose", function() {
			typeof options.onClose == "function" && options.onClose.call(null); 
		})
	}
	
	Slidebar.unbindEvt = function() {
		var _this = this,
			$slidebar = _this.$slidebar,
			options = _this.options;
		
		$slidebar.find(".cs-slidebar-left").off("click");
		$slidebar.next(".cs-slidebar-mask").off("click");
		$slidebar.off("afterLoad");
		$slidebar.off("afterOpen");
		$slidebar.off("afterClose");
	}
	
	Slidebar.fn = Slidebar.prototype;
	Slidebar.prototype.constructor = Slidebar;
	
	Slidebar.fn.open = function() {
		var _this = this,
			$slidebar = _this.$slidebar,
			options = _this.options;
		
		//弹出侧边编辑栏
		$slidebar.css({
			"right" : "0"
		});
		//弹出遮蔽层
		$slidebar.next(".cs-slidebar-mask").addClass("in").css("display", "block");
		//关闭body的滚动条
		$(document.body).addClass("modal-open");
		
		$slidebar.trigger("afterOpen");
	}
	
	Slidebar.fn.close = function() {
		var _this = this,
			$slidebar = _this.$slidebar,
			options = _this.options;
	
		//弹出侧边编辑栏
		$slidebar.css({
			"right" : "-" + parseInt(options.width) + "px"
		});
		//弹出遮蔽层
		$slidebar.next(".cs-slidebar-mask").removeClass("in").css("display", "none");
		//关闭body的滚动条
		$(document.body).addClass("modal-open");
		
		$slidebar.trigger("afterClose");
		
		if (!_this.options.id && _this.options.url) {
			_this.destroy();
		}
	}
	
	Slidebar.fn.destroy = function() {
		var _this = this,
			$slidebar = _this.$slidebar;
		
		//移除事件
		Slidebar.unbindEvt.call(_this);
		//移除缓存
		delete jqCache[_this.sId];
		//移除dom
		$slidebar.next(".cs-slidebar-mask").remove();
		$slidebar.remove();
	}
	
	Slidebar.fn.setBody = function() {
		
	}
	
	return init;
	
});