define(["PDDictDir/dict"],function(Dict){
	var dict;
	//配置ztree的属性
    var treeSetting = {
        data: {
        	key : {
        		name:"name"
        	},
            simpleData: {
                enable: true,
                idKey:"id",
                pIdKey:"parentId",
                rootPId:"ROOT"		//  默认以ROOT作为根
            }
        },
        callback : {
            onClick : function(event, treeId, treeNode, clickFlag) {
//            	LocalZTree.refreshScroll($("#dictMgrTree"),$(event.target).parent().parent());
            	dict.loadDictItems(treeNode); 
            	dict.dictTree.expandNode(treeNode);
//            	LocalZTree.refreshScroll($("#dictMgrTree"));
            }
        },
        extraSets:{
        	toolbar:{
            	showDefault:true
            },
            scroll:true
        }
    };
    var initTreeDict=function(){
    	dict=new Dict({
    		dictType:"tree",
			treeSetting:treeSetting
    	});
    };
    return {
    	initDictManager:initTreeDict
    };
});