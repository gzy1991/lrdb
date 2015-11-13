/**
 * 
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid','PDUtilDir/util','LrdbAwardDir/awardSessionSupport'],function($,Dialog,Grid,Util,Session){
	
	var result = {};
	
	var commentGrid = {};
	
	result.getComment = function($compile,$scope){
		var dialog = Dialog({
			id : 'getComment',
			cache : false,
			title : '添加评论',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.session.template.getComment,
            buttons:[{name:'确定',callback:function(){
            			var selected = commentGrid.getSelectedRow();
            			getCommentData($scope,selected);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	result.initCommentGrid($scope);
            }
        });
        dialog.show();
	};
	
	result.delComment = function($scope,index){
		$scope.session.comments.splice(index,1);
		for(var i=0;i<$scope.session.comments.length;i++){
			$scope.session.comments[i].order = i;
		}
	};
	
	result.initCommentGrid = function($scope){
		var config = {
				id : 'commentGrid',
				placeAt : 'commentGrid',
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
				toolbar :  [{name:'查询',icon:'fa fa-search',callback:function(e){$scope.session.commentSearch();}},
					        {name:'重置',icon:'fa fa-repeat',callback:function(e){$scope.session.query.comment={};$scope.$digest();}}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/award/data/sessionList.json'}
			};
		commentGrid = Grid.init(config);
	};
	
	var getCommentData = function($scope,selected){
		for(var i=0;i<selected.length;i++){
			$scope.session.comments.push({commentTitle:'commentTitle',commentOpusName:'commentOpusName',commentAuthor:'commentAuthor',commentDate:'2015-10-15'});
		}
		for(var j=0;j<$scope.session.comments.length;j++){
			$scope.session.comments[j].order = j;
		}
		$scope.$digest();
	};
	
	return result;
	
});