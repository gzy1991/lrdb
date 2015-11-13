define(["jquery"],function($){

    return function($compile,$scope){
        require(["app/yaosiyu/yaosiyuSupport"],function(yaosiyuSupport){
        	$scope.yaosiyu = {
    				template : {
    					testEdit : getStaticPath() + '/app/yaosiyu/views/addAPerson.html'
    				},
    				entity : {},
    				query : {
    					cons : {}
    				},
    				types : [],
    				save : function(){
    					yaosiyuSupport.save($scope);
    				}
    				
    				
    		};
    		
            yaosiyuSupport.init($compile,$scope);
        });
    };
});