/**
 * @author Sarah
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid'],
		function($,Dialog,Grid){
	
	var result = {};
	
	var authorGrid = {};
	
	result.addAuthor = function($scope,index){
		var author = $scope.book.authors;
		author.splice(index+1,0,{});
		$scope.book.authors = author;
	};
	
	
	result.delAuthor = function($scope,index){
		var author = $scope.book.authors;
		if(index !== undefined){
			author.splice(index,1);
		}
		if(!author.length){
			author = [{}];
		}
		$scope.book.authors = author;
		
	};
	
	result.chooseAuthor = function($compile,$scope,index){
		var dialog = Dialog({
			id : 'chooseAuthor',
			cache : false,
			title : '作者列表',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.book.template.authorGrid,
            buttons:[{name:'确定',callback:function(){
            			var selected = authorGrid.getSelectedRow();
            			$scope.book.authors[index] = {authorType : $scope.book.authors[index].authorType,showName:$scope.book.authors[index].showName};
            			$scope.book.authors[index].artistId = selected[0].artistId;
            			$scope.book.authors[index].name = selected[0].artistName;
            			$scope.book.authors[index].showName = $scope.book.authors[index].showName ? $scope.book.authors[index].showName : selected[0].artistName;
            			$scope.$digest();
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            	result.initGrid($scope);
            }
        });
        dialog.show();
	};
	
	result.initGrid = function($scope){
		var config = {
				id : 'authorGrid',
				placeAt : 'authorGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : false,
				layout : [{name : '姓名' , field : 'artistName'},
				          {name : '年龄' , field : 'age'},
				          {name : '出生地' , field : 'bornCity'}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/classics/book/data/authorList.json'},
				formData : {
					artistName : $scope.book.author.query.cons.artistName
				}
			};
			authorGrid = Grid.init(config);
	};
	
	return result;
});