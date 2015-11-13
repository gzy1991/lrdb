define(["jquery"],function($){
	function resetMainHeight(){
		const DefaultMainHeight=400;
		var finalHeight;
		if(window.screen.height<=DefaultMainHeight){
			finalHeight=DefaultMainHeight;
		}else{
			finalHeight=window.screen.height*1.5;
		}
		$("#sys_mc_main").css("height",finalHeight+"px");
	}
	
	function loadNotice(){
		require(["PDMsgCenterDir/noticeSupport"],function(Notice){
			Notice.loadNotice("#sys_mc_main");
        });
	}
	
	function loadLetter(){
		require(["PDMsgCenterDir/letterSupport"],function(Letter){
			Letter.loadLetter("#sys_mc_main");
        });
	}
	
    return function($compile,$scope){
    	resetMainHeight();
    	$("#sys_mc_nav li").each(function(idx,item){
			$(item).find("a").bind("click",function(){
				$("#sys_mc_nav li").removeClass("active");
				$(item).addClass("active");
				if(this.id=="sys_mc_nav_notice"){
					// 通知
					loadNotice();
				}else if(this.id=="sys_mc_nav_letter"){
					// 私信
					loadLetter();
				}
			});
		});
    	loadNotice();
    };
});