/**
 * @author gaodsh@css.com.cn
 */
define(['jquery','LrdbDemoDir/dialog/dialogSupport'],
	function($,Support){
		return function($compile,$scope){
			$scope.demo={
					entity:{
						resourceType:'',
						keyword:'2222222'
					},
					template:{
						dialog :getServer() +'/static/app/demo/dialog/views/dialogEdit.html'
					},
					resourceTypes:[],
					keywords:[],
					show:function(){
						Support.showDialog($compile,$scope);
					}
			};
		};
	}
);