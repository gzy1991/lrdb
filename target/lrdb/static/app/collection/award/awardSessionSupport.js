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
					name : '采集人员' , field : 'creatorName'
				},{
					name : '操作人员' , field : 'operatorName'
				},{
					name : '操作时间' , field : 'operateTime'
				}],
				toolbar : [{
					name : '添加' , icon : 'fa fa-plus-circle',callback:function(e){
						showSlidebar($scope);
					}
				},{
					name:'删除',icon:'fa fa-trash-o',callback:function(e){
						var selected = sessionGrid.getSelectedRow();
						del($scope,selected);
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
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
			sessionGrid = Grid.init(config);
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
				        fileId : 'ABCDEFG',
				        size : 22.22,
				        detailFormat : ['76020'],
				        detailName : 'sessionLogo'
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
	
	var del = function($scope,selected){
		if(selected.length){
			Util.confirm('确定删除?',function(){
				
			});
		}else{
			Util.alert('请选择要删除的数据');
		}
	};
	
	//编辑届次信息的相关方法
	result.editSessionInfo = function($compile,$scope){
		$scope.session.entity.sessionInfo = [{}];
		var dialog = Dialog({
			id : 'editSessionInfo',
			cache : false,
			title : '奖节届次信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.editSessionInfo,
            buttons:[{name:'确定',callback:function(){
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	result.addSession = function($scope,index){
		$scope.session.entity.sessionInfo.splice(index+1,0,{});
	};
	
	result.delSession = function($scope,index){
		$scope.session.entity.sessionInfo.splice(index,1);
		if(!$scope.session.entity.sessionInfo.length){
			$scope.session.entity.sessionInfo = [{}];
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
	
	return result;
		
	
});