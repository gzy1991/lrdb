/**
 * @author gaodsh@css.com.cn
 */
define(['jquery','LrdbDemoDir/rmsSelect/rmsSelectSupport'],
	function($,Support){
		return function($compile,$scope){
			$scope.demo={
					entity:{
						resourceType:'',
						keyword:''
					},
					resourceTypes:[],
					keywords:[]
			};
			
			Support.queryResourceTypes($scope);
			Support.queryKeywords($scope);
		};
	}
);