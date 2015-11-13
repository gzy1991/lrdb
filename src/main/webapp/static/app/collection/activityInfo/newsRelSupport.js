
define(['jquery','PDUtilDir/grid','PDUtilDir/inputSelect',
        'PDUtilDir/util','PDUtilDir/dialog','LrdbCommonDir/dict'],
		function($,Grid,InputSelect,Util,Dialog,Dict){ 	       
	
	var result = {};
	var newsGrid;
	
    result.newsListInit = function(id,$scope){	  
    	  var config = {
	                id:'newsList',
	                placeAt:'newsListId',            
	                pageSize:10,                                                          
	                //index:'radio',
	                index:'checkbox',
					multi:'ture', 	                
	                layout:[                        
	                 {name:'新闻标题',field:'newsTitle'},
	                 {name:'作者',field:'newsAuthor'},
	             	 {name:'新闻类型',field:'newsTypes'},
                     {name:'新闻来源',field:'newsSource'}
	                ],//end layout
	    	
    	           data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/newsRecsList.json'} //指定获取列表数据的url         	 
            };
    	   newsGrid = Grid(config);//渲染grid
    };
    result.newsReset = function($scope){
    	queryNewsType($scope);  	
    };
    result.pushNews = function($scope){
		var exist = 0;
		var selected = newsGrid.getSelectedRow();
		if (selected.length) {
			for(var i=0;i<selected.length;i++){
				for(var j=0; j<$scope.activityInfo.NewsRels.length; j++){
					if( selected[i].newsTitle == $scope.activityInfo.NewsRels[j].newsTitle ){
						exist = 1;
						break;
					}
				}
				if(exist){
					break;
				}
			}
			if (exist) {
				Util.alert('包含已关联资源');
			} else {
				for(var k = 0; k<selected.length; k++){
					$scope.activityInfo.NewsRels.push(selected[k]);
				}
				$scope.$digest();
				Util.alert('添加关联成功');
			}
		} else {
			Util.alert('未勾选资源');
		}
	};		

	var queryNewsType = function($scope){
		Dict.queryDict(Dict.URL_NEWS_TYPE).done(function(data){
			$scope.activityInfo.newsChoose.newsTypes = data;
			$scope.$digest();
		});		
	};
	result.showDialog = function($compile,$scope){
		 var dialog = Dialog({	 
	    			id : 'newsListDialog',
	    			cache : false,
	    			title : '选择关联新闻资讯',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.newsChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		 result.pushNews($scope);
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){	
			 		 	 queryNewsType($scope);
			  			 result.newsListInit('',$scope);			  						  			 
	                 }   	
	            });
		    dialog.show();
	};	
     return result ;
});