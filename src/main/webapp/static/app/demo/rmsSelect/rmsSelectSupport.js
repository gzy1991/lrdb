/**
 * @author gaodsh@css.com.cn 
 */
define(['jquery','LrdbCommonDir/dict'],
	function($,Dict){
		var result={};
		
		result.queryResourceTypes = function($scope){
			Dict.queryDict(Dict.URL_BOOK_LANGUAGE).done(function(data){
				$scope.demo.resourceTypes = data.curPageData;
				$scope.$digest();
			});
		};
		
		result.queryKeywords = function($scope){
			Dict.queryDict(Dict.URL_BOOK_LANGUAGE).done(function(data){
				$scope.demo.keywords = data.curPageData;
				$scope.$digest();
			});
		};
        
		return result;
	}
);