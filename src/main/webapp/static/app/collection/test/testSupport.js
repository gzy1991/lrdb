/**
 * 
 */

define(['jquery','PDUtilDir/grid','PDUtilDir/util','PDUtilDir/dialog'],function($,Grid,Util,Dialog){
	
	var result = {};
	
	var testGrid = {};
	
	result.init = function($compile,$scope){
		var config = {
				id : 'testGrid',
				placeAt : 'testGrid',
				pageSize : 10,
				pagination : true,
				cache : false,
				multi : true,
				layout : [{
					name : '测试名称', field:'testName',click:function(e){
						showSlidebar($scope);
					}
				},{
					name : '测试类别',field:'testType'
				}],
				data : [
			                {testName:"aslx",testType:"男",Phone:"123456",Email:"",Address:"BJ"},
			                {testName:"aslx",testType:"女",Phone:"1234567",Email:"",Address:"BJ"},
			                {testName:"aslx",testType:"男",Phone:"1234568",Email:"",Address:"BJ"},
			                {testName:"aslx",testType:"男",Phone:"1234569",Email:"",Address:"BJ"},
			                {testName:"aslx",testType:"男",Phone:"1234560",Email:"",Address:"BJ"},
			                {testName:"aslx",testType:"男",Phone:"1234561",Email:"",Address:"BJ"}
			            ]
		};
		testGrid = Grid.init(config);
	};
	
	var showSlidebar = function($scope){
		var config = {
				id : 'testEditPanel',
				width : '900px',
				afterLoad : function(){
					
				}
		};
		Util.slidebar(config);
	};
	
	var showDialog = function($compile,$scope){
		var dialog = Dialog({
			id : 'editWinnerGroup',
			cache : false,
			title : '编辑奖项分组信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.test.template.testEdit,
            buttons:[{name:'确定',callback:function(){
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	result.save = function($scope){
		var obj = {
				testId : 'testId',
				testName : 'testName',
				list : [{testId:'gzy1',testName:'gzy2'},{testId:'gzy3',testName:'gzy4'}]
		};
		$.ajax({
			url : getServer() + '/sword/test/getTestAll',
			data : {ysy : JSON.stringify(obj)},
			success : function(data){
				console.info(data);
				var res = data.entity.list[0];
			}
		});
	};
	
	
	return result;
	
});