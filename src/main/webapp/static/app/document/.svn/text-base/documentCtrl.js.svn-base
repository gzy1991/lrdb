/**
 * @author sarah
 */
define(['jquery','LrdbDocumentDir/documentSupport','PDUtilDir/inputSelect'],
		function($,Support,InputSelect){
	
	return function($compile,$scope){
		$scope.$apply(function(){
			$scope.document = {
					template : {
						detail : getStaticPath() + '/app/document/views/docDetail.html'
					},
					query : {
						conditions : {
							docTitle : '',
							docFormat : '',
							artType : '',
							docOrg : '',
							docSecret : '',
							docStatus : '',
							minTime : '',
							maxTime : ''
						},
						reset : function(){
							this.conditions = {};
							var format = InputSelect.getInput('docFormat');
							var artType = InputSelect.getInput('artType');
							var docOrg = InputSelect.getInput('docOrg');
							var docSecret = InputSelect.getInput('docSecret');
							var docStatus = InputSelect.getInput('docStatus');
							format.dataInit([]);
							artType.dataInit([]);
							docOrg.dataInit([]);
							docSecret.dataInit([]);
							docStatus.dataInit([]);
						}
					},
					usages : [],
					detailPanel : {}
			};
		});
		
        Support.init($scope);
        Support.initCons($scope);
	};
	
});