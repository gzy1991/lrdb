/**
 * @author Sarah
 */

define(['jquery','LrdbCommonDir/record/record','PDUtilDir/grid','LrdbCommonDir/dict','PDUtilDir/util'],
		function($,Record,Grid,Dict,Util){
	
	var result = {};
	
	var essayGrid = {};
	
	result.init = function($compile,$scope){
		var config = {
			id : 'essayGrid',
			placeAt : 'essayGrid',
			pageSize : 10,
			index : 'checkbox',
			multi : true,
			layout : [{
				name : '图书名称' , field : 'bookName' , click : function(e){
					showSlidebar($scope);
				}
			},{
				name : '艺术类别' , field : 'artTypeName'
			},{
				name : '作者' , field : 'authorName'
			},{
				name : '出版单位' , field : 'publishHouseName'
			},{
				name : '出版时间' ,field : 'publishTime'
			},{
				name : '版次' , field : 'edition'
			},{
				name : '采集人员' , field : 'creatorName'
			},{
				name : '操作人员' , field : 'operatorName'
			},{
				name : '操作时间' , field : 'operateTime'
			},{
				name : '有否附件' , field : 'attach'
			}],
			toolbar : [{
				name : '添加' , icon : 'fa fa-plus-circle',callback:function(e){
					showSlidebar($scope);
				}
			},{
				name:'删除',icon:'fa fa-trash-o',callback:function(e){
					var selected = bookGrid.getSelectedRow();
					del($scope,selected);
				}
			},{
				name:'跟踪',icon:'fa fa-history',callback:function(e){
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
					$scope.book.query.cons = {};
					$scope.$digest();
				}
			}],
			data : {type : 'URL' , value : getServer() + '/static/app/collection/classics/book/data/bookList.json'},
		    formData:{//用于查询
		    	bookName : $scope.book.query.cons.bookName
	        }
		};
		bookGrid = Grid.init(config);
	};
	
	
	
	
	
	return result;
	
});