define(["PDDictDir/dict"],function(Dict){
	var dict;
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
//	            	LocalZTree.refreshScroll($("#dictMgrTree"),$(event.target).parent().parent());
	            	dict.loadDictItems(treeNode); 
//	            	LocalZTree.refreshScroll($("#dictMgrTree"));
	            }
	        },
	        extraSets:{
	            scroll:true
	        }
	    };
	var initSimpleDict=function(){
		dict=new Dict({
    		dictType:"simple",
			treeSetting:treeSetting
    	});
    };
    return {
    	initDictManager:initSimpleDict
    };
});