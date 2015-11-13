

define([ 'jquery',
         "UtilDir/grid",
         "UtilDir/dialog",
         "UtilDir/util"
        ], function($,Grid,Dialog,Util) {

	//grif_id
	var role_grid_id="grid_test";
 
	
	function initYaosiyu($compile,$scope) {
		 //菜单表格配置
	    var gridBaseConfig = {
			id : role_grid_id,
			placeAt:role_grid_id,
			index:true,
	        multi:true,
	        pagination : true,
	        cache:false,
	        
	        layout:[
	            {name:"编号",field:"testId"},
	            {name:"姓名",field:"testName"},
	         
	        ],
	        toolbar:[
	            {name:"添加",icon:"fa fa-plus-circle",callback:function(event){addGrid($compile,$scope);}},
	            {name:"删除",icon:"fa fa-trash-o",callback:function(event){delGrid(grid);}},
	            {name:"编辑",icon:"fa fa-edit",callback:function(event){editGrid(grid);}}
	        ],
	        data:[]
	    }
		
		Grid(gridBaseConfig);
		
		loadGrid(gridBaseConfig);
	}
	
	
   
	

	/* 加载表格数据 */
	function loadGrid(gridBaseConfig) {
		
		$.ajax({
			url : getServer() + "/sword/test/getTestAll",
			data : {
				
			},
			success : function(data) {
				
				
				
				Grid($.extend(gridBaseConfig, {
					data:data
				}));
			}
		})

	}
    /*显示添加dialog*/
    function addGrid($compile,$scope){
//    	var config = {
//				title : "添加",
//				template : "/sword-web-core/static/app/yaosiyu/views/addAPerson.html",
//				afterLoad : function(dialog) {
////					alert("这里是模板加载后执行的函数！");
//				}
//			};
//			Util.contentDialog(config);
    	var dialog = Dialog({
			id : 'addDialog',
			cache : false,
			title : '添加',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : '/sword-web-core/static/app/yaosiyu/views/addAPerson.html',
            /*buttons:[{name:'确定',callback:function(){
            			dialog.hide();
	                }}
            ],*/
            afterLoad:function(){
            	
            }
        });
        dialog.show();
    
       
    }
    
	  	
	return {
		init:initYaosiyu
	}
	
}
)