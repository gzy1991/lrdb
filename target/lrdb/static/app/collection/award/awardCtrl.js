/**
 * 
 */

define(['jquery','LrdbAwardDir/awardSupport'],function($,support){
	
	return function($compile,$scope){
		$scope.$apply(function(){
			$scope.award = {
					template : {
						awardEdit : getStaticPath() + '/app/collection/award/views/awardEdit.html',
						editHistory : getStaticPath() + '/app/collection/award/views/editHistory.html'
					},
					entity : {},
					query : {
						cons : {}
					},
					//存放字典数据的数组
					arttypes : [],
					levels : [],
					natures : [],
					awards : [],
					months : [],
					//发展历程
					historys : [],
					history : {},
					addHistory : function(index){
						support.addHistory($compile,$scope,index);
					},
					delHistory : function(index){
						$scope.award.historys.splice(index,1);
					},
					//保存方法
					save : function(){
						support.save($compile,$scope);
					}
			}
		});
		
		support.init($compile,$scope);
		support.initDictData($scope);
		
	};
	
	
	
});