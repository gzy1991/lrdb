/**
 * 
 */

define(['jquery','LrdbTestDir/testSupport'],function($,testSupport){
	
	return function($compile,$scope){
		$scope.test = {
				template : {
					testEdit : getStaticPath() + '/app/collection/test/views/testEdit.html',
					addEdit : getStaticPath() + '/app/collection/test/views/addAPerson.html',
					editAPerson:getStaticPath()+'/app/collection/test/views/editAPerson.html'
				},
				entity : {},
				query : {
					cons : {}
				},
				types : [],
				save : function(){
					testSupport.save($scope);
				}
		};
		
		testSupport.init($compile,$scope);
	};
	
});