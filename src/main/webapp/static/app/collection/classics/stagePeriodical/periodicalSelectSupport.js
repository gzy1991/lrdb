/**
 * @author zhanglei@css.com.cn
 */
define(['jquery','PDUtilDir/grid','PDUtilDir/util','LrdbCommonDir/dict','PDUtilDir/dialog', 'LrdbStagePeriodicalDir/stagePeriodicalColumnTree'],
	function($,Grid,Util,Dict,Dialog,stagePerTree){
		var result = {};
		var periodicalSelectGrid;
		var perNameDialog;
		var options = {
			$compile : '',
			$scope : '',
			itemName : ''
		};
		var periodicalSelectGridInit = function($compile,$scope){
			var config = {
				id : 'periodicalSelectGrid',
				placeAt : 'periodicalSelectGrid',
				pageSize : 10,
				index:"checkbox",
				multi : false,
				layout: [{
                    name: '期刊名称', field: 'periodicalNameCn', width: '20%'},
					{name: '期刊类别', field: 'typeDict', width: '8%'},
					{name: '主办单位', field: 'sponsor', width: '15%'},
					{name: '出版单位', field: 'publisher', width: '15%'},
					{name: '创刊时间', field: 'periodicalFirstTime', width: '8%'},
					{name: '出版周期', field: 'publishSiteDict', width: '8%'},
					{name: '采集人员', field: 'createUser', width: '8%'},
					{name: '操作人员', field: 'lastmodifyUser', width: '8%'},
					{name: '操作时间', field: 'lastmodifyTime', width: '10%'}],
                toolbar : [
					{
						name: '查询', icon: 'fa fa-search', callback: function () {
						periodicalSelectGridInit($compile,$scope);
					}
					},
					{
						name: '重置', icon: 'fa fa-repeat', callback: function () {
						$scope.stagePeriodical.perSelect.query.reset();
						periodicalSelectGridInit($compile,$scope);
					}}
				],
				data : {
                    type: 'URL',
					value: Dict.URL_QUERYPERIODICALINFOLIST_SERVICE
               },
				queryParam : {
					perName : $scope.stagePeriodical.perSelect.query.queryGroupName
				},
				trEvent : [{type:'dblclick',callback:function(e){
					$scope.stagePeriodical.entity.stagePeriodicalName = e.data.row.periodicalNameCn;
					$scope.stagePeriodical.entity.typeDict = e.data.row.typeDict;
					$scope.stagePeriodical.entity.periodicalId =  e.data.row.periodicalId;
					$scope.$digest();
					perNameDialog.hide();
					stagePerTree.createTreeInit($compile, $scope);
					}}]
			};
			periodicalSelectGrid = Grid.init(config);
		};

		result.instance = function(option){
			options = $.extend(options,option);
			periodicalSelectDialog(options.$compile,options.$scope);
		};

		var pushPeriodicalSelect = function($scope){
			var selected = periodicalSelectGrid.getSelectedRow();
			if(selected.length){
				$scope.stagePeriodical.entity.stagePeriodicalName = selected[0].periodicalNameCn;
				$scope.stagePeriodical.entity.typeDict = selected[0].typeDict;
				$scope.stagePeriodical.entity.periodicalId =  selected[0].periodicalId;
				$scope.$digest();

				Util.alert('添加成功！');
				return true;
			}else{
				Util.alert('未勾选资源');
				return false;
			}
		};

		var periodicalSelectDialog = function($compile,$scope){
			perNameDialog = Dialog({
				id : 'periodicalSelectId' ,
				title: '期刊选择',
				drag : true,
				$compile : $compile,
				$scope : $scope,
				width: '1000px',
				url : getServer() +'/static/app/collection/classics/stagePeriodical/views/periodicalSelect.html',
				buttons:[
					{
						name:'确定',
						callback:function(dialog){
							if(pushPeriodicalSelect($scope)){
								perNameDialog.hide();
								stagePerTree.createTreeInit($compile,$scope);
							}
						}
					}
				],
				//modal:{backdrop:'static'},//则点击空白不自动关闭
				afterLoad:function(){
					periodicalSelectGridInit($compile,$scope);
					//validate();//调用校验
				}
			});
			perNameDialog.show();
		};
		return result;
	}
);