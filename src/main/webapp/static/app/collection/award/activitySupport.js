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
            			var bool = getActivityData($scope,selected);
            			if(bool){
            				dialog.hide();
            			}
            			
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
			$scope.session.activityArr[i].yearThActivitySortNumber = i;
		}
	};
	
	result.initActivityGrid = function($scope){
		var config = {
				id : 'activityGrid',
				placeAt : 'activityGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : true,
				layout:[{name:'活动名称',field:'activityName'},
				        {name:'艺术类型',field:'arttypeDict'},
				        {name:'活动类型',field:'acttypeDict'},				     
				        {name:'开始时间',field:'activityBeginDate',callback:function(obj){
				       
				        }},
				        {name:'结束时间',field:'activityEndDate',callback:function(obj){
				        
				        }},
				        {name:'采集人员',field:'createUser'},
				        {name:'操作人员',field:'lastmodifyUser'},
				        {name:'操作时间',field:'lastmodifyTime',callback:function(obj){
				        }}
				   
				      ],
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.activitySearch();}},
					        {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.activity={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/sword/activityInfoService/getActivityInfoList'},				    								
				queryParam : {//向后台传参
					activityName : $scope.session.query.activity.activityName,
					actArtType : $scope.session.query.activity.activityArttype,
					activityType : $scope.session.query.activity.activityType,					
					beginData : $scope.session.query.activity.startDate,
					endData : $scope.session.query.activity.endDate					
				}
			};
		activityGrid = Grid.init(config);
	};
	
	var getActivityData = function($scope,selected){
		if(!Session.exist(selected,'activityId',$scope.session.activityArr)){
			for(var i=0;i<selected.length;i++){
				$scope.session.activityArr.push(selected[i]);
			}
			for(var i=0;i<$scope.session.activityArr.length;i++){
				$scope.session.activityArr[i].yearThActivitySortNumber = i;
			}
			$scope.$digest();
			return true;
		}else{
			Util.alert('重复选择已存在活动');
			return false;
		}
		
	};
	
	return result;
	
});