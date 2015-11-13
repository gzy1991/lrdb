define(["jquery","PDUtilDir/util"],function($,Util){
	var $noticeContainer,$parent= null;
	var initNotice=function(){
		if($parent!=null){
			$parent.children().hide();
			require(["text!PDMsgCenterDir/views/notice.html"],function(noticeHtml){
				$parent.append(noticeHtml);
				/* 渲染dom */
//				$("#sys_mc_notice_opera ul li").find("span")
				$noticeContainer=$("#sys_mc_main_notice");
				reloadData();
	        });
		}else{
			Util.alert("传入参数错误，父容器无法初始化！");
		}
	};
	//  判断是否需要初始化加载模板
	var loadNoticePanel=function(placeAt){
		if(!$noticeContainer){
			if(typeof(placeAt) === "string" && placeAt.length>1){
				// 确保string长度大于1，即避免只传入“#”或“”字符串。
				$parent=$(placeAt);
			}else if(typeof(placeAt)==="object" && placeAt instanceof jQuery){
				// 确保是jquery对象
				$parent=placeAt;
			}
			initNotice();
		}else{
			$parent.children().hide();
			$noticeContainer.toggle();
			reloadData();
		}
	};
	//  加载数据
	var reloadData=function(){
		
	};
	return {
		loadNotice:loadNoticePanel
	};
});