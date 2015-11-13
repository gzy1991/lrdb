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
	//缓存对象
	var cache = {};
	
	return function(config) {
		//配置项
		var options = $.extend({
    		"id":"",            //页面模板id
            "url":"",           //远程模板url
            "width":300,		//侧边栏宽度[默认300]
            "cache":false,		//是否缓存[默认不缓存]
            "close":false,      //点击侧边栏之外的区域是否能关闭侧边栏[默认不关闭]
            "allowClick":[],	//设置某些UI元素操作时不自动关闭侧边栏[close:true时有用]
    		"afterLoad":null,	//模板加载完成回调
    		"afterOpen":null,	//侧边栏打开完成回调
    		"afterClose":null,	//侧边栏关闭完成回调
    		"onDestroy":null	//侧边栏销毁时回调
    	}, config);
		
		//侧边栏JQ对象
		var $Panel;
		//加载的dom是否来自远程url
		var fromUrl = false;
		
		//初始化方法
		var init = function() {
			//定义侧边栏JQ对象，先从缓存里取
        	$Panel = cache[options.id || options.url];
        	
        	if ($Panel) {//存在缓存
        		if ($Panel.fromUrl) {//远程加载
        			if (options.cache) {//如果设置了缓存，重新打开，并触发afterLoad事件
        				$Panel.trigger("afterLoad");
        				reOpen();
        			} else {//如果没有设置缓存，那么先销毁，再重新渲染
        				destroy();
        				render();
        			}
        		} else { //本地dom节点
        			$Panel.trigger("afterLoad");
        			reOpen();
        		}
        	} else {
        		render();
        	}
        	
        	/*
        	if ($Panel && options.cache) {//存在缓存并且设置了缓存，直接渲染
        		reOpen();
        		//open();
        	} else if ($Panel && !options.cache && $Panel.fromUrl){//存在缓存但是没有设置缓存并且是fromUrl，先销毁，再渲染	
        		destroy();
        		render();
        	} else {//没有缓存，直接渲染
        		render();
        	}
        	*/
		};
		
		//销毁方法
		var destroy = function() {
			typeof options.onDestroy == "function" && options.onDestroy();
			//卸载事件
			unbindEvt();
			//移除dom
    		$Panel && $Panel.remove();
    		//清除cache
    		delete cache[options.id || options.url];
    		$Panel = null;
		};
		
		//渲染dom方法
		var render = function() {
			//监听加载dom完成
			loadDom(function($Dom){
				//定义侧边栏template
    			var template = 	"<div class='cs-slidebar'>" +
    							"<div class='cs-slidebar-left'><i class='cs-slidebar-close glyphicon glyphicon-chevron-right'></i></div>" + 
    							"<div class='cs-slidebar-content'></div>" +
    						   	"</div>";
    			//初始化侧边栏JQ对象，并将template加载至body
    			$Panel = $(template).appendTo($(document.body));
    			//将dom添加至侧边栏template中
    			$Panel.find(".cs-slidebar-content").append($Dom);
				//双向绑定支持，必须放在侧边栏DOM已经放到实际DOM树上，而不是在内存中
				if(options.$compile && options.$scope){
					var $content = $Panel.find(".cs-slidebar-content");
					var link = options.$compile($content);
					link(options.$scope);
					options.$scope.$digest();
				}

    			//如果dom来自于页面，那么设置显示
    			$Panel.fromUrl = fromUrl;
    			!fromUrl && $Dom.show();
	    		//初始化侧边栏样式
    			$Panel.css({
            		"width" : parseInt(options.width) + "px",
            		"right" : "-" + parseInt(options.width) + "px"
            	});
    			//初始化事件
    			bindEvt();
    			//执行afterLoad事件
    			//typeof(options.afterLoad)=="function" && options.afterLoad($Panel);
    			$Panel.trigger("afterLoad");
    			//侧边栏弹出
    			open();
	    		//做缓存
	    		cache[options.id || options.url] = $Panel;
    		});
		};
		
		//加载dom，注册加载完成事件
		var loadDom = function(callback) {
    		var $Dom;
    		var getDom = function() {
        		var deferred = $.Deferred();
        		
        		//先根据id查找本页dom元素
        		$Dom = (options.id && $("#" + options.id));
        		if ($Dom && $Dom[0]) {
        			deferred.resolve();
        		} else {
        			if (options.url) {
        				require(['text!'+options.url],function(panel){
							//侧边栏数据双向绑定支持
							/*if(options.$compile && options.$scope){
								var link = options.$compile(panel);
								$Dom = $(link(options.$scope));
								options.$scope.$digest();
							}else{
								$Dom = $(panel);
							}*/
							$Dom = $(panel);
        					fromUrl = true;
        					deferred.resolve();
        				})
        			} else {
        				deferred.reject();
        			}
        		}
        		
        		return deferred.promise();
        	};
        	
        	//监听
        	$.when(getDom()).done(function(){
	    		//callback
        		typeof callback == "function" && callback($Dom);
        	}).fail(function(){
        		console.log("侧边栏加载dom失败，请确认id或url属性是否设置正确");
        	})
    	};
		
		//判断是否为可点击并自动close区域
		var isTarget = function(e) {
			var isAllow = function(e) {
				var arr = options.allowClick;
				for(var i= 0,item; item=arr[i++]; ){
					if($(item).is(e.target) || $(item).has(e.target).length){
						return true;
					}
				}
				return false;
			};
			
			var isMouseIn = function(e) {
				var offset = $Panel.offset();
				var width = $Panel.outerWidth(),
					height = $Panel.outerHeight();
				var startPoint = {
					left : offset.left,
					top : offset.top
				}
				var endPoint = {
					left : offset.left + width,
					top : offset.top + height
				}
				var x = e.clientX,
					y = e.clientY;
				
				if (x < startPoint.left
						|| x > endPoint.left
						|| y < startPoint.top
						|| y > endPoint.top) {
					return false;
				}
				return true;
			};
			
			//侧边栏子元素、侧边栏区域以外、允许元素以外的元素
			return (!$Panel.is(e.target) && $Panel.has(e.target).length === 0) && !isMouseIn(e) && !isAllow(e);
		};
		
		var bindEvt = function() {
    		//关闭按钮
    		$Panel.find(".cs-slidebar-left").on("click", close);
    		//注册afterLoad事件
    		$Panel.on("afterLoad", function(){
    			typeof(options.afterLoad)=="function" && options.afterLoad($Panel);
    		})
    		//点击侧边栏以外是否自动关闭
    		if (options.close) {
    			//定义元素范围
    			$Panel.$target = $(".body-wrap") || $(document.body);
    			//监听事件
    			$Panel.targetMouseUpEvt = function(e) {
    				//侧边栏展开&&不是目标区域且不是子元素,且不是自定义允许点击节点，就关闭
    				if ($Panel.isOpen && isTarget(e)) {
    					close();
    				}
    			}
    			$Panel.$target.on("mouseup", $Panel.targetMouseUpEvt);
    		}
		};
		
		var unbindEvt = function() {
			$Panel.find(".cs-slidebar-left").off("click", close);
			$Panel.off("afterLoad");
			$Panel.$target && $Panel.$target.off("mouseup", $Panel.targetMouseUpEvt);
		};
		
		//侧边栏弹出
		var open = function() {
			//打开标志
			$Panel.isOpen = true;
			//弹出侧边编辑栏
            $Panel && $Panel.animate({right : 0}, 350, function(){
            	typeof options.afterOpen == "function" && options.afterOpen.call(null); 
            });
		};
		
		var close = function(callback) {
			//关闭标志
			$Panel.isOpen = false;
			//如果不缓存,且侧边栏的DOM来自于远程连接，则销毁
			(!options.cache && fromUrl) && destroy();
			//关闭侧边栏
			$Panel && $Panel.css("right", "-" + parseInt(options.width) + "px");
			/*
    		$Panel && $Panel.animate({right: "-" + options.width}, 150,function(){
    			typeof(options.afterClose)=="function" && options.afterClose.call(null);
            });
            */
		};
		
		/* 重新打开侧边栏 */
		var reOpen = function() {
			if ($Panel.isOpen) {
				close();
				open();
			} else open();
		};
		
		//执行初始化
		init();
		
		//返回对象
		return {
			options : options,
			close : close
		}
	}
});