/**
 * 
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid','PDUtilDir/util','LrdbAwardDir/awardSessionSupport'],
		function($,Dialog,Grid,Util,Session){
	
	var result = {};
	
	var judgeGrid = {};
	
	var memberGrid = {};
	
	var groupGrid = {};
	
	var awardOpusGrid = {};
	
	//编辑奖项的相关方法
	result.editWinnerGroup = function($compile,$scope,index){
		if(index !== undefined){
			$scope.session.winnerGroup = $scope.session.winnerGroups[index];
		}else{
			$scope.session.winnerGroup = {winners:[],winnersGroupingSortNumber:$scope.session.winnerGroups.length};
		}
		
		var dialog = Dialog({
			id : 'editWinnerGroup',
			cache : false,
			title : '编辑奖项分组信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editWinnerGroup,
            buttons:[{name:'确定',callback:function(){
            			if(index !== undefined){
            				$scope.session.winnerGroups[index] = $scope.session.winnerGroup;
            			}else{
            				$scope.session.winnerGroups.push($scope.session.winnerGroup);
            			}
            			$scope.session.winnerGroups.sort(Session.compare('winnersGroupingSortNumber'));
            			$scope.$digest();
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
		
	};
	
	result.editWinner = function($compile,$scope,pIndex,index){
		if(index !== undefined){
			$scope.session.winner = $scope.session.winnerGroups[pIndex].winners[index];
			$scope.session.winner.staff = $scope.session.winner.staff.length ? $scope.session.winner.staff : [{}];
			$scope.session.winner.opus = $scope.session.winner.opus.length ? $scope.session.winner.opus : [{}];
			$scope.session.winner.orgs = $scope.session.winner.orgs.length ? $scope.session.winner.orgs : [{}];
		}else{
			$scope.session.winner = {winnersSortNumber:$scope.session.winnerGroups[pIndex].winners.length,staff:[{}],opus:[{}],orgs:[{}]};
		}
		var dialog = Dialog({
			id : 'editWinner',
			cache : false,
			title : '编辑获奖名单信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editWinner,
            buttons:[{name:'确定',callback:function(){
            			getWinnerData($scope,pIndex,index);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	var getWinnerData = function($scope,pIndex,index){
		
		//处理多个获奖人员、作品、团体的组合信息
		var memberNames = '';
		var memberShowNames = '';
		var opusNames = '';
		var opusShowNames = '';
		var groupNames = '';
		var groupShowNames = '';
		
		$scope.session.winner.awardName = $scope.session.winner.prizeNameOne ? ($scope.session.winner.prizeNameOne + ($scope.session.winner.prizeNameTwo ? ('-' + $scope.session.winner.prizeNameTwo) : '')) : '';
		for(var i=0;i<$scope.session.winner.staff.length;i++){
			$scope.session.winner.staff[i].staffSortNumber = i;
			var member = $scope.session.winner.staff[i];
			memberNames = memberNames + (member.staffName ? ((i === 0 ? member.staffName : (' ' + member.staffName))) : '');
			memberShowNames = memberShowNames + (member.staffLabel ? ((i === 0 ? member.staffLabel : (' ' + member.staffLabel))) : '');
		}
		for(var j=0;j<$scope.session.winner.opus.length;j++){
			$scope.session.winner.opus[j].opusSortNumber = j;
			var opus = $scope.session.winner.opus[j];
			opusNames = opusNames + (opus.opusName ? ((j === 0 ? opus.opusName : (' ' + opus.opusName))) : '');
			opusShowNames = opusShowNames + (opus.opusLabel ? ((j === 0 ? opus.opusLabel : (' ' + opus.opusLabel))) : '');
		}
		for(var k=0;k<$scope.session.winner.orgs.length;k++){
			$scope.session.winner.orgs[k].orgSortNumber = k;
			var group = $scope.session.winner.orgs[k];
			groupNames = groupNames + (group.orgName ? ((k === 0 ? group.orgName : (' ' + group.orgName))) : '');
			groupShowNames = groupShowNames + (group.orgLabel ? ((k === 0 ? group.orgLabel : (' ' + group.orgLabel))) : '');
		}
		$scope.session.winner.memberNames = memberNames;
		$scope.session.winner.memberShowNames = memberShowNames;
		$scope.session.winner.opusNames = opusNames;
		$scope.session.winner.opusShowNames = opusShowNames;
		$scope.session.winner.groupNames = groupNames;
		$scope.session.winner.groupShowNames = groupShowNames;
		
		if(index !== undefined){
			$scope.session.winnerGroups[pIndex].winners[index] = $scope.session.winner;
		}else{
			$scope.session.winnerGroups[pIndex].winners.push($scope.session.winner);
		}
		$scope.session.winnerGroups[pIndex].winners.sort(Session.compare('winnersSortNumber'));
		$scope.$digest();
	};
	
	result.editJudge = function($compile,$scope,index){
		if(index !== undefined){
			$scope.session.judge = $scope.session.judges[index];
		}else{
			$scope.session.judge = {judgeSortNumber:$scope.session.judges.length};
		}
		var dialog = Dialog({
			id : 'editJudge',
			cache : false,
			title : '编辑评委信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editJudge,
            buttons:[{name:'确定',callback:function(){
            			if(index !== undefined){
            				$scope.session.judges[index] = $scope.session.judge;
            			}else{
            				$scope.session.judges.push($scope.session.judge);
            			}
            			$scope.session.judges.sort(Session.compare('judgeSortNumber'));
            			$scope.$digest();
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	result.getJudge = function($compile,$scope){
		var dialog = Dialog({
			id : 'getJudge',
			cache : false,
			title : '选择作品',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getJudge,
            buttons:[{name:'确定',callback:function(){
            			var bool = getJudgeData($scope);
            			if(bool){
            				dialog.hide();
            			}
	                }}
            ],
            afterLoad:function(){
            	result.initJudgeGrid($scope);
            }
		 });
        dialog.show();
	};
	
	result.initJudgeGrid = function($scope){
		var config = {
				id : 'judgeGrid',
				placeAt : 'judgeGrid',
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
				toolbar : [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.judgeSearch();}},
				           {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.judge={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		judgeGrid = Grid.init(config);
	};
	
	var getJudgeData = function($scope){
		var selected = judgeGrid.getSelectedRow();
		if(selected.length == 1){
			if(!Session.exist(selected,'judgeId',$scope.session.judges)){
				$scope.session.judge.judgeName = 'judgeName';
				$scope.session.judge.judgeId = 'judgeId';
				$scope.session.judge.judgeIntroduction = 'judgeIntro';
				$scope.session.judge.judgeAutograph = $scope.session.judge.judgeAutograph ? $scope.session.judge.judgeAutograph : 'judgeAutograph';
				$scope.$digest();
				return true;
			}else{
				Util.alert('重复选择已存在评委');
			}
		}else{
			Util.alert('请选择一位评委。');
			return false;
		}
	};
	
	result.getMember = function($compile,$scope,index){
		var dialog = Dialog({
			id : 'getMember',
			cache : false,
			title : '选择作品',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getMember,
            buttons:[{name:'确定',callback:function(){
            			var bool = getMemberData($scope,index);
            			if(bool){
            				dialog.hide();
            			}
	                }}
            ],
            afterLoad:function(){
            	result.initMemberGrid($scope);
            }
		 });
        dialog.show();
	};
	
	result.initMemberGrid = function($scope){
		var config = {
				id : 'memberGrid',
				placeAt : 'memberGrid',
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
				toolbar : [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.memberSearch();}},
				           {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.member={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		memberGrid = Grid.init(config);
	};
	
	var getMemberData = function($scope,index){
		var selected = memberGrid.getSelectedRow();
		if(selected.length == 1){
			if(!Session.exist(selected,'staffId',$scope.session.winner.staff)){
				$scope.session.winner.staff[index].staffId = 'staffId';
				$scope.session.winner.staff[index].staffName = 'staffName';
				$scope.session.winner.staff[index].staffLabel = $scope.session.winner.staff[index].staffLabel ? $scope.session.winner.staff[index].staffLabel : 'staffLabel';
				$scope.$digest();
				return true;
			}else{
				Util.alert('重复选择已存在人员');
			}
		}else{
			Util.alert('请选择一位获奖者。');
			return false;
		}
	};
	
	result.getAwardOpus = function($compile,$scope,index){
		var dialog = Dialog({
			id : 'getAwardOpus',
			cache : false,
			title : '选择作品',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getAwardOpus,
            buttons:[{name:'确定',callback:function(){
            			var bool = getAwardOpusData($scope,index);
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
	
	result.initOpusGrid = function($scope){
		var config = {
				id : 'awardOpusGrid',
				placeAt : 'awardOpusGrid',
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
				toolbar : [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.awardOpusSearch();}},
				           {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.awardOpus={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		awardOpusGrid = Grid.init(config);
	};
	
	var getAwardOpusData = function($scope,index){
		var selected = awardOpusGrid.getSelectedRow();
		if(selected.length == 1){
			if(!Session.exist(selected,'opusId',$scope.session.winner.opus)){
				$scope.session.winner.opus[index].opusId = 'opusId';
				$scope.session.winner.opus[index].opusName = 'opusName';
				$scope.session.winner.opus[index].opusLabel = $scope.session.winner.opus[index].opusLabel ? $scope.session.winner.opus[index].opusLabel : 'opusLabel';
				$scope.$digest();
				return true;
			}else{
				Util.alert('重复选择已存在作品');
			}
			
		}else{
			Util.alert('请选择一部作品。');
			return false;
		}
	};
	
	result.getGroup = function($compile,$scope,index){
		var dialog = Dialog({
			id : 'getGroup',
			cache : false,
			title : '选择团体',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getGroup,
            buttons:[{name:'确定',callback:function(){
            			var bool = getGroupData($scope,index);
            			if(bool){
            				dialog.hide();
            			}
	                }}
            ],
            afterLoad:function(){
            	result.initGroupGrid($scope);
            }
		 });
        dialog.show();
	};
	
	result.initGroupGrid = function($scope){
		var config = {
				id : 'awardGroupGrid',
				placeAt : 'awardGroupGrid',
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
				toolbar : [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.awardGroupSearch();}},
				           {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.awardGroup={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		groupGrid = Grid.init(config);
	};
	
	var getGroupData = function($scope,index){
		var selected = groupGrid.getSelectedRow();
		if(selected.length == 1){
			if(!Session.exist(selected,'orgId',$scope.session.winner.orgs)){
				$scope.session.winner.orgs[index].orgId = 'orgId';
				$scope.session.winner.orgs[index].orgName = 'orgName';
				$scope.session.winner.orgs[index].orgLabel = $scope.session.winner.orgs[index].orgLabel ? $scope.session.winner.orgs[index].orgLabel : 'orgLabel';
				$scope.$digest();
				return true;
			}else{
				Util.alert('重复选择已存在团体');
			}
			
		}else{
			Util.alert('请选择一个团体。');
			return false;
		}
	};
	
	result.addAwardOpus = function($scope,index){
		$scope.session.winner.opus.splice(index+1,0,{});
	};
	
	result.delAwardOpus = function($scope,index){
		$scope.session.winner.opus.splice(index,1);
		if(!$scope.session.winner.opus.length){
			$scope.session.winner.opus = [{}];
		}
	};
	
	result.addAwardGroup = function($scope,index){
		$scope.session.winner.orgs.splice(index+1,0,{});
	};
	
	result.delAwardGroup = function($scope,index){
		$scope.session.winner.orgs.splice(index,1);
		if(!$scope.session.winner.orgs.length){
			$scope.session.winner.orgs = [{}];
		}
	};
	
	result.addMember = function($scope,index){
		$scope.session.winner.staff.splice(index+1,0,{});
	};
	
	result.delMember = function($scope,index){
		$scope.session.winner.staff.splice(index,1);
		if(!$scope.session.winner.staff.length){
			$scope.session.winner.staff = [{}];
		}
	};
	
	result.delWinnerGroup = function($scope,index){
		$scope.session.winnerGroups.splice(index,1);
	};
	
	result.delWinner = function($scope,pIndex,index){
		$scope.session.winnerGroups[pIndex].winners.splice(index,1);
	};
	
	result.delJudge = function($scope,index){
		$scope.session.judges.splice(index,1);
	};
	
	return result;
	
});