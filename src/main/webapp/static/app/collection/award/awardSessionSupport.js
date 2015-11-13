/**
 * 
 */

define(['jquery','PDUtilDir/grid','PDUtilDir/util','LrdbCommonDir/dict','LrdbCommonDir/record/record','LrdbCommonDir/uploader/single-uploader','PDUtilDir/dialog',getServer()+'/static/app/ckeditor/ckeditor.js'],
		function($,Grid,Util,Dict,Record,SingleUploader,Dialog){
	
	var result = {};
	
	var sessionGrid = {};
	
	var editor = '';
	
	result.init = function($compile,$scope){
		var config = {
				id : 'sessionGrid',
				placeAt : 'sessionGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : true,
				layout : [{
					name : '标题' , field : 'yearThTitle' , click : function(e){
						clearEntity($scope);
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
				toolbar : [{
					name : '添加' , icon : 'fa fa-plus-circle',callback:function(e){
						clearEntity($scope);
						showSlidebar($scope);
					}
				},{
					name:'删除',icon:'fa fa-trash-o',callback:function(e){
						var selected = sessionGrid.getSelectedRow();
						del($compile,$scope,selected);
					}
				},{
					name:'跟踪',icon:'fa fa-bar-chart',callback:function(e){
						Record.instance({
							$scope:$scope, 
							$compile:$compile,
							model:'s'
						});
					}
				},{
					name:'查询',icon:'fa fa-search',callback:function(e){
						result.init($compile,$scope);
					}
				},{
					name:'重置',icon:'fa fa-repeat',callback:function(e){
						$scope.session.query.cons = {};
						$scope.$digest();
					}
				}],
				data : {type : 'URL' , value : getServer() + '/sword/sessionInfoService/search'},
				queryParam : {
					title : $scope.session.query.cons.name,
					arttype : $scope.session.query.cons.arttype,
					awardCode : $scope.session.query.cons.queryAward,
					yearMin : $scope.session.query.cons.minYear,
					yearMax : $scope.session.query.cons.maxYear,
					timeMin : $scope.session.query.cons.minSession,
					timeMax : $scope.session.query.cons.maxSession
				}
			};
			sessionGrid = Grid.init(config);
	};
	
	var clearEntity = function($scope){
		$scope.session.entity = {};
		$scope.session.sessionInfo = [];
		$scope.session.scheduleGroups = [];
		$scope.session.opusArr = [];
		$scope.session.winnerGroups = [];
		$scope.session.judges = [];
		$scope.session.activityArr = [];
		$scope.session.newsArr = [];
		$scope.session.comments = [];
		$scope.session.relAwards = [];
		$scope.session.relSessions = [];
		$scope.$digest();
	};
	
	var getSession = function($scope,yearThId){
		$.ajax({
			url : getServer() + '/sword/sessionInfoService/query',
			type : 'POST',
			data : {yearThId : yearThId},
			success : function(data){
				$scope.session.entity = data.entity;
				
				$scope.session.sessionInfo = $scope.session.entity.awards;
				yearInfoToString($scope);
				
				$scope.session.scheduleGroups = $scope.session.entity.scheduleGroups;
				$scope.session.scheduleGroups.sort(result.compare('scheduleGroupingSortNumber'));
				for(var i=0;i<$scope.session.scheduleGroups.length;i++){
					$scope.session.scheduleGroups[i].schedules.sort(result.compare('scheduleSortNumber'));
					for(var j=0;j<$scope.session.scheduleGroups[i].schedules.length;j++){
						$scope.session.scheduleGroups[i].schedules[j].date = $scope.session.scheduleGroups[i].schedules[j].startTime ? ($scope.session.scheduleGroups[i].schedules[j].startTime + ($scope.session.scheduleGroups[i].schedules[j].endTime ? ('至' + $scope.session.scheduleGroups[i].schedules[j].endTime) : '')) : '';
					}
				}
				
				$scope.session.opusArr = $scope.session.entity.opusList;
				$scope.session.opusArr.sort(result.compare('opusSortNumber'));
				for(var i=0;i<$scope.session.opusArr.length;i++){
					var labelName = '';
					for(var j=0;j<$scope.session.opusArr[i].opusTypes.length;j++){
						var groupingName = $scope.session.opusArr[i].opusTypes[j].groupingName ? $scope.session.opusArr[i].opusTypes[j].groupingName : '';
						labelName = labelName + (j === 0 ? groupingName : ('、' + groupingName));
					}
					$scope.session.opusArr[i].opusLabelName = labelName;
				}
				
				$scope.session.judges = $scope.session.entity.judges;
				$scope.session.judges.sort(result.compare('judgeSortNumber'));
				
				$scope.session.winnerGroups = $scope.session.entity.winnerGroups;
				$scope.session.winnerGroups.sort(result.compare('winnersGroupingSortNumber'));
				for(var m=0;m<$scope.session.winnerGroups.length;m++){
					
					for(var n=0;n<$scope.session.winnerGroups[m].winners.length;n++){
					
						$scope.session.winnerGroups[m].winners[n].staff.sort(result.compare('staffSortNumber'));
						$scope.session.winnerGroups[m].winners[n].opus.sort(result.compare('opusSortNumber'));
						$scope.session.winnerGroups[m].winners[n].orgs.sort(result.compare('orgSortNumber'));
					
						//处理多个获奖人员、作品、团体的组合信息
						var memberNames = '';
						var memberShowNames = '';
						var opusNames = '';
						var opusShowNames = '';
						var groupNames = '';
						var groupShowNames = '';
					
						$scope.session.winnerGroups[m].winners[n].awardName = $scope.session.winnerGroups[m].winners[n].prizeNameOne ? ($scope.session.winnerGroups[m].winners[n].prizeNameOne + ($scope.session.winnerGroups[m].winners[n].prizeNameTwo ? ('-' + $scope.session.winnerGroups[m].winners[n].prizeNameTwo) : '')) : '';
						for(var i=0;i<$scope.session.winnerGroups[m].winners[n].staff.length;i++){
							var member = $scope.session.winnerGroups[m].winners[n].staff[i];
							memberNames = memberNames + (member.staffName ? ((i === 0 ? member.staffName : (' ' + member.staffName))) : '');
							memberShowNames = memberShowNames + (member.staffLabel ? ((i === 0 ? member.staffLabel : (' ' + member.staffLabel))) : '');
						}
						for(var j=0;j<$scope.session.winnerGroups[m].winners[n].opus.length;j++){
							var opus = $scope.session.winnerGroups[m].winners[n].opus[j];
							opusNames = opusNames + (opus.opusName ? ((j === 0 ? opus.opusName : (' ' + opus.opusName))) : '');
							opusShowNames = opusShowNames + (opus.opusLabel ? ((j === 0 ? opus.opusLabel : (' ' + opus.opusLabel))) : '');
						}
						for(var k=0;k<$scope.session.winnerGroups[m].winners[n].orgs.length;k++){
							var group = $scope.session.winnerGroups[m].winners[n].orgs[k];
							groupNames = groupNames + (group.orgName ? ((k === 0 ? group.orgName : (' ' + group.orgName))) : '');
							groupShowNames = groupShowNames + (group.orgLabel ? ((k === 0 ? group.orgLabel : (' ' + group.orgLabel))) : '');
						}
						$scope.session.winnerGroups[m].winners[n].memberNames = memberNames;
						$scope.session.winnerGroups[m].winners[n].memberShowNames = memberShowNames;
						$scope.session.winnerGroups[m].winners[n].opusNames = opusNames;
						$scope.session.winnerGroups[m].winners[n].opusShowNames = opusShowNames;
						$scope.session.winnerGroups[m].winners[n].groupNames = groupNames;
						$scope.session.winnerGroups[m].winners[n].groupShowNames = groupShowNames;
					}
				}
				
				$scope.session.activityArr = $scope.session.entity.activityList;
				$scope.session.activityArr.sort(result.compare('yearThActivitySortNumber'));
				
				$scope.session.newsArr = $scope.session.entity.newsList;
				$scope.session.newsArr.sort(result.compare('yearThNewsSortNumber'));
				
				$scope.session.comments = $scope.session.entity.comments;
				$scope.session.comments.sort(result.compare('yearThCommentSortNumber'));
				
				$scope.session.relSessions = $scope.session.entity.sessions;
				
				for(var i=0;i<$scope.session.entity.awardRels.length;i++){
					$scope.session.relAwards.push($scope.session.entity.awardRels[i].awardCode);
				}
				
				$scope.$digest();
			}
		});
	};
		
	var showSlidebar = function($scope){
		Util.slidebar({
			id : 'sessionEditPanel',
			width : '900px',
			afterLoad : function(){
				SingleUploader.init({
				    pick : {
				        id : '#picker'      //选择文件的DOM节点id，需要加#
				    },
				    type : {
				        preview : true   
				    },
				    data : {
				        fileId : $scope.session.entity.pictureId,
				        size : 22.22,
				        detailFormat : ['76020'],
				        detailName : 'sessionLogo',
				        url : $scope.session.entity.picturePath
				    },
				    edit : true,            //可编辑
				    uploader : 'sessionLogo'   //实例化对象名称
				},$scope);
			}
		});
	};
	
	result.initDictData = function($scope){
		$.post(Dict.URL_ART_TYPE).done(function(data){
			$scope.session.arttypes = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_AWARD_LEVEL).done(function(data){
			$scope.session.levels = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_AWARD_NATURE).done(function(data){
			$scope.session.natures = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_AWARD_TREEDATA).done(function(data){
			$scope.session.awards = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_ART_TYPE).done(function(data){
			$scope.session.activityTypes = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_AWARD_TEMPLATE).done(function(data){
			$scope.session.showTemplates = data.curPageData;
			$scope.$digest();
		});
	};
	
	var del = function($compile,$scope,selected){
		if(selected.length){
			Util.confirm('确定删除?',function(){
				var ids = [];
				for(var i=0;i<selected.length;i++){
					ids.push(selected[i].yearThId);
				}
				ids = ids.join(',');
				$.ajax({
					url : getServer() + '/sword/sessionInfoService/delete',
					type : 'POST',
					data : {yearThIds : ids},
					success : function(data){
						if(data.status = '200'){
							Util.alert('删除成功');
							result.init($compile, $scope);
						}else{
							Util.alert('删除失败');
						}
					}
				});
			});
		}else{
			Util.alert('请选择要删除的数据');
		}
	};
	
	//编辑届次信息的相关方法
	result.editSessionInfo = function($compile,$scope){
		if(!$scope.session.sessionInfo.length){
			$scope.session.sessionInfo = [{}];
		}
		
		var dialog = Dialog({
			id : 'editSessionInfo',
			cache : false,
			title : '奖节届次信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editSessionInfo,
            buttons:[{name:'确定',callback:function(){
            			yearInfoToString($scope);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	var yearInfoToString = function($scope){
		var yearThInfo = '';
		for(var i=0;i<$scope.session.sessionInfo.length;i++){
			var obj = $scope.session.sessionInfo[i];
			yearThInfo = yearThInfo + ' ' + obj.awardYear + '年第' + obj.awardYearTh + '届' + obj.awardCode;
		}
		$scope.session.entity.yearThInfo = yearThInfo;
		$scope.$digest();
	};
	
	result.addSession = function($scope,index){
		$scope.session.sessionInfo.splice(index+1,0,{});
	};
	
	result.delSession = function($scope,index){
		$scope.session.sessionInfo.splice(index,1);
		if(!$scope.session.sessionInfo.length){
			$scope.session.sessionInfo = [{}];
		}
	};
	
	//对象数组排序方法
	result.compare = function(propertyName) {
		return function(object1, object2) {
			var value1 = parseInt(object1[propertyName] + '');
			var value2 = parseInt(object2[propertyName] + '');
			if (value2 < value1) {
				return 1;
			} else if (value2 > value1) {
				return -1;
			} else {
				return 0;
			}
		}
	};
	
	//保存方法
	result.save = function($compile,$scope){
		$scope.session.entity.awards = [];
		for(var i=0;i<$scope.session.sessionInfo.length;i++){
			if($scope.session.sessionInfo[i].awardCode){
				$scope.session.entity.awards.push($scope.session.sessionInfo[i]);
			}
		}
		
		$scope.session.entity.units = [{unitId:'unitId',unitMix:'unitMix',unitTypeDict:'unitType',unitSortNumber:'1'}];
		
		$scope.session.entity.scheduleGroups = $scope.session.scheduleGroups;
		
		for(var i=0;i<$scope.session.opusArr.length;i++){
			var opusTypes = [];
			for(j=0;j<$scope.session.opusArr[i].opusTypes.length;j++){
				if($scope.session.opusArr[i].opusTypes[j].groupingName){
					opusTypes.push($scope.session.opusArr[i].opusTypes[j]);
				}
			}
			$scope.session.opusArr[i].opusTypes = opusTypes;
		}
		$scope.session.entity.opusList = $scope.session.opusArr;
		
		$scope.session.entity.judges = $scope.session.judges;
		
		for(var i=0;i<$scope.session.winnerGroups;i++){
			for(var m=0;m<$scope.session.winnerGroups[i].winners.length;m++){
				var staff = [];
				var opus = [];
				var orgs = [];
				for(var j=0;j<$scope.session.winnerGroups[i].winners[m].staff.length;j++){
					if($scope.session.winnerGroups[i].winners[m].staff[j].staffLabel){
						staff.push($scope.session.winnerGroups[i].winners[m].staff[j]);
					}
				}
				for(var k=0;k<$scope.session.winnerGroups[i].winners[m].opus.length;k++){
					if($scope.session.winnerGroups[i].winners[m].opus[k].opusLabel){
						opus.push($scope.session.winnerGroups[i].winners[m].opus[k]);
					}
				}
				for(var n=0;n<$scope.session.winnerGroups[i].winners[m].orgs.length;n++){
					if($scope.session.winnerGroups[i].winners[m].orgs[n].orgLabel){
						orgs.push($scope.session.winnerGroups[i].winners[m].orgs[n]);
					}
				}
				$scope.session.winnerGroups[i].winners[m].staff = staff;
				$scope.session.winnerGroups[i].winners[m].opus = opus;
				$scope.session.winnerGroups[i].winners[m].orgs = orgs;
			}
		}
		$scope.session.entity.winnerGroups = $scope.session.winnerGroups;
		
		$scope.session.entity.activityList = $scope.session.activityArr;
		
		$scope.session.entity.comments = $scope.session.comments;
		
		$scope.session.entity.newsList = $scope.session.newsArr;
		
		$scope.session.entity.awardRels = [];
		for(var i=0;i<$scope.session.relAwards.length;i++){
			var obj = {awardCode:$scope.session.relAwards[i]};
			$scope.session.entity.awardRels.push(obj);
		}
		
		$scope.session.entity.sessions = $scope.session.relSessions;
		
		$.ajax({
			url : getServer() + '/sword/sessionInfoService/save',
			type : 'POST',
			data : {sessionInfo:JSON.stringify($scope.session.entity)},
			success : function(data){
				$scope.session.entity = data.entity;
				Util.alert('保存成功');
				result.init($compile, $scope);
			}
		});
	};
	
	//判断选择的关联对象是否已存在
	result.exist = function(arr,prop,comArr){
		var isExist = false;
		for(var i=0;i<arr.length;i++){
			for(var j=0;j<comArr.length;j++){
				if(arr[i][prop] === comArr[j][prop]){
					isExist = true;
					return isExist;
				}
			}
		}
		return isExist;
	};
	
	return result;
		
	
});