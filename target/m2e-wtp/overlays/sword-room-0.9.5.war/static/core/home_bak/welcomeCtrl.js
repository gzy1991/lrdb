/**
 * Created by weijy on 2015/6/23.
 */
define(["PDUtilDir/util",
        "PDModuleDir/jquery/plugins/animate/jquery.easing.min",
        "jquery",
        "css!PDHomeDir/style/welcome"],function(Util){
    return function($compile,$scope){
    	//加载中……
    	$(".round_loading").css("display", "none");
    	//显示主页
    	$(".round_wrap").css("display", "block");
    	
    	//定义图片地址目录
    	var img_url = getServer() + "/static/core/home/images/welcome/";
    	//底座left值定义
    	var l_center = "85",
    		l_left = "-40",
    		l_right = "210";
    	//中间left值定义
    	var l_base_center = "250",
    		l_base_left = "-130",
    		l_base_right = "622";
    	
    	//初始化底座和中间
    	(function(){
    		//footer
    		var oImg_c = new Image();
    		oImg_c.src = img_url + "0_center.png";
    		$("#footerHolderItem_0").append(oImg_c).css("left", l_center+"px").css("z-index",2).attr({
    			"data-pos":"center",
    			"data-index":"0"
    		});
    		
    		var oImg_l = new Image();
    		oImg_l.src = img_url + "1_left.png";
    		$("#footerHolderItem_1").append(oImg_l).css("left", l_left+"px").css("z-index",1).attr({
    			"data-pos":"left",
    			"data-index":"1"
    		});
    		
    		var oImg_r = new Image();
    		oImg_r.src = img_url + "2_right.png";
    		$("#footerHolderItem_2").append(oImg_r).css("left", l_right+"px").css("z-index",1).attr({
    			"data-pos":"right",
    			"data-index":"2"
    		});
    		
    		//base
    		var oImg_base_l = new Image();
    		oImg_base_l.src = img_url + "1_left_base.png"
    		$("#mainHolderItem_1").css("left", l_base_left+"px").attr({
    			"data-pos":"left",
    			"data-index":"1"
    		});
    		$("#mainHolderItem_1 .bg").append(oImg_base_l).appendTo($("#mainHolderItem_1")).css("display", "block");
    		
    		var oImg_base_r = new Image();
    		oImg_base_r.src = img_url + "2_right_base.png";
    		$("#mainHolderItem_2").css("left", l_base_right+"px").attr({
    			"data-pos":"right",
    			"data-index":"2"
    		});
    		$("#mainHolderItem_2 .bg").append(oImg_base_r).css("display", "block");
    		
    		var oImg_base_c = new Image();
    		oImg_base_c.src = img_url + "0_right_base.png";
    		$("#mainHolderItem_0").css("left", l_base_center + 'px').attr({
    			"data-pos":"center",
    			"data-index":"0"
    		});
    		$("#mainHolderItem_0 .bg").append(oImg_base_c).css("display", "none");
    		$("#mainHolderItem_0 .content").css("display", "block");
    		
    		/* item */
    		$(".item").each(function(){
    			var img = new Image();
    			img.src = img_url + $(this).attr("data-index") + ".png";
    			$(this).append(img);
    		})
    	})()
    	
    	$(".main_holder_item, .footer_holder_item").on("click", function() {
    		var data_pos = $(this).attr("data-pos");
    		switch(data_pos) {
    			case "center":
    				break;
    			case "left":
    				$(".main_holder_item[data-pos=left]").css("z-index", 2);
    				$(".main_holder_item[data-pos=left]").animate({left:l_base_center}, {
    					easing:'easeInOutBack', 
    					complete: function(){
    						$(this).attr("data-pos", "center");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find(".bg").css("display", "none");
    						$(this).find(".content").css("display", "block");
    					},
    					duration: 500
    				});
    				$(".main_holder_item[data-pos=center]").css("z-index", 1);
    				$(".main_holder_item[data-pos=center]").animate({left:l_base_right}, {
    					easing:'easeInOutBack', 
    					complete:function(){
    						$(this).attr("data-pos", "right");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find(".bg img").attr("src", img_url + data_index + "_" + data_pos + "_base.png");
    						$(this).find(".bg").css("display", "block");
    						$(this).find(".content").css("display", "none");
    					},
    					duration: 500
    				});
    				$(".main_holder_item[data-pos=right]").css("z-index", 1);
    				$(".main_holder_item[data-pos=right]").animate({left:l_base_left}, {
    					easing:'easeInOutBack', 
    					complete:function(){
    						$(this).attr("data-pos", "left");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find(".bg img").attr("src", img_url + data_index + "_" + data_pos + "_base.png");
    						$(this).find(".bg").css("display", "block");
    						$(this).find(".content").css("display", "none");
    					},
    					duration: 500
    				});
    				$(".footer_holder_item[data-pos=left]").css("z-index", 2);
    				$(".footer_holder_item[data-pos=left]").animate({left:l_center}, {
    					easing:'easeOutQuad', 
    					complete: function(){
    						$(this).attr("data-pos", "center");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find("img").attr("src", img_url + data_index + "_" + data_pos + ".png");
    					},
    					duration: 500
    				});
    				$(".footer_holder_item[data-pos=center]").css("z-index", 1);
    				$(".footer_holder_item[data-pos=center]").animate({left:l_right}, {
    					easing:'easeOutQuad', 
    					complete:function(){
    						$(this).attr("data-pos", "right");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find("img").attr("src", img_url + data_index + "_" + data_pos + ".png");
    					},
    					duration: 500
    				});
    				$(".footer_holder_item[data-pos=right]").css("z-index", 1);
    				$(".footer_holder_item[data-pos=right]").animate({left:l_left}, {
    					easing:'easeOutQuad', 
    					complete:function(){
    						$(this).attr("data-pos", "left");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find("img").attr("src", img_url + data_index + "_" + data_pos + ".png");
    					},
    					duration: 500
    				});
    				break;
    			case "right":
    				$(".main_holder_item[data-pos=left]").css("z-index", 1);
    				$(".main_holder_item[data-pos=left]").animate({left:l_base_right}, {
    					easing:'easeInOutBack', 
    					complete: function(){
    						$(this).attr("data-pos", "right");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find(".bg img").attr("src", img_url + data_index + "_" + data_pos + "_base.png");
    					},
    					duration: 500
    				});
    				$(".main_holder_item[data-pos=center]").css("z-index", 1);
    				$(".main_holder_item[data-pos=center]").animate({left:l_base_left}, {
    					easing:'easeInOutBack', 
    					complete: function(){
    						$(this).attr("data-pos", "left");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find(".bg img").attr("src", img_url + data_index + "_" + data_pos + "_base.png");
    						$(this).find(".bg").css("display", "block");
    						$(this).find(".content").css("display", "none");
    					},
    					duration: 500
    				});
    				$(".main_holder_item[data-pos=right]").css("z-index", 2);
    				$(".main_holder_item[data-pos=right]").animate({left:l_base_center}, {
    					easing:'easeInOutBack', 
    					complete: function(){
    						$(this).attr("data-pos", "center");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find(".bg").css("display", "none");
    						$(this).find(".content").css("display", "block");
    					},
    					duration: 500
    				});
    				$(".footer_holder_item[data-pos=left]").css("z-index", 1);
    				$(".footer_holder_item[data-pos=left]").animate({left:l_right}, {
    					easing:'easeOutQuad', 
    					complete: function(){
    						$(this).attr("data-pos", "right");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find("img").attr("src", img_url + data_index + "_" + data_pos + ".png");
    					},
    					duration: 500
    				});
    				$(".footer_holder_item[data-pos=center]").css("z-index", 1);
    				$(".footer_holder_item[data-pos=center]").animate({left:l_left}, {
    					easing:'easeOutQuad', 
    					complete: function(){
    						$(this).attr("data-pos", "left");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find("img").attr("src", img_url + data_index + "_" + data_pos + ".png");
    					},
    					duration: 500
    				});
    				$(".footer_holder_item[data-pos=right]").css("z-index", 2);
    				$(".footer_holder_item[data-pos=right]").animate({left:l_center}, {
    					easing:'easeOutQuad', 
    					complete: function(){
    						$(this).attr("data-pos", "center");
    						var data_pos = $(this).attr("data-pos");
    						var data_index = $(this).attr("data-index");
    						$(this).find("img").attr("src", img_url + data_index + "_" + data_pos + ".png");
    					},
    					duration: 500
    				});
    				break;
    		}
    	})
    	/*
    	$(".main_holder_item").hover(function(){
    		if ($(this).attr("data-pos") != "center") {
    			$(this).animate({
    				width:480,
    				marginLeft:-10,
    				margintTop:-10
    			}, 100)
    		}
    	}, function() {
    		if ($(this).attr("data-pos") != "center") {
	    		$(this).animate({
	    			width:460,
	    			marginLeft:0,
	    			margintTop:0
	    		},50)
    		}
    	})
		$(".footer_holder_item").hover(function(){
			$(this).animate({
				width:140,
				marginLeft:-5,
				marginTop:-5
			}, 100);
		}, function(){
			$(this).animate({
				width:130,
				marginLeft:0,
				marginTop:0
			}, 100);
		})
    	 */
		
		$(".footer_holder_item").on("mouseenter", function(e){
			var _this = this;
			clearTimeout(_this.delayTimer);
			_this.delayTimer = setTimeout(function(){
				//$(_this).css("width", 140);
				$(_this).animate({
					width:140,
					marginLeft:-5,
					marginTop:-5
				}, 100);
			}, 100);
		}).on("mouseleave", function(e){
			var _this = this;
			clearTimeout(_this.delayTimer);
			_this.delayTimer = setTimeout(function(){
				//$(_this).css("width", 130);
				$(_this).animate({
					width:130,
					marginLeft:0,
					marginTop:0
				}, 100);
			}, 100);
		})
		
		$(".item").on("mouseenter", function(e){
			var _this = this;
			clearTimeout(_this.delayTimer);
			_this.delayTimer = setTimeout(function(){
				var $info = $(_this).find(".info");
				var direction = hoverDirection(_this, e);
				switch(direction) {
					case 0:
						$info.css({"left":"100%", "top":"0", "display":"block"});
						break;
					case 1:
						$info.css({"left":"0", "top":"100%", "display":"block"});
						break;
					case 2:
						$info.css({"left":"-100%", "top":"0", "display":"block"});
						break;
					case 3:
						$info.css({"left":"0", "top":"-100%", "display":"block"});
						break;
				}
				$info.animate({left:0, top:0});
			}, 100)
		}).on("mouseleave", function(e) {
			var _this = this;
			clearTimeout(_this.delayTimer);
			_this.delayTimer = setTimeout(function(){
				var $info = $(_this).find(".info");
				$info.fadeOut();
				/*
				var w = $(_this).width();
				var h = $(_this).height();
				var direction = hoverDirection(_this, e);
				console.log(direction);
				switch(direction) {
					case 0:
						$info.animate({left:w, top:0});
						break;
					case 1:
						$info.animate({left:0, top:h});
						break;
					case 2:
						$info.animate({left:-w, top:0});
						break;
					case 3:
						$info.animate({left:0, top:-h});
						break;
				}
				*/
			}, 100)
		})
		
		//获取鼠标移入移出元素的方向：0-从右 1-从下 2从左 3从上
		function hoverDirection(obj, ev) {
    		var w=$(obj).width();
    		var h=$(obj).height();
    		
    		var x=$(obj).offset().left+w/2-ev.clientX;
    		var y=$(obj).offset().top+h/2-ev.clientY;
    		
    		return Math.round((Math.atan2(y,x)*180/Math.PI+180)/90)%4;	
    	}
		
    };
});
