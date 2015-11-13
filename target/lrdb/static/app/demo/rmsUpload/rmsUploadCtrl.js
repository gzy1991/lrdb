/**
 * 
 */

define(['jquery','LrdbDemoDir/rmsUpload/rmsUploadSupport'],
        function($,support){
			return function($compile,$scope){
				support.init($scope);
			};
});