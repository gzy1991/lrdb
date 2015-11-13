/**
 * @author Sarah
 */

define(['jquery','LrdbBookDir/bookSupport','LrdbBookDir/authorSupport','LrdbBookDir/houseSupport'],
		function($,support,authorSupport,houseSupport){
	
	return function($compile,$scope){
		$scope.$apply(function(){
			$scope.book = {
				template : {
					edit : getStaticPath() + '/app/collection/classics/book/views/bookEdit.html',
					authorEdit : getStaticPath() + '/app/collection/classics/book/views/editAuthor.html',
					authorGrid : getStaticPath() + '/app/collection/classics/book/views/authorGrid.html',
					houseEdit : getStaticPath() + '/app/collection/classics/book/views/editHouse.html',
					houseGrid : getStaticPath() + '/app/collection/classics/book/views/houseGrid.html'
				},
				entity : {},
				query : {
					cons : {
						bookName : '',
						bookType : '',
						author : '',
						publishHouse : '',
						publishMinTime : '',
						publishMaxTime : '',
						attach : ''
					}
				},
				editAuthor : function(){
					support.editAuthor($compile,$scope);
				},
				addAuthor : function(index){
					authorSupport.addAuthor($scope,index);
				},
				delAuthor : function(index){
					authorSupport.delAuthor($scope,index);
				},
				chooseAuthor : function(index){
					authorSupport.chooseAuthor($compile,$scope,index);
				},
				authors : [],
				author : {
					query : {
						cons : {},
						query : function(){
							authorSupport.initGrid($scope);
						}
					}
				},
				editPublishHouse : function(){
					support.editPublishHouse($compile,$scope);
				},
				addHouse : function(index){
					houseSupport.addHouse($scope,index);
				},
				delHouse : function(index){
					houseSupport.delHouse($scope,index);
				},
				chooseHouse : function(index){
					houseSupport.chooseHouse($compile,$scope,index);
				},
				publishHouses : [],
				house : {
					query : {
						cons : {},
						query : function(){
							houseSupport.initGrid($scope);
						}
					}
				},
				//放置关联数据表的容器
				bookTypes : [],
				collections : [],
				languages : [],
				exists : []
			};
		});
		
		support.init($compile,$scope);
		support.initQueryCons($scope);
	};
	
	
});
