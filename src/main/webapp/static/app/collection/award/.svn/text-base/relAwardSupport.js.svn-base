/**
 * 
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid','PDUtilDir/util','LrdbAwardDir/awardSessionSupport'],function($,Dialog,Grid,Util,Session){
	
	var result = {};
	
	
	var relSessionGrid = {};
	
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
            			var bool = getRelSessionData($scope,selected);
            			if(bool){
            				dialog.hide();
            			}
	                }}
            ],
            afterLoad:function(){
            	result.initRelSessionGrid($scope);
            }
        });
        dialog.show();
	};
	
	var getRelSessionData = function($scope,selected){
		if(!Session.exist(selected,'yearThId',$scope.session.relSessions)){
			for(var i =0;i<selected.length;i++){
				selected[i].othersId = selected[i].yearThId;
				$scope.session.relSessions.push(selected[i]);
			}
			$scope.$digest();
			return true;
		}else{
			Util.alert('重复选择已存在关联届次');
			return false;
		}
	};
	
	result.delRelSession = function($scope,index){
		$scope.session.relSessions.splice(index,1);
	};
	
	result.initRelSessionGrid = function($scope){
		var config = {
				id : 'relSessionGrid',
				placeAt : 'relSessionGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : true,
				layout : [{
					name : '标题' , field : 'yearThTitle' , click : function(e){
						getSession($scope,e.data.row.yearThId);
						showSlidebar($scope);
					}
				},{
					name : '开始时间' , field : 'startTime'
				},{
					name : '结束时间' , field : 'endTime'
				},{
					name : '地点' ,field : 'yearThPlace'
				},{
					name : '奖节届次' , field : 'yearThInfo'
				},{
					name : '采集人员' , field : 'createUser'
				},{
					name : '操作人员' , field : 'lastModifyUser'
				},{
					name : '操作时间' , field : 'lastModifyTime'
				}],
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.relSessionSearch();}},
					        {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.relSession={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/sword/sessionInfoService/search'},
				queryParam : {
								title : $scope.session.query.relSession.title,
								awardCode : $scope.session.query.relSession.relAward,
								timeMin : $scope.session.query.relSession.period,
								timeMax : $scope.session.query.relSession.period
				}
			};
		relSessionGrid = Grid.init(config);
	};
	
	
	return result;
	
});