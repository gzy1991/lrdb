define(["jquery","PDUtilDir/util"],function($,Util,LocalZTree){
	var $letterContainer,$parent= null;
	var initLetter=function(){
		if($parent!=null){
			$parent.children().hide();
			require(["text!PDMsgCenterDir/views/letter.html"],function(letterHtml){
				$parent.append(letterHtml);
				
				$letterContainer=$("#sys_mc_main_letter");
				reloadData();
	        });
		}else{
			Util.alert("传入参数错误，父容器无法初始化！");
		}
	};
//  判断是否需要初始化加载模板
	var loadLetterPanel=function(placeAt){
		if(!$letterContainer){
			if(typeof(placeAt) === "string" && placeAt.length>1){
				// 确保string长度大于1，即避免只传入“#”或“”字符串。
				$parent=$(placeAt);
			}else if(typeof(placeAt)==="object" && placeAt instanceof jQuery){
				// 确保是jquery对象
				$parent=placeAt;
			}
			initLetter();
		}else{
			$parent.children().hide();
			$letterContainer.toggle();
			reloadData();
		}
	};
	//  加载数据
	var reloadData=function(){
		
	};
	return {
		loadLetter:loadLetterPanel
	};
});