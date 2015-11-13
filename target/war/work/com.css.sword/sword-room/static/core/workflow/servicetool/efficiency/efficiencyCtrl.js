define(["jquery"],function($){

    return function($compile,$scope){
        require(["static/core/workflow/servicetool/efficiency/efficiencySupport"],function(etlSupport){
        	etlSupport.initAll();
        });
    };
});