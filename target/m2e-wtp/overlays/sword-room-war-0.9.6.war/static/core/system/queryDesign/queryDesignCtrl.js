define([ "jquery",
         "PDUtilDir/util","PDUtilDir/grid",
         "PDUtilDir/dialog","JQuery.pubsub"], 
         function($,Util,Grid,Dialog,PubSubJS) {
	var moduleGrid;

	var initQdModuleGrid = function() {
		var moduleGrid = new Grid({
			//初始化
			id : "sys_qd_module_grid", //Grid的容器ID
			pageSize : 15, //每页数据条数
			//            index:true,
			hidden : false, //表格是否可隐藏，只显示标题
			multi : true, //单选or多选or无选择框(undefined)
			pagination : true, //默认分页,
			cache : false,
			layout : [ {
				name : "模型名称",
				field : "moduleName",
//				sort : true,
				click : function(e) {
					data = e.data;
					console.log(data);
				}
			}, {
				name : "描述",
				field : "moduleDescription"
			}, {
				name : "关系",
				field : "relationship",
				style : "width:10%"
			}, {
				name : "视图模板一览",
				click : function(e) {
					
				},
				format : function(obj) {
					console.log(obj);
					return "BJ";
				}
			} ],
			toolbar : [ {
				name : "添加",
				icon : "fa fa-plus-circle",
				callback : function(event) {
					addNewModule();
				}
			}, {
				name : "修改",
				icon : "fa fa-edit",
				callback : function(event) {
					console.log(event.data);
				}
			}, {
				name : "删除",
				icon : "fa fa-trash-o",
				callback : function(event) {
					console.log('删除');
				}
			}, {
				name : "导出",
				icon : "fa fa-download",
				callback : function(event) {
					console.log('导出');
				}
			} ],
			data : []

		});
	};
	//  创建新模型~
	function addNewModule(){
		var config = {
				id:"sys_qd_dialog_addModule",
				title : "创建新模型",
				cache:false,
				width:"520px",
				buttons:[{
						name:"重置",
						callback:function(){
							PubSubJS.publish("sys_qd_addModule_opera","reset");
						}
					},{
						name:"确定",
						callback:function(){
							PubSubJS.publish("sys_qd_addModule_opera","submit");
						}
					}]
				
			};
		require(["PDQueryDesignDir/qdAddModuleSupport",
		         "text!PDQueryDesignDir/views/qdAddModule.html"],
		         function(_,template){
			var dialog=new Dialog(config);
			dialog.setBody(template);
		});
	}
	
	//  模型构建
	function moduleBuilder(msg,data){
		var config = {
				id:"sys_qd_dialog_moduleBuilder",
				title : "模型构建",
				cache:false,
				width:"520px",
				/*buttons:[{
						name:"重置",
						callback:function(){
							PubSubJS.publish("sys_qd_addModule_opera","reset");
						}
					},{
						name:"确定",
						callback:function(){
							PubSubJS.publish("sys_qd_addModule_opera","submit");
						}
					}]*/
				
			};
		require(["PDQueryDesignDir/qdModuleBuilderSupport",
		         "text!PDQueryDesignDir/views/qdModuleBuilder.html"],
		         function(_,template){
			var dg_moduleBuild=new Dialog(config);
			dg_moduleBuild.setBody(template);
		});
	}
	
	return function($compile, $scope) {
		initQdModuleGrid();
		PubSubJS.subscribe("sys_qd_moduleBuilder_init",moduleBuilder);
	};
});