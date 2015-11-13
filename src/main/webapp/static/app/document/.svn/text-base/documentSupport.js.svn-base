/**
 * @author sarah
 */
define(['jquery','PDUtilDir/grid','PDUtilDir/util','PDUtilDir/inputSelect','LrdbCommonDir/dict','LrdbCommonDir/trMouseover-Mouseleave','Date','DateCN','css!DateCss'],
		function($,Grid,Util,InputSelect,Dict,Panel){
	
	var result = {};
	
	var docGrid;
	
	result.init = function($scope){
		var config = {
				id : 'documentGrid',
				placeAt : 'documentGrid',
				pageSize : 10,
				multi : true,
				hidden : false,
				pagination : true,
				cache : false,
				layout : [
				          	{name:'文件名称',field:'documentName',click:function(e){
				          		/*var docEntityUrl = getServer() + '/static/app/document/data/docEntity.json';
				          		Dict.queryDict(docEntityUrl).done(function(data){
				          			$scope.document.entity = data;
				          			$scope.$digest();
				          		});*/
				          		var docUsagesUrl = getServer() + '/static/app/document/data/usages.json';
				          		Dict.queryDict(docUsagesUrl).done(function(data){
				          			$scope.document.usages = data;
				          			$scope.$digest();
				          		});
				          		getDocEntityInfo($scope, e.data.row.documentId);
				          		_showSlidebar($scope);
				          	}},
				          	
				          	{name:'文档格式',field:'documentTypeDict'},
				          	{name:'所属机构',field:'orgCode'},
				          	{name:'资源密级',field:'documentLevelDict'},
				          	{name:'资源状态',field:'documentStateDict'}
						 ],
				toolbar : [
				           	{name:'查询',icon:'fa fa-search',callback:function(){
				           		result.init($scope);
				           	}},
				           	{name:'重置',icon:'fa fa-repeat',callback:function(){
				           		$scope.document.query.reset();
				           		$scope.$digest();
				           	}},
				           	{name:'启用',icon:'fa fa-thumb-tack',callback:function(){
				           		
				           		changeDocStatus($scope,'enable');
				           	}},
				           	{name:'禁用',icon:'fa fa-thumb-tack',callback:function(){
				           		
				           		changeDocStatus($scope,'disable');
				           	}}
				          ],
			    data : {
			    	type : 'URL',value : getServer()+'/sword/document/attachmentfile/query'
			    },
			    queryParam : {
			    	'documentName' : $scope.document.query.conditions.docTitle,
			    	'documentTypeDict' : $scope.document.query.conditions.docFormat,
			    	'artTypeDict' : $scope.document.query.conditions.artType,
	            	'orgCode' : $scope.document.query.conditions.docOrg,
	            	'documentLevelDict' : $scope.document.query.conditions.docSecret,
	            	'documentStateDict' : $scope.document.query.conditions.docStatus,
	            	'beginTime' : $scope.document.query.conditions.minTime,
	            	'endTime' : $scope.document.query.conditions.maxTime
	            },
			    trEvent : [{type:'mouseover',callback:function(e){
			    	Panel.initMouseover({
			    		content : e.data.row.intro,
						timerName : 'docTimer',
						delay : 3000,
						event : e
			    	});
			    }},{type:'mouseleave',callback:function(e){
			    	Panel.initMouseleave({
			    		timerName : 'docTimer'
			    	});
			    }}]
		};
		
		docGrid = Grid(config);
	};
	
	var getDocEntityInfo = function($scope,docId){
		
		$.ajax({
			url: getServer()+'/sword/document/attachmentfile/queryById',
            data:
            {
            	documentId : docId
            },
            type: 'POST',
            async: false,
            dataType: 'json',
            success : function(data){	 
            	
            	$scope.document.entity = data.entity;
            	$scope.document.detaiInfo = data.entity.attachdetailinfo;
    			$scope.$digest();
                
            }
            
        });
	};
	
	//初始化搜索条件
	result.initCons = function($scope){
		
		//两个时间组件初始化
		$('#minTime').datetimepicker({
			language : 'cn',
			format : 'yyyy-mm-dd',
			todayBtn : true,
			minView : 'month',
			todayHighlight : true,
			autoclose : true
		});
		$('#maxTime').datetimepicker({
			language : 'cn',
			format : 'yyyy-mm-dd',
			todayBtn : true,
			minView : 'month',
			todayHighlight : true,
			autoclose : true
		});
	};
	
	var changeDocStatus = function($scope, status){
		
		var selected = docGrid.getSelectedRow();
   		if (selected.length){
   			
   			reqChangeDocStatus($scope,selected[0].documentId,status);
   			
   		}else{
   			Util.alert('请选择记录');
   		}
	};
	
	var reqChangeDocStatus = function($scope,docId,status){
		
		$.ajax({
            url: getServer()+'/sword/document/attachmentfile/Update',
            data:
            {
            	documentId : docId,
            	documentStateDict : status
            },
            type: 'POST',
            async: false,
            dataType: 'json',
            success : function(data){	 
            	
            	Util.alert('操作成功');
            	result.init($scope);
                
            }
            
        });
	};
	
	var _showSlidebar = function($scope){
		
		var config = {
			id : 'docDetailPanel',
	        cache : false,
	        close : true,
	        width : '900px',
	        afterLoad : function(){
	        	
	        }
		};
		Util.slidebar(config);
	};
	
	return result;
});