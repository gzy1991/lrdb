/**
 * @author gaodsh@css.com.cn 
 */
define(['jquery','LrdbCommonDir/dict','PDUtilDir/dialog'],
	function($,Dict,Dialog){
		var result={};
		
		//侧边栏Dialog显示
		result.showDialog = function($compile,$scope){
            var dialog = Dialog({
				id : 'resourcesDialog',
				cache : false,
				title : '弹窗示例',
				width : '800px',
				$compile : $compile,
				$scope : $scope,
				url : $scope.demo.template.dialog,
                buttons:[{name:'确定',callback:function(){
    	                    dialog.hide();
    	                }}
                ]
            });
            dialog.show();
		};
        
		return result;
	}
);