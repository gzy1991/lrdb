define(["jquery"],function($){
	var Type_Simple="simpleDict",Type_Tree="treeDict";
	function loadResource(type){
		var ctrlJS="PDDictDir/dict";
		if(type==Type_Simple){
			// 简单字典
			ctrlJS="PDDictDir/simpleDict";
		}else if(type==Type_Tree){
			// 树状字典
			ctrlJS="PDDictDir/treeDict";
		}
		require([ctrlJS,"text!PDDictDir/views/DictManager.html"],
				function(Dict,html){
			$("#dictFrameContent").empty().append(html);
			Dict.initDictManager();
		});
	}

    return function($compile,$scope){
        $("#dictFrameNav li").each(function(idx,item){
			$(item).find("a").bind("click",function(){
				$("#dictFrameNav li").removeClass("active");
				$(item).addClass("active");
				loadResource(this.id);
			});
		});
        loadResource(Type_Simple);
    };
});