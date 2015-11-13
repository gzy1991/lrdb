/**
 * 采集跟踪信息共用
 * (艺术家、作品、活动、典籍、团体、百科、奖节、)
 * @author gaodsh@css.com.cn
 */
define(['jquery','PDUtilDir/grid','PDUtilDir/util','PDUtilDir/dialog'],function($,Grid,Util,Dialog){
	
	var options={
			$scope:'', //必须
			$compile:'',//必须
			objectId:'',//业务对象ID
			model:'s'//d(dialog),s(slidebar)打开方式,默认为侧边栏打开
	};
	
	function instance(option){
		options = $.extend(options,option);
		if('s'=== options.model){
			_recordSlidebar(options.$compile,options.$scope);
		}else if('d'=== options.model){
			_recordDialog(options.$compile,options.$scope);
		}
	}
	
	function _recordSlidebar($compile,$scope){
		Util.slidebar({
			url : getServer() + '/static/app/common/record/view/recordSlidebar.html',
			width : '900px',
			afterLoad : function(){
				_recordGrid($compile,$scope);
			}
		});
	}
	
	function _recordDialog($compile,$scope){
        var dialog = Dialog({
			id : 'recordDialog',
			cache : true,
			title : '跟踪信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : getServer() + '/static/app/common/record/view/recordDialog.html',
            afterLoad:function(){
            	_recordGrid($compile,$scope);
            }
        });
        dialog.show();
	}
	
	function _recordGrid($compile,$scope){
		var config = {
				id : 'recordId',
				placeAt : 'recordListId',
				pageSize : 10,
				index : true,
				pagination : true,
				layout:[
				      {name : '标题',field : 'encyclopediaInfoID',width : '35%',align:'center'},
		              {name : '资源类型',field : 'ResouceType',width : '10%',align:'center'},
		              {name : '操作人',field : 'OprPeo',width : '10%',align:'center'},
		              {name : '所属机构',field : 'Organation',width : '15%',align:'center'},
		              {name : '操作时间',field : 'OprTime',width : '20%',align:'center'},
		              {name : '业务类型',field : 'businessType',width : '10%',align:'center'}
		        ],
		        data : {type : 'URL' , value : getServer() + '/static/app/common/record/data/record.json'}
		};
		Grid.init(config);
	}
	
	return {
		instance:instance
	};
	
	
	
});