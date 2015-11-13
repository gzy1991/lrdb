/**
 * @author Sarah
 */

define(['jquery','PDUtilDir/dialog','PDUtilDir/grid'],
		function($,Dialog,Grid){
	
	var result = {};
	
	var houseGrid = {};
	
	result.addHouse = function($scope,index){
		var house = $scope.book.publishHouses;
		house.splice(index+1,0,{});
		$scope.book.publishHouses = house;
	};
	
	
	result.delHouse = function($scope,index){
		var house = $scope.book.publishHouses;
		if(index !== undefined){
			house.splice(index,1);
		}
		if(!house.length){
			house = [{}];
		}
		$scope.book.publishHouses = house;
		
	};
	
	result.chooseHouse = function($compile,$scope,index){
		var dialog = Dialog({
			id : 'chooseHouse',
			cache : false,
			title : '出版社列表',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.book.template.houseGrid,
            buttons:[{name:'确定',callback:function(){
            			var selected = houseGrid.getSelectedRow();
            			$scope.book.publishHouses[index] = {showName:$scope.book.publishHouses[index].showName};
            			$scope.book.publishHouses[index].houseId = selected[0].houseId;
            			$scope.book.publishHouses[index].houseName = selected[0].houseName;
            			$scope.book.publishHouses[index].showName = $scope.book.publishHouses[index].showName ? $scope.book.publishHouses[index].showName : selected[0].houseName;
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
				id : 'houseGrid',
				placeAt : 'houseGrid',
				pageSize : 10,
				index : 'checkbox',
				multi : false,
				layout : [{name : '出版社名称' , field : 'houseName'}],
				data : {type : 'URL' , value : getServer() + '/static/app/collection/classics/book/data/houseList.json'},
				formData : {
					houseName : $scope.book.house.query.cons.houseName
				}
			};
			houseGrid = Grid.init(config);
	};
	
	return result;
});