/**
 * 
 */

define(['jquery','PDUtilDir/grid','PDUtilDir/util','LrdbCommonDir/dict','LrdbCommonDir/record/record','LrdbCommonDir/uploader/single-uploader','PDUtilDir/dialog',getServer()+'/static/app/ckeditor/ckeditor.js'],
		function($,Grid,Util,Dict,Record,SingleUploader,Dialog){
	
	var result = {};
	
	var awardGrid = {};
	
	var editor = '';
	
	result.init = function($compile,$scope){
		var config = {
				id : 'awardGrid',
				placeAt : 'awardGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : true,
				layout : [{
					name : '奖节名称' , field : 'awardName' , click : function(e){
						getAward($scope,e.data.row.awardId);
						showSlidebar($scope);
					}
				},{
					name : '艺术类别' , field : 'awardArttypeName'
				},{
					name : '奖节级别' , field : 'awardLevelName'
				},{
					name : '奖节性质' , field : 'awardNatureName'
				},{
					name : '主办单位' ,field : 'awardHostName'
				},{
					name : '采集人员',field:'creatorName'
				},{
					name : '操作人员',field:'operatorName'
				},{
					name : '操作时间',field:'operateTime'
				}],
				toolbar : [{
					name : '添加' , icon : 'fa fa-plus-circle',callback:function(e){
						$scope.award.entity = {};
						showSlidebar($scope);
					}
				},{
					name:'删除',icon:'fa fa-trash-o',callback:function(e){
						var selected = awardGrid.getSelectedRow();
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
						$scope.award.query.cons = {};
						$scope.$digest();
					}
				}],
				data : {type : 'URL' , value : getServer() + '/sword/awardInfoService/searchAwardInfo'},
				queryParam : {
					awardCode : $scope.award.query.cons.name,
					arttype : $scope.award.query.cons.arttype,
					startupTime : $scope.award.query.cons.start,
					level : $scope.award.query.cons.level,
					nature : $scope.award.query.cons.nature
				}
			};
			awardGrid = Grid.init(config);
	};
	
	var getAward = function($scope,awardId){
		$.ajax({
			url : getServer() + '/sword/awardInfoService/queryAwardInfo',
			type : 'POST',
			data : {awardId : awardId},
			dataType : 'json',
			async : false,
			success : function(data){
				$scope.award.entity = data.entity;
				$scope.award.historys = $scope.award.entity.courseList;
				for(var i=0;i<$scope.award.historys.length;i++){
					$scope.award.historys[i].dateTime = $scope.award.historys[i].timeYear + ($scope.award.historys[i].timeMonth ? ('-' + $scope.award.historys[i].timeMonth) : '');
				}
				$scope.$digest();
			}
		});
	};
	
	var showSlidebar = function($scope){
		Util.slidebar({
			id : 'awardEditPanel',
			width : '900px',
			afterLoad : function(){
				//初始化ckeditor
				if (editor){
					editor.destroy();
				}
				editor = CKEDITOR.replace('awardContent');
				CKEDITOR.config.height = 400;
				if($scope.award.entity.introduction){
					editor.setData($scope.award.entity.introduction.introductionContent);
				}
    			
    			//初始化上传组件
    			SingleUploader.init({
    				pick : {
    					id : '#logoUpload'
    				},
    				type : {
    					preview : true,
    					file : 'img'
    				},
    				edit : true,
//    				data : {
//    					fileId : $scope.award.entity.pictureId,
//    					detailName : 'awardLogo',
//    					url : $scope.award.picturePath,
//    					detailFormat : ['76020000']
//    				},
    				uploader : 'awardLogo'
    			},$scope);
    			
    			$scope.$digest();
			}
		});
	};
	
	result.initDictData = function($scope){
		$.post(Dict.URL_ART_TYPE).done(function(data){
			$scope.award.arttypes = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_AWARD_LEVEL).done(function(data){
			$scope.award.levels = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_AWARD_NATURE).done(function(data){
			$scope.award.natures = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_AWARD_TREEDATA).done(function(data){
			$scope.award.awards = data.curPageData;
			$scope.$digest();
		});
		$scope.award.months = [{id:'01',name:'01'},{'id':'02',name:'02'},{id:'03',name:'03'}];
		$scope.$digest();
	};
	
	var del = function($compile,$scope,selected){
		if(selected.length){
			Util.confirm('确定删除?',function(){
				var ids = [];
				for(var i=0;i<selected.length;i++){
					ids.push(selected[i].awardId);
				}
				ids = ids.join(',');
				$.ajax({
					url : getServer() + '/sword/awardInfoService/delAwardInfo',
					type : 'POST',
					data : {ids : ids},
					dataType : 'json',
					success : function(data){
						Util.alert('删除成功');
						result.init($compile, $scope);
					}
				});
			});
		}else{
			Util.alert('请选择要删除的数据');
		}
	};
	
	result.addHistory = function($compile,$scope,index){
		if(index !== undefined){
			$scope.award.history = $scope.award.historys[index];
		}else{
			$scope.award.history = {};
		}
		var dialog = Dialog({
			id : 'editHistory',
			cache : false,
			title : '发展历程',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.award.template.editHistory,
            buttons:[{name:'确定',callback:function(){
            			$scope.award.history.dateTime = $scope.award.history.timeYear + ($scope.award.history.timeMonth ? ('-' + $scope.award.history.timeMonth) : '');
            			if(index !== undefined){
            				$scope.award.historys[index] = $scope.award.history;
            			}else{
            				$scope.award.historys.push($scope.award.history);
            			}
            			$scope.$digest();
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	result.save = function($compile,$scope){
		$scope.award.entity.unitList = [{awardUnitId:'efe0b768d2a14bb58f595a09e5814d29',unitTypeDict:'host',unitId:'11111',unitMix:'单位1',unitSortNumber:0},{awardUnitId:'b6923d2a353f4257b5f2e2b7e943319f',unitTypeDict:'co',unitId:'',unitMix:'单位4',unitSortNumber:0}];
		var introductionId = $scope.award.entity.introduction ? $scope.award.entity.introduction.introductionId : '';
		$scope.award.entity.introduction = {introductionId:introductionId,introductionContent:editor.getData()};
		$scope.award.entity.courseList = $scope.award.historys;
		$.ajax({
			url : getServer() + '/sword/awardInfoService/saveAwardInfo',
			type : 'POST',
			data : {awardInfo : JSON.stringify($scope.award.entity)},
			dataType : 'json',
			success : function(data){
				$scope.award.entity = data.entity;
				Util.alert('保存成功');
				result.init($compile, $scope);
			}
		});
	};
	
	return result;
		
	
});