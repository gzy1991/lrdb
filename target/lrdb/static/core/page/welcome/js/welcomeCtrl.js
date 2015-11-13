
/**
 * Created by weijy on 2015/6/23.
 */
define(["PDUtilDir/util",
        "PDModuleDir/jquery/plugins/animate/jquery.easing.min",
        "jquery",
        "css!PDWelcomeDir/css/welcome"],function(Util){
    return function($compile,$scope){
    	//加载资源
    	function load() {
    		var deferred = $.Deferred();
    		//计数
    		var success = 0;
    		//定义随机数
    		var r = Math.random() * 1000; 
    		//加载图片资源
    		var img1 = new Image();
    		img1.src = getServer() + "/static/core/page/welcome/image/bg.png?t=" + r;
    		img1.onload = function() {
    			success++;
    			$(".round-main-bg").append(img1);
    			if (success == 3) {
    				deferred.resolve();
    			}
    			//计算垂直居中，目前只能是大概，做不能精确
    			function center() {
    				//整体布局垂直居中显示
    				//window高度
    				var window_height = $(window).height();
    				//.round_wrap的父元素的top值
    				var top_height = $(".round_wrap").parent().offset().top;
    				//.round_wrap可以拥有的高度值（不出滚动条时）
    				var content_height = window_height - top_height;
    				//.round_wrap目前的高度
    				var height = $(".round_wrap").height();
    				//不出滚动条时计算居中
    				if (content_height > height) {
    					var padding_top = (content_height - height) / 2 - 10;
    					$(".round_wrap").css("padding-top", padding_top + "px");
    				} else $(".round_wrap").css("padding-top", 0);
    			}
    			center();
    			//$(window).on("resize", center);
    		};
    		img1.onerror = function() {
    			deferred.reject();
    		};
    		
    		var img2 = new Image();
    		img2.src = getServer() + "/static/core/page/welcome/image/ball-center.png?t=" + r;
    		img2.onload = function() {
    			success++;
    			$(".round-list-main").prepend(img2);
    			if (success == 3) {
    				deferred.resolve();
    			}
    		}
    		img2.onerror = function() {
    			deferred.reject();
    		}
    		
    		var img3 = new Image();
    		img3.src = getServer() + "/static/core/page/welcome/image/ball.png?t=" + r;
    		img3.onload = function() {
    			success++;
    			$(".item-image").prepend(img3);
    			if (success == 3) {
    				deferred.resolve();
    			}
    		}
    		img3.onerror = function() {
    			deferred.reject();
    		}
    		return deferred.promise();
    	}
    	//监听加载资源
    	load().fail(fail).done(done);
    	
    	//资源加载失败执行
    	function fail() {
    		Util.alert("加载资源失败");
    		$(".round_loading").hide();
    	}
    	
    	//资源加载完成执行
    	function done() {
    		//显示主页
    		$(".round_loading").hide();
    		$(".round_wrap").fadeIn("slow");
    		
    		//菜单项
    		var $arrMenuItem = $(".round-menu-item");
    		//菜单项对应的集合项
    		var $arrRoundList = $(".round-list");
    		//当前显示的菜单项索引
    		var current = 0;
    		//上一次显示的菜单项索引
    		var last;
    		//动画是否正在执行
    		var animate = false;
    		//监听menu的点击事件
    		$arrMenuItem.on("click", function(){
    			//如果正在运动
    			if (!animate) {
    				current = $(this).index();
    				if (current != last)
    					play(current);
    			}
    		})
    		
    		//round-item的缓存对象
    		var roundItemMap = {};
    		//获取round-item集合
    		function getRoundItem(index) {
    			var $item = roundItemMap[index];
    			if (!$item) {
    				$item = $arrRoundList.eq(index).find(".round-list-item");
    				roundItemMap[index] = $item;
    				$item.each(function(i,n){
    					//记录当前状态
    					$(this).data("status", {top:$(this).css("top"), left:$(this).css("left"), width:$(this).width()});
    				})
    			}
    			return $item;
    		}
    		
    		//动画执行方法
    		function play() {
    			//设置动画正在执行
    			animate = true;
    			//更新菜单选择项
    			$arrMenuItem.each(function(i, n){
    				$(this).removeClass("active");
    			})
    			$arrMenuItem.eq(current).addClass("active");
    			//设置round-list
    			//移走之前的
    			function removeLast() {
    				var $arrRoundItem = getRoundItem(last);
    				$arrRoundItem.each(function(i, n){
    					var index = $(this).index();
    					$(this).delay(30+80*index).animate({
    						top : 0,
    						left : 0,
    						width : 0,
    						opacity: 0
    					}, 500, function() {
    						if (index == $arrRoundItem.length -1) {
    							$arrRoundList.eq(last).hide();
    							addCurrent();
    						}
    					});
    				})
    			}
    			//移入当前的
    			function addCurrent() {
    				var $arrRoundItem = getRoundItem(current);
    				//先隐藏所有的item
    				$arrRoundItem.each(function(i,n){
    					//记录当前自己的位置
    					var index = $(this).index();
    					//先隐藏起来
    					$(this).css("left", "0").css("top", "0").css("opacity", "0").css("width", "0").css("top", "0");
    					$(this).delay(30+80*index).animate({
    						top : $(this).data("status").top,
    						left : $(this).data("status").left,
    						width : $(this).data("status").width,
    						opacity: 1
    					}, 500, function(){
    						if (index == $arrRoundItem.length - 1) {
    							//记录上一次=当前
    							last = current;
    							animate = false;
    						}
    					});
    				})
    				$arrRoundList.eq(current).show();
    			}
    			
    			if (typeof last != "undefined") {
    				removeLast();
    			} else addCurrent();
    		}
    		
    		//默认执行
    		play();
    	}
    }
});
