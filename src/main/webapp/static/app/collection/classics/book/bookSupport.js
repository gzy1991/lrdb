/**
 * @author Sarah
 */

define(['jquery','PDUtilDir/grid','PDUtilDir/inputSelect','LrdbCommonDir/dict','PDUtilDir/util','LrdbCommonDir/uploader/multi-uploader','LrdbCommonDir/uploader/single-uploader','PDUtilDir/dialog','LrdbCommonDir/record/record'],
		function($,Grid,InputSelect,Dict,Util,Multiuploader,Singleuploader,Dialog,Record){
	
	var result = {};
	
	var bookGrid = {};
	
	result.init = function($compile,$scope){
		var config = {
			id : 'bookGrid',
			placeAt : 'bookGrid',
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
//					var selected = bookGrid.getSelectedRow();
//					if(selected.length == 1){
//						trace($compile,$scope,selected[0]);
//					}else{
//						Util.alert('请选择一部图书');
//					}
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
	
	//初始化搜索条件
	result.initQueryCons = function($scope){
		$.post(Dict.URL_BOOK_ARTTYPE).done(function(data){
			$scope.book.bookTypes = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_EXIST).done(function(data){
			$scope.book.exists = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_BOOK_COLLECTION).done(function(data){
			$scope.book.collections = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_BOOK_LANGUAGE).done(function(data){
			$scope.book.languages = data.curPageData;
			$scope.$digest();
		});
		$.post(Dict.URL_FOLIO_TYPE).done(function(data){
			$scope.book.filios = data.curPageData;
			$scope.$digest();
		});
	};
	
	//打开侧边栏
	var showSlidebar = function($scope){
		Util.slidebar({
			id : 'bookEditPanel',
			width : '900px',
			afterLoad : function(){
				editPanel($scope);
			}
		});
	};
	
	var editPanel = function($scope){
		
		Multiuploader.init($scope,{
			edit : true,
			uploader : 'illustration',
			param : {
				placeAt : '#illustration',
				file : 'img'
			},
			template : {
				'detail-remark' : true
			},
			data : {
				123 : {
					fileId : 123,
					detailName : '插图1',
					detailFormat : ['76020000']
				}
			}
		});
		
		Singleuploader.init({
			pick : {
				id : '#bookCover'
			},
			type : {
				preview : true,
				file : 'img'
			},
			edit : true,
			data : {
				fileId : 'ABCD',
				detailName : 'bookCover1',
				url : '',
				detailFormat : ['76020000']
			},
			uploader : 'bookCover'
		},$scope);
		
		Multiuploader.init($scope,{
			edit : true,
			uploader : 'eResource',
			param : {
				placeAt : '#eResource',
				file : 'doc'
			},
			template : {
				'detail-remark' : true
			},
			data : {
				123 : {
					fileId : 123,
					detailName : '电子资源1',
					detailFormat : ['76020']
				}
			}
		});

	};
	
	//删除方法
	var del = function($scope,selected){
		if(selected.length){
			Util.confirm('确定删除?',function(){
				
			});
		}else{
			Util.alert('请选择需要删除的项');
		}
	};
	
	//编辑作者
	result.editAuthor = function($compile,$scope){
		$scope.book.authors = [{artistId:'ABC',id:'AAA',name:'李中原',showName:'李中原',authorType:'0',authorTypeName:'编',order:0},
    	                             {artistId:'DEF',id:'BBB',name:'钱钟书',showName:'钱钟书',authorType:'1',authorTypeName:'著',order:0},
    	                             {id:'CCC',showName:'胡巧思',authorType:'2',authorTypeName:'译',order:0}];
		if(!$scope.book.authors.length){
			$scope.book.authors = [{}];
		}
		var dialog = Dialog({
			id : 'editAuthor',
			cache : false,
			title : '作者编辑',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.book.template.authorEdit,
            buttons:[{name:'确定',callback:function(){
            			authorHandler($scope);
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	
            }
        });
        dialog.show();
	};
	
	//编辑出版社
	result.editPublishHouse = function($compile,$scope){
		$scope.book.publishHouses = [{houseId:'ABC',id:'AAA',houseName:'出版社1',showName:'出版社1',order:0},
	                             {houseId:'DEF',id:'BBB',houseName:'出版社2',showName:'出版社2',order:1},
	                             {id:'CCC',showName:'出版社3',order:2}];
		if(!$scope.book.publishHouses.length){
			$scope.book.publishHouses = [{}];
		}
		var dialog = Dialog({
			id : 'editHouse',
			cache : false,
			title : '出版社编辑',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.book.template.houseEdit,
			buttons:[{name:'确定',callback:function(){
						houseHandler($scope);
						dialog.hide();
              	}}
			],
			afterLoad:function(){
      	
			}
		});
		dialog.show();
	};
	
	//确认后对作者数据的处理
	var authorHandler = function($scope){
		var names1 = '';
		var names2 = '';
		var names3 = '';
		var index1 = 0;
		var index2 = 0;
		var index3 = 0;
		var authors = $scope.book.authors;
		for(var i=0;i<authors.length;i++){
			if(authors[i].authorType === '0'){
				names1 = names1 + authors[i].showName + ' ';
				authors[i].order = index1;
				index1++;
			}else if(authors[i].authorType == '1'){
				names2 = names2 + authors[i].showName + ' ';
				authors[i].order = index2;
				index2++;
			}else if(authors[i].authorType == '2'){
				names3 = names3 + authors[i].showName + ' ';
				authors[i].order = index3;
				index3++;
			}
		}
		names1 = names1 ? (names1 + '编   ') : '';
		names2 = names2 ? (names2 + '著   ') : '';
		names3 = names3 ? (names3 + '译   ') : '';
		$scope.book.entity.showAuthorName = names1 + names2 + names3;
		$scope.$digest();
		$scope.book.author = authors;
	};
	
	//确认后对出版社数据的处理
	var houseHandler = function($scope){
		var names = '';
		var index = 0;
		var houses = $scope.book.publishHouses;
		for(var i=0;i<houses.length;i++){
			names = names + (houses[i].showName ? houses[i].showName + '   ' : '');
		}
		$scope.book.entity.showHouseName = names;
		$scope.$digest();
		$scope.book.publishHouses = houses;
	};
	
	return result;
	
});