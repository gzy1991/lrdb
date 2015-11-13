/**
 * 
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid','PDUtilDir/util','LrdbAwardDir/awardSessionSupport'],function($,Dialog,Grid,Util,Session){
	
	var result = {};
	
	var opusGrid = {};
	
	result.editOpus = function($compile,$scope,index){
		if(index !== undefined){
			$scope.session.opus = $scope.session.opusArr[index];
		}else{
			$scope.session.opus = {opusTypes:[],order:$scope.session.opusArr.length};
		}
		if(!$scope.session.opus.opusTypes.length){
			$scope.session.opus.opusTypes = [{}];
		}
		var dialog = Dialog({
			id : 'editOpus',
			cache : false,
			title : '编辑作品',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editOpus,
            buttons:[{name:'确定',callback:function(){
            			var labelName = '';
            			for(var i=0;i<$scope.session.opus.opusTypes.length;i++){
            				var groupingName = $scope.session.opus.opusTypes[i].groupingName ? $scope.session.opus.opusTypes[i].groupingName : '';
            				var labelName = labelName + (i === 0 ? groupingName : ('、' + groupingName));
            			}
            			$scope.session.opus.opusLabelName = labelName;
            			if(index !== undefined){
            				$scope.session.opusArr[index] = $scope.session.opus;
            			}else{
            				$scope.session.opusArr.push($scope.session.opus);
            			}
            			$scope.session.opusArr.sort(Session.compare('opusSortNumber'));
            			$scope.$digest();
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	result.delOpus = function($scope,index){
		$scope.session.opusArr.splice(index,1);
	};
	
	result.getOpus = function($compile,$scope){
		var dialog = Dialog({
			id : 'getOpus',
			cache : false,
			title : '选择作品',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getOpus,
            buttons:[{name:'确定',callback:function(){
            			var bool = getOpusData($scope);
            			if(bool){
            				dialog.hide();
            			}
	                }}
            ],
            afterLoad:function(){
            	result.initOpusGrid($scope);
            }
		 });
        dialog.show();
	};
	
	result.addOpusLabel = function($scope,index){
		$scope.session.opus.opusTypes.splice(index+1,0,{name:''});
	};
	
	result.delOpusLabel = function($scope,index){
		$scope.session.opus.opusTypes.splice(index,1);
		if(!$scope.session.opus.opusTypes.length){
			$scope.session.opus.opusTypes = [{}];
		}
	};
	
	result.initOpusGrid = function($scope){
		var config = {
				id : 'opusGrid',
				placeAt : 'opusGrid',
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
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.opusSearch();}},
				           {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.opus={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
			opusGrid = Grid.init(config);
	};
	
	var getOpusData = function($scope){
		var selected = opusGrid.getSelectedRow();
		if(selected.length == 1){
			if(!Session.exist(selected,'opusId',$scope.session.opusArr)){
				$scope.session.opus.opusName = 'OpusName';
				$scope.session.opus.opusId = 'opusId';
				$scope.session.opus.opusLabel = $scope.session.opus.opusLabel ? $scope.session.opus.opusLabel : 'OpusLabel';
				$scope.$digest();
				return true;
			}else{
				Util.alert('重复了已选择的作品');
			}
			
		}else{
			Util.alert('请选择一部作品。');
			return false;
		}
	};
	
	
	return result;
	
});