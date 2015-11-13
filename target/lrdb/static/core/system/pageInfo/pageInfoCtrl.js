/**
 * Created by weijy on 2015/6/2.
 */
define(function() {

    return function($compile,$scope){
        require(["PDPageInfoDir/pageInfoSupport"],function(pageInfoSupport){
            pageInfoSupport.init();
        });
    };
})