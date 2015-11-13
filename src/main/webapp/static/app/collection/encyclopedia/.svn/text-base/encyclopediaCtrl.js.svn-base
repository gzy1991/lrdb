
define(['jquery','LrdbEncyclopediaDir/encyclopediaSupport'],
	function($,Support){
	
		return function($compile,$scope,$route,$routeParams){
			$scope.$apply(function () {
				$scope.encyclopedia = {
					template : {
						//encyclopediaEdit : getStaticPath() + '/app/collection/encyclopedia/views/encyclopediaAdd.html',
						encyclopediaEdit : getStaticPath() + '/app/collection/encyclopedia/views/encyclopediaEdit.html',
						encyclopediaView : getStaticPath() + '/app/collection/encyclopedia/views/encyclopediaView.html'
						//encyclopediaTrace : getStaticPath() + '/app/collection/encyclopedia/views/encyclopediaTrace.html'
					},
					
					queryCondition : {//百科信息主页面检索条件
						conditions : {
							encyclopediaTitle : '',//百科标题
							encyclopediaSource : '',//数据来源
							artTypeDict : '',//艺术类别
							encyclopediaTypeDict : '',//百科分类
							organizer : '',//单位
							keyWord : '',//关键字
							encyclopediaContent : ''//百科内容
						},
						
						reset : function(){
	                		$scope.encyclopedia.queryCondition.conditions = {encyclopediaTitle : '',encyclopediaSource:'',artTypeDict:'',encyclopediaTypeDict:'',organizer:'',keyWord : ''};
	                	}
					},
					
					entity : {},
					
					saveEncyInfoEntity : function(){
						Support.saveEncyclopediaEntityInfo($scope);
					},
					
					updataEncyInfoEntity : function(){
						Support.updataEncyclopediaEntityInfo($scope);
					},
					
					artTypeCodes : [],	
					encyclopediaType:[],
					encyclopediaObjInfo:[]
                	
				};
			});
			
	        Support.init($scope); 	
	        Support.initQuery($scope);
	        
	        Support.queryEncyclopediaTypes($scope);
	        Support.queryArtTypes($scope);
		};
	}
);