/**
 * 
 */

define(['jquery','PDUtilDir/dialog','LrdbAwardDir/awardSessionSupport'],function($,Dialog,Session){
	
	var result = {};
	
	//编辑日程的相关方法
	result.editScheduleGroup = function($compile,$scope,index){
		$scope.session.scheduleGroup = {scheduleGroupingName:'',scheduleGroupingSortNumber:$scope.session.scheduleGroups.length,schedules:[]};
		if(index !== undefined){
			$scope.session.scheduleGroup = $scope.session.scheduleGroups[index];
		};
		
		var dialog = Dialog({
			id : 'editScheduleGroup',
			cache : false,
			title : '编辑日程分组',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editScheduleGroup,
            buttons:[{name:'确定',callback:function(){
            			if(index !== undefined){
            				$scope.session.scheduleGroups[index] = $scope.session.scheduleGroup;
            			}else{
            				$scope.session.scheduleGroups.push($scope.session.scheduleGroup);
            			}
            			$scope.session.scheduleGroups.sort(Session.compare('scheduleGroupingSortNumber'));
            			$scope.$digest();
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
		
	};
	
	result.delScheduleGroup = function($scope,index){
		$scope.session.scheduleGroups.splice(index,1);
	};
	
	result.delSchedule = function($scope,pIndex,index){
		$scope.session.scheduleGroups[pIndex].schedules.splice(index,1);
	};
	
	result.editSchedule = function($compile,$scope,pIndex,index){
		if(index !== undefined){
			$scope.session.schedule = $scope.session.scheduleGroups[pIndex].schedules[index];
		}else{
			$scope.session.schedule = {scheduleSortNumber:$scope.session.scheduleGroups[pIndex].schedules.length};
		}
		var dialog = Dialog({
			id : 'editSchedule',
			cache : false,
			title : '编辑日程信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editSchedule,
            buttons:[{name:'确定',callback:function(){
            			$scope.session.schedule.date = $scope.session.schedule.startTime ? ($scope.session.schedule.startTime + ($scope.session.schedule.endTime ? ('至' + $scope.session.schedule.endTime) : '')) : '';
            			if(index !== undefined){
            				$scope.session.scheduleGroups[pIndex].schedules[index] = $scope.session.schedule;
            			}else{
            				$scope.session.scheduleGroups[pIndex].schedules.push($scope.session.schedule);
            			}
            			$scope.session.scheduleGroups[pIndex].schedules.sort(Session.compare('scheduleSortNumber'));
            			$scope.$digest();
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	return result;
	
});