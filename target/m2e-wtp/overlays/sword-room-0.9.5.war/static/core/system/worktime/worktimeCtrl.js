define(["jquery"],function($){

    return function($compile,$scope){
        require(["PDWorktimeDir/worktimeSupport"],function(worktimeSupport){
        	worktimeSupport.init();
        });
    };
});