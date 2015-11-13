/**
 * 
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid','PDUtilDir/util','LrdbAwardDir/awardSessionSupport'],function($,Dialog,Grid,Util,Session){
	
	var result = {};
	
	var newsGrid = {};
	
	result.getNews = function($compile,$scope){
		var dialog = Dialog({
			id : 'getNews',
			cache : false,
			title : '添加新闻',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getNews,
            buttons:[{name:'确定',callback:function(){
            			var selected = newsGrid.getSelectedRow();
            			getNewsData($scope,selected);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	result.initNewsGrid($scope);
            }
        });
        dialog.show();
	};
	
	result.delNews = function($scope,index){
		$scope.session.newsArr.splice(index,1);
		for(var i=0;i<$scope.session.newsArr.length;i++){
			$scope.session.newsArr[i].order = i;
		}
	};
	
	result.initNewsGrid = function($scope){
		var config = {
				id : 'newsGrid',
				placeAt : 'newsGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : true,
				layout : [{
					name : '标题' , field : 'sessionName'
				},{
					name : '艺术类别' , field : 'sessionArttypeName'
				},{
					name : '开始时间' , field : 'sessionStartDate'
				},{
					name : '结束时间' , field : 'sessionEndDate'
				},{
					name : '地点' ,field : 'sessionAddr'
				},{
					name : '奖节届次' , field : 'sessionPeriod'
				},{
					name : '采集人' , field : 'creatorName'
				},{
					name : '操作人' , field : 'operatorName'
				},{
					name : '操作时间' , field : 'operateTime'
				}],
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.newsSearch();}},
					        {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.news={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		newsGrid = Grid.init(config);
	};
	
	var getNewsData = function($scope,selected){
		for(var i=0;i<selected.length;i++){
			$scope.session.newsArr.push({newsTitle:'newsTitle',newsAuthor:'newsAuthor',newsSource:'newsSource',newsTypeName:'newsTypeName'});
		}
		for(var j=0;j<$scope.session.newsArr.length;j++){
			$scope.session.newsArr[j].order = j;
		}
		$scope.$digest();
	};
	
	return result;
	
});