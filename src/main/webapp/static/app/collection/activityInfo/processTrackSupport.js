define(["jquery","PDUtilDir/util","PDUtilDir/grid",],function($,Util,Grid){
	
	var result = {};
	
	result.ActivityListInit = function($scope){
		var config = {
				id:"activityProcessTrackGrid",
				placeAt:"activityProcessTrackGrid",
				pageSize:10,
				index:"checkbox",			
				pageSize : '15',
				layout : [{name : '标题',field : 'resourceTitle'},
			                  {name : '资源类型',field : 'resourceType'},
				              {name : '操作人',field : 'modifyMember'},
				              {name : '所属机构',field : 'modifyDep'},
				              {name : '操作时间',field : 'modifyTime'},
				              {name : '业务类型',field : 'modifyType'}],
			    data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/modifyHistoryRecsList.json'},
			
		       };
		gridInstance = Grid.init(config);
	};
	return result;
});