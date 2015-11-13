/**
 * 
 */

define(['jquery','LrdbTestDir/testSupport'],function($,support){
	
	return function($compile,$scope){
		$scope.test = {
				template : {
					testEdit : getStaticPath() + '/app/collection/test/views/testEdit.html'
				},
				entity : {},
				query : {
					cons : {}
				},
				types : [],
				save : function(){
					support.save($scope);
				}
				
				
		};
		
		support.init($compile,$scope);
	};
	
});