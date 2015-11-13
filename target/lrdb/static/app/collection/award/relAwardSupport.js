/**
 * 
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid','PDUtilDir/util','LrdbAwardDir/awardSessionSupport'],function($,Dialog,Grid,Util,Session){
	
	var result = {};
	
	var relAwardGrid = {};
	
	var relSessionGrid = {};
	
	result.getRelAward = function($compile,$scope){
		var dialog = Dialog({
			id : 'getRelAward',
			cache : false,
			title : '添加关联奖节',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getRelAward,
            buttons:[{name:'确定',callback:function(){
            			var selected = relAwardGrid.getSelectedRow();
            			getRelAwardData($scope,selected);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	result.initRelAwardGrid($scope);
            }
        });
        dialog.show();
	};
	
	var getRelAwardData = function($scope,selected){
		for(var i =0;i<selected.length;i++){
			$scope.session.relAwards.push({awardName:'awardName'});
		}
		for(var j=0;j<$scope.session.relAwards.length;j++){
			$scope.session.relAwards[j].order = j;
		}
		$scope.$digest();
	};
	
	result.delRelAward = function($scope,index){
		$scope.session.relAwards.splice(index,1);
		for(var i=0;i<$scope.session.relAwards.length;i++){
			$scope.session.relAwards[i].order = i;
		}
	};
	
	result.initRelAwardGrid = function($scope){
		var config = {
				id : 'relAwardGrid',
				placeAt : 'relAwardGrid',
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
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.relAwardSearch();}},
					        {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.relAward={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		relAwardGrid = Grid.init(config);
	};
	
	result.getRelSession = function($compile,$scope){
		var dialog = Dialog({
			id : 'getRelSession',
			cache : false,
			title : '添加关联届次',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getRelSession,
            buttons:[{name:'确定',callback:function(){
            			var selected = relSessionGrid.getSelectedRow();
            			getRelSessionData($scope,selected);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	result.initRelSessionGrid($scope);
            }
        });
        dialog.show();
	};
	
	var getRelSessionData = function($scope,selected){
		for(var i =0;i<selected.length;i++){
			$scope.session.relSessions.push({sessionTitle:'sessionTitle',sessionName:'sessionName',sessionYear:'sessionYear'});
		}
		for(var j=0;j<$scope.session.relSessions.length;j++){
			$scope.session.relSessions[j].order = j;
		}
		$scope.$digest();
	};
	
	result.delRelSession = function($scope,index){
		$scope.session.relSessions.splice(index,1);
		for(var i=0;i<$scope.session.relSessions.length;i++){
			$scope.session.relSessions[i].order = i;
		}
	};
	
	result.initRelSessionGrid = function($scope){
		var config = {
				id : 'relSessionGrid',
				placeAt : 'relSessionGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : true,
				layout : [{
					name : '标题' , field : 'sessionName' , click : function(e){
						showSlidebar($scope);
					}
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
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.relSessionSearch();}},
					        {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.relSession={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		relSessionGrid = Grid.init(config);
	};
	
	
	return result;
	
});