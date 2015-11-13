/**
 * 
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid','PDUtilDir/util','LrdbAwardDir/awardSessionSupport'],function($,Dialog,Grid,Util,Session){
	
	var result = {};
	
	var activityGrid = {};
	
	result.addActivity = function($compile,$scope){
		var dialog = Dialog({
			id : 'getActivity',
			cache : false,
			title : '添加活动',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getActivity,
            buttons:[{name:'确定',callback:function(){
            			var selected = activityGrid.getSelectedRow();
            			getActivityData($scope,selected);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	result.initActivityGrid($scope);
            }
        });
        dialog.show();
	};
	
	result.delActivity = function($scope,index){
		$scope.session.activityArr.splice(index,1);
		for(var i=0;i<$scope.session.activityArr.length;i++){
			$scope.session.activityArr[i].order = i;
		}
	};
	
	result.initActivityGrid = function($scope){
		var config = {
				id : 'activityGrid',
				placeAt : 'activityGrid',
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
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.activitySearch();}},
					        {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.activity={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		activityGrid = Grid.init(config);
	};
	
	var getActivityData = function($scope,selected){
		for(var i=0;i<selected.length;i++){
			$scope.session.activityArr.push({activityName:'activityName',startDate:'2015-10-01',endDate:'2015-10-10'});
		}
		for(var i=0;i<$scope.session.activityArr.length;i++){
			$scope.session.activityArr[i].order = i;
		}
		$scope.$digest();
	};
	
	return result;
	
});