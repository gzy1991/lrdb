/**
 * 
 */

define(['jquery','static/app/uploadTest/testMultiUploadSupport'],
        function($,support){
			return function($compile,$scope){
				support.init($scope);
			};
});