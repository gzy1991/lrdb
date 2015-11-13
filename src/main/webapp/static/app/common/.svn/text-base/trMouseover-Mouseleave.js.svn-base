/**
 * @author Sarah
 */

/**
 * grid行悬停事件:
 * 初始化mouseover及mouseleave事件
 * panel.initMouseover({
 * 		content : '',   //要在panel上显示的内容
 * 		timerName : '',  //定时器名称
 * 		delay : num,  //延迟时间
 * 		event : {}  //事件对象，包含鼠标位置信息
 * });
 * panel.initMouseleave({
 * 		timerName : ''  //与mouseover事件相同的定时器名称，用来取消定时事件
 * });
 */

define(['jquery'],function($){
	
	var result = {};
	
	var timer = {};
	
	result.initMouseover = function(userCon){
		var defCon = {
				content : 'This is default content',
				timerName : 'defTimer',
				delay : 1000,
				event : {}
		};
		var config = $.extend(true,defCon,userCon);
		if($('.grid-detail-panel').length){
    		$('.grid-detail-panel').remove();
    	}
    	clearTimeout(timer[config.timerName]);
    	timer[config.timerName] = setTimeout(_showIntroPanel,config.delay,config.event,config.content);
	};
	
	result.initMouseleave = function(userCon){
		
		var defaultCon = {
			timerName : 'defTimer'	
		};
		
		var con = $.extend(true,defaultCon,userCon);
		
		if($('.grid-detail-panel').length){
    		$('.grid-detail-panel').hover(function(){},function(){
    			_hideIntroPanel(con.timerName);
		    });
    	}else{
    		_hideIntroPanel(con.timerName);
    	}
	};
	
	var _showIntroPanel = function(event,content){
		var html = '<div class="grid-detail-panel form-horizontal">' + '<div class="form-group">' + 
					'<label class="col-xs-1"></label>' + '<div class="col-xs-10 file-detail-span"><span>' + 
					content + '</span>' + '</div></div></div>';
		$(html).appendTo('body');
		var winWidth = document.body.clientWidth;
		var winHeight = $(window).height();
		var length = _strLength(content);
		var width = 200;
		if(length > 200){
			width = width * Math.sqrt(1.6 * length/200);
		}
		$('.grid-detail-panel').css({'width':width});
		var height = $('.grid-detail-panel').height();
		if(winWidth - event.pageX - width > 0){
			if(winHeight - event.pageY - height > 0){
				$('.grid-detail-panel').css({'left':event.pageX,'top':event.pageY});
			}else{
				if(event.pageY < height){
					$('.grid-detail-panel').css({'left':event.pageX,'top':0});
				}else{
					$('.grid-detail-panel').css({'left':event.pageX,'top':(event.pageY - height)});
				}
			}
		}else{
			if(event.pageX < width){
				if(winHeight - event.pageY - height > 0){
					$('.grid-detail-panel').css({'left':0,'top':event.pageY});
				}else{
					if(event.pageY < height){
						$('.grid-detail-panel').css({'left':0,'top':0});
					}else{
						$('.grid-detail-panel').css({'left':0,'top':(event.pageY - height)});
					}
				}
			}else{
				if(winHeight - event.pageY - height > 0){
					$('.grid-detail-panel').css({'left':(event.pageX - width),'top':event.pageY});
				}else{
					if(event.pageY < height){
						$('.grid-detail-panel').css({'left':(event.pageX - width),'top':0});
					}else{
						$('.grid-detail-panel').css({'left':(event.pageX - width),'top':(event.pageY - height)});
					}
				}
			}
		}
	};
	
	var _hideIntroPanel = function(timerName){
		clearTimeout(timer[timerName]);
		if($('.grid-detail-panel').length){
			$('.grid-detail-panel').remove();
		}
	};
	
	var _strLength = function(content){
		var byteLen = 0;
		var length = content ? content.length : content;
		if(length){
			for(var i=0; i<length; i++){
				if(content.charCodeAt(i)>255){
					byteLen += 2;
				}
				else{
					byteLen++;
				}
			}
			return byteLen;
		}
		else{
			return 0;
		}
	};
	
	return result;
	
});