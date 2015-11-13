
define(['jquery','PDUtilDir/grid',
        'PDUtilDir/inputSelect','PDUtilDir/util','PDUtilDir/dialog'],
		function($,Grid,InputSelect,Util,Dialog){ 	       
	var result = {};
	var festivalAwardGrid;	
	 result.festivalAwardListInit = function(id,$scope){			
   	  var config = {
	                id:'festivalAwardList',
	                placeAt:'FestivalAwardListId',         
	                pageSize:10,                       	                                    
	                //index:'radio',
	                index:'checkbox',
					multi:'ture', 	                
	                layout:[                        
	                 {name:'奖节标题',field:'festivalAwardTitle'},
	                 {name:'奖节名称',field:'festivalAwardName'},
	                 {name:'年度',field:'festivalAwardYear'},
	             	 {name:'届次',field:'festivalAwardTimeNum'}
                	],//end layout	    	  
	    	        data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/festivalAwardRecsList.json'}	         	
           };
	       festivalAwardGrid =  Grid.init(config);//渲染grid
   };

	    result.pushFestivalAward = function($scope){
			var exist = 0;
			var selected = festivalAwardGrid.getSelectedRow();
			if (selected.length) {
				for(var i=0;i<selected.length;i++){
					for(var j=0; j<$scope.activityInfo.FestivalAwardRels.length; j++){
						if( selected[i].festivalAwardTitle == $scope.activityInfo.FestivalAwardRels[j].festivalAwardTitle ){
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
						var tmpFestivalAwardRels ={};
						tmpFestivalAwardRels.festivalAwardTitle = selected[k].festivalAwardTitle;
						tmpFestivalAwardRels.festivalAwardYear = selected[k].festivalAwardYear;
						tmpFestivalAwardRels.festivalAward = selected[k].festivalAwardYear+'年'+ '第' +selected[k].festivalAwardTimeNum + '届' +selected[k].festivalAwardName;
						$scope.activityInfo.FestivalAwardRels.push(tmpFestivalAwardRels);
					}
					$scope.$digest();
					Util.alert('添加关联成功');
				}
			} else {
				Util.alert('未勾选资源');
			}
		};		
		result.showDialog = function($compile,$scope){
			 var dialog = Dialog({	 
		    			id : 'festivalAwardListDialog',
		    			cache : false,
		    			title : '选择关联奖节信息',
		    			width : '800px',
		    			$compile : $compile,
		    			$scope : $scope,
		    			url:$scope.activityInfo.template.festivalAwardChoose,
				  		buttons:[
				  		         {
				  		    	   name:'确定',
				  		    	   callback:function(dialog){
				  		    		 result.pushFestivalAward($scope);
			 	  		    		 dialog.hide();
				  		    	   }
				   		         }
				  		       ],
				  		 afterLoad:function(dialog){	
				 		 	
				  			 result.festivalAwardListInit('',$scope);
				  			
				  			 
		                 }   	
		            });

			    dialog.show();
		};
	
     return result ;
});