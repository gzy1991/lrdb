define(['jquery','PDUtilDir/grid','LrdbCommonDir/baseSupport','PDUtilDir/inputSelect',
        'PDUtilDir/util','LrdbCommonDir/utils','PDUtilDir/dialog'],
		function($,Grid,BaseSupport,InputSelect,Util,Utils,Dialog){ 	       
	var result = {};
	var organGrid;
	
    result.organListInit = function(id,$scope){		 
    	  var config = {
	                id:'organListId',
	                placeAt:'organListId',             
	                pageSize:10,                                                        
	                index:'checkbox',
					multi:'ture', 	                
	                layout:[                          
	                      {name:'团体名称',field:'organizationName'},
	                      {name:'负责人',field:'chargePersion'},
	                      {name:'电话',field:'organphone'},
	                      {name:'创办时间',field:'creatTime'},
	                      {name:'地点',field:'siteName'}
	                ],	    	 
    	         data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/organizationList.json'} //指定获取列表数据的url         	
            };
    	  organGrid = Grid.init(config);//渲染grid
    };
    
    result.pushSponsor = function($scope,index){
		var exist = 0;
		var selected ;
		selected = organGrid.getSelectedRow();
		if (selected.length == 1) {	
			if(index >= 0){
				$scope.activityInfo.actSponsorOrgs[index].actSponsorRe = selected[0].organizationName;			
				$scope.$digest();
				Util.alert('添加关联成功');		
			} else {
				  $scope.activityInfo.entity.actSponsor= selected[0].organizationName;				 
				$scope.$digest();
				Util.alert('添加关联成功');		
			}						
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};	
	result.pushOrganizer = function($scope,index){
		var exist = 0;
		var selected ;
		selected = organGrid.getSelectedRow();
		if (selected.length == 1) {	
			if(index >= 0){
				$scope.activityInfo.actOrganizerOrgs[index].actOrganizerRe = selected[0].organizationName;			
				$scope.$digest();
				Util.alert('添加关联成功');		
			} else {
				  $scope.activityInfo.entity.actOrganizer= selected[0].organizationName;				 
				$scope.$digest();
				Util.alert('添加关联成功');		
			}						
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		
	result.pushCoOrganizer = function($scope,index){
		var exist = 0;
		var selected ;
		selected = organGrid.getSelectedRow();
		if (selected.length == 1) {	
			if(index >= 0){
				$scope.activityInfo.actCoOrganizerOrgs[index].actCoOrganizerRe = selected[0].organizationName;			
				$scope.$digest();
				Util.alert('添加关联成功');		
			} else {
				  $scope.activityInfo.entity.actCoOrganizer= selected[0].organizationName;				 
				$scope.$digest();
				Util.alert('添加关联成功');		
			}						
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		

	result.showOrganDialog = function($compile,$scope,index,type){
		 var dialog = Dialog({	 
	    			id : 'organListDialog',
	    			cache : false,
	    			title : '选择获奖团体',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.organChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		   if(type ==='Sponsor'){
			  		    			 result.pushSponsor($scope,index);			  		    			   
			  		    		   }else if(type ==='Organizer'){
			  		    			 result.pushOrganizer($scope,index);			  		    			   
			  		    		   }else if(type ==='CoOrganizer'){
			  		    			 result.pushCoOrganizer($scope,index);			  		    			   
			  		    		   }
			  		    		 
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){				 		 	
			  			 result.organListInit('',$scope);			  						  			 
	                 }   	
	            });

		    dialog.show();
	};		
     return result ;
});