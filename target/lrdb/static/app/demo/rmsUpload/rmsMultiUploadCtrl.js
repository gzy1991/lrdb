/**
 * 
 */

define(['jquery','LrdbDemoDir/rmsUpload/rmsMultiUploadSupport'],
        function($,support){
			return function($compile,$scope){
				support.init($scope);
			};
});