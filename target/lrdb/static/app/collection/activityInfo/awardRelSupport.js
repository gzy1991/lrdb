
define(['jquery','PDUtilDir/grid','LrdbCommonDir/baseSupport','PDUtilDir/inputSelect',
        'PDUtilDir/util','LrdbCommonDir/utils','PDUtilDir/dialog'],
		function($,Grid,BaseSupport,InputSelect,Util,Utils,Dialog){ 	       
	var result = {};
	var judgesGrid;
	var winnerGrid;
	var groupOpusGrid;
	var organizationGrid;
	//////////////添加评委会名单////////////////
    result.judgesListInit = function(id,$scope){	
    	  var config = {
	                id:'judgesList',
	                placeAt:'judgesListId',            
	                pageSize:10,                                                       
	                //index:'radio',
	                index:'checkbox',
					multi:'ture', 	                
	                layout:[                           
	                     {name:'姓名',field:'judgesName'},
	                     {name:'年龄',field:'birthdayYear',format:function(obj){//
	                    	    var curDate = new Date();
		                    	var curYear = curDate.getFullYear();
		                    	var year=obj.row.birthdayYear;
		                    	var age=curYear-year+1;
		                    	var result = year===null?'':age;
		                    	return result;    	                                 
	                     }},
	                     {name:'性别',field:'sexName'},
	                     {name:'所在地',field:'birthPlaceName'},
	                     {name:'艺术类别',field:'artTypeNames'}
	                ],//end layout	    	        
    	            data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/awardRecsList.json'}
	         	 
            };
	      judgesGrid =  Grid.init(config);//渲染grid
    };  
    result.pushJudges = function($scope){
		var exist = 0;
		var selected ;
		selected = judgesGrid.getSelectedRow();
		if (selected.length == 1) {	
				$scope.activityInfo.tempJudgesRel.actJudgesName = selected[0].judgesName;
				$scope.activityInfo.tempJudgesRel.actJudgesTag = selected[0].judgesName;
				$scope.$digest();
				Util.alert('添加关联成功');		
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		
	result.showJudgesDialog = function($compile,$scope){
		 var dialog = Dialog({	 
	    			id : 'judegsListDialog',
	    			cache : false,
	    			title : '选择评委',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.judgesChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		 result.pushJudges($scope);
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){				 		 	
			  			 result.judgesListInit('',$scope);			  						  			 
	                 }   	
	            });

		    dialog.show();
	};    	
	result.editJudgesRel=function($compile,$scope,oldJudgesRelObj){
		$scope.oldObj.oldJudgesRelObj=oldJudgesRelObj;	
        BaseSupport.contentDialog($compile,$scope,{
	    	setting :{
	    		    id : 'judgesRelEditDialog' ,
			  		title: '编辑评委名单信息',
			  		modal:{backdrop:'static'},
			  		buttons:[
			  		       {
			  		    	   name:'保存',			 		    
			  		    	   callback:function(dialog){		  		    		   
			  		    		  /* if($('#activityJudgesRelFormId').valid()){*///如果表单验证通过
			  		    			   if($scope.oldObj.oldJudgesRelObj){//编辑
					  		    		   var newObj = $scope.activityInfo.tempJudgesRel ;
					  		    		 
					  		    		   var index=$scope.activityInfo.JudgesRels.indexOf(oldJudgesRelObj);
						  		    	   $scope.$apply(function (){
							  		    	
						  		    			$scope.activityInfo.JudgesRels.splice(index,1,newObj);
						  		    	   });
					  		    			//执行完后初始化该值
					  		    		   $scope.oldObj.oldJudgesRelObj=null;
			  		    			   }else{//新增
						  		    	   $scope.$apply(function (){
						  		    		  
						  		    		   $scope.activityInfo.JudgesRels.push($scope.activityInfo.tempJudgesRel);
				  		    		       });
			  		    			   }
						  		       dialog.hide();//关闭对话框
			  		    		   }
			  		    	   }
			   		     /*  }*/
			  		 ]
	       },
	  	  template: 'static/app/collection/activityInfo/views/addRelJudges.html',
	      afterLoad:function(dialog){
	    	  //validate();//调用校验
	      }
        });
	};
	//////////////////添加分组成名//////////////
	result.editAwardTeamNameRel=function($compile,$scope){		
        BaseSupport.contentDialog($compile,$scope,{
	    	setting :{
	    		    id : 'awardTeamRelEditDialog' ,
			  		title: '添加获奖分组名称',
			  		modal:{backdrop:'static'},//则点击空白不自动关闭
			  		buttons:[
			  		       {
			  		    	   name:'保存',
			 		    	   //close :true,//写上该属性,执行完回调函数后,自动关闭对话框
			  		    	   callback:function(dialog){			  		    		   			  		    	    
						  		if($scope.activityInfo.tempActAwardTeamName){
						  			var tmpAwardTeamRels = {};
				  		    		tmpAwardTeamRels.tmpActAwardTeamName = $scope.activityInfo.tempActAwardTeamName;			  		    						  		    					  		    				
				  		    		var WinnerRels = [];				  		    		
				  		    		tmpAwardTeamRels.WinnerRels = WinnerRels;
				  		    			//tmpAwardTeamRels.GruopOpusRels = GruopOpusRels;
				  		    			//tmpAwardTeamRels.OrganizationRels = OrganizationRels;
				  		    		$scope.activityInfo.AwardTeamRels.push(tmpAwardTeamRels);
				  		    		$scope.$digest();
				  								  			
						  		} else {  		 
						  			Util.alert('分组名称不能为空！');							  			
						  		} 	    			
						  	    dialog.hide();//关闭对话框			  		    		  
			  		    	   }
			   		       }
			  	    ]
	       },
	  	  template: 'static/app/collection/activityInfo/views/addAwardTeam.html',
	      afterLoad:function(dialog){
	    	  //validateJudge();//调用校验
	      }
        });
	};
			
	////////////////添加获奖名单/////////////		
	  result.winnerListInit = function(id,$scope){//作品列表初始化  关联作品		    
  	  var config = {
	                id:'winnerList',//grid的id吧?待确认
	                placeAt:'winnerListId',            //存放Grid的div容器ID   
	                pageSize:10,                         //一页多少条数据	                                    
	                //index:'radio',
	                index:'checkbox',
					multi:'ture', 	                
	                layout:[                           //列表各标题
	                     {name:'姓名',field:'winnerName'},
	                     {name:'年龄',field:'birthdayYear',format:function(obj){//
	                           	                    	//此处待优化
	                          var curDate = new Date();
	                          var curYear = curDate.getFullYear();
	                          var year=obj.row.birthdayYear;
	                          var age=curYear-year+1;
	                          var result = year===null?'':age;
	                          return result;
	                     }},
	                     {name:'性别',field:'sexName'},
	                     {name:'所在地',field:'birthPlaceName'},
	                     {name:'艺术类别',field:'artTypeNames'}
	                ],//end layout
	    	       
	         	   data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/winnerRecsList.json'} //指定获取列表数据的url  
          };
    	winnerGrid =  Grid.init(config);//渲染grid
  };
  
  result.pushWinner = function($scope,index){
		var exist = 0;
		var selected ;
		selected = winnerGrid.getSelectedRow();
		if (selected.length == 1) {	
			if(index >= 0){
				$scope.activityInfo.actWinnerOrgs[index].actWinnerRe = selected[0].winnerName;
				$scope.activityInfo.actWinnerOrgs[index].actWinnerTagRe = selected[0].winnerName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			} else {
				$scope.activityInfo.tempWinnerRel.actWinnerName = selected[0].winnerName;
				$scope.activityInfo.tempWinnerRel.actWinnerTag = selected[0].winnerName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			}						
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		

	result.showWinnerDialog = function($compile,$scope,index){
		 var dialog = Dialog({	 
	    			id : 'winnerListDialog',
	    			cache : false,
	    			title : '选择获奖人员',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.winnerChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		 result.pushWinner($scope,index);
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){				 		 	
			  			 result.winnerListInit('',$scope);			  						  			 
	                 }   	
	            });

		    dialog.show();
	};	
	
	
    result.groupOpusListInit = function(id,$scope){		 
    	  var config = {
	                id:'groupOpusListId',
	                placeAt:'groupOpusListId',             
	                pageSize:10,                                                        
	                index:'checkbox',
					multi:'ture', 	                
	                layout:[                          
	                      {name:'作品名称',field:'opusName'},
	                      {name:'主题',field:'topic'},
	                      {name:'作品类型',field:'opusType'},
	                      {name:'创作时间',field:'creatTime'},
	                      {name:'发表时间',field:'publishTime'}
	                ],	    	 
    	         data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/groupOpusRecsList.json'} //指定获取列表数据的url         	
            };
    	  groupOpusGrid = Grid.init(config);//渲染grid
    };
    
    result.pushGroupOpus = function($scope,index){
		var exist = 0;
		var selected ;
		selected = groupOpusGrid.getSelectedRow();
		if (selected.length == 1) {	
			if(index >= 0){
				$scope.activityInfo.actGroupOpusOrgs[index].actGroupOpusNameRe = selected[0].opusName;
				$scope.activityInfo.actGroupOpusOrgs[index].actGroupOpusTagRe = selected[0].opusName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			} else {
				  $scope.activityInfo.tempGroupOpusRel.actGroupOpusName= selected[0].opusName;
				  $scope.activityInfo.tempGroupOpusRel.actGroupOpusTag = selected[0].opusName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			}						
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		

	result.showGroupOpusDialog = function($compile,$scope,index){
		 var dialog = Dialog({	 
	    			id : 'groupOpusListDialog',
	    			cache : false,
	    			title : '选择获奖作品',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.groupOpusChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		 result.pushGroupOpus($scope,index);
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){				 		 	
			  			 result.groupOpusListInit('',$scope);			  						  			 
	                 }   	
	            });

		    dialog.show();
	};	
    

    result.organizationListInit = function(id,$scope){		 
    	  var config = {
	                id:'organizationListId',
	                placeAt:'organizationListId',             
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
    	  organizationGrid = Grid.init(config);//渲染grid
    };
    
    result.pushOrganization = function($scope,index){
		var exist = 0;
		var selected ;
		selected = organizationGrid.getSelectedRow();
		if (selected.length == 1) {	
			if(index >= 0){
				$scope.activityInfo.actOrganizationOrgs[index].actOrganizationNameRe = selected[0].organizationName;
				$scope.activityInfo.actOrganizationOrgs[index].actOrganizationTagRe = selected[0].organizationName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			} else {
				  $scope.activityInfo.tempOrganizationRel.actOrganizationName= selected[0].organizationName;
				  $scope.activityInfo.tempOrganizationRel.actOrganizationTag = selected[0].organizationName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			}						
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		

	result.showOrganizationDialog = function($compile,$scope,index){
		 var dialog = Dialog({	 
	    			id : 'organizationListDialog',
	    			cache : false,
	    			title : '选择获奖团体',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.organizationChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		 result.pushOrganization($scope,index);
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){				 		 	
			  			 result.organizationListInit('',$scope);			  						  			 
	                 }   	
	            });

		    dialog.show();
	};	
    
   
	result.editWinnerRel=function($compile,$scope,oldWinnerRelObj){
		$scope.oldObj.oldWinnerRelObj=oldWinnerRelObj;
		
      BaseSupport.contentDialog($compile,$scope,{
	    	setting :{
	    		    id : 'winnerRelEditDialog' ,
			  		title: '编辑获奖名单信息',
			  		modal:{backdrop:'static'},
			  		buttons:[
			  		       {
			  		    	   name:'保存',
			 		    	  
			  		    	   callback:function(dialog){
			  		    		   
			  		    		 /*  if($('#activityWinnerRelFormId').valid()){*///如果表单验证通过
			  		    			   if($scope.oldObj.oldWinnerRelObj){//编辑					  		    							  		    		   
					  		    		 var index=$scope.activityInfo.AwardTeamRels[0].WinnerRels.indexOf($scope.oldObj.oldWinnerRelObj);		  		   		
					  		    		  
					  		    		   var tmpWinnerRels ={};
						  		    	   tmpWinnerRels = mergeWinnerRels($scope);						  		 			  		    		   
						  		    	   $scope.$apply(function (){
							  		    		//将修改的值重新放回数组中
						  		    			$scope.activityInfo.AwardTeamRels[0].WinnerRels.splice(index,1,tmpWinnerRels);
						  		    	   });						  		    	   						  		    	   
					  		    			//执行完后初始化该值
					  		    		   $scope.oldObj.oldPerionRelObj=null;
					  		    		   
					  		    		   
			  		    			   }else{//新增
						  		    	   $scope.$apply(function (){
						  		    		   //将新增页面接受到的值传递给作品关联数组
						  		    		 //  $scope.activityInfo.WinnerRels.push($scope.activityInfo.tempWinnerRel);
						  		    			// 将填写完毕的参与人员姓名、标签页分别作拼接，以便在记录中一个子里显示  
							  		    	   var tmpWinnerRels ={};
							  		    	 tmpWinnerRels = mergeWinnerRels($scope);

							  		    	   $scope.activityInfo.AwardTeamRels[0].WinnerRels.push(tmpWinnerRels);
							  		    	   //$scope.activityInfo.AwardTeamRels[0].tmpWinnerRels.push(tmpWinnerRels);									  		   										  						  		    	   
						  		    	   });
			  		    			   }
						  		       dialog.hide();//关闭对话框
			  		    		   }
			  		    	   }
			   		      /* }*/
			  		 ]
	       },
	  	  template: 'static/app/collection/activityInfo/views/addRelWinner.html',
	      afterLoad:function(dialog){
	    	  //validateWinner();//调用校验
	      }
      });
	};
		
 var mergeWinnerRels = function($scope){	
		
		       var joinAwardName=$scope.activityInfo.tempAwardRel.actAwardName;	           
 	           for(i =0; i < $scope.activityInfo.actAwardOrgs.length; i ++)
 		       joinAwardName +=','+ $scope.activityInfo.actAwardOrgs[i].actAwardNameRe ;	   
		     
 	           var joinWinnerName=$scope.activityInfo.tempWinnerRel.actWinnerName;	           
	    	   for(i =0; i < $scope.activityInfo.actWinnerOrgs.length; i ++)
	    		   joinWinnerName +=','+ $scope.activityInfo.actWinnerOrgs[i].actWinnerRe ;	    		     
	    	   
	    	   var joinWinnerTag=$scope.activityInfo.tempWinnerRel.actWinnerTag;	           
	    	   for(i =0; i < $scope.activityInfo.actWinnerOrgs.length; i ++)
	    		   joinWinnerTag +=','+ $scope.activityInfo.actWinnerOrgs[i].actWinnerTagRe ;
	    	   
	    	   var joinGroupOpusName=$scope.activityInfo.tempGroupOpusRel.actGroupOpusName;	           
	    	   for(i =0; i < $scope.activityInfo.actGroupOpusOrgs.length; i ++)
	    		   joinGroupOpusName +=','+ $scope.activityInfo.actGroupOpusOrgs[i].actGroupOpusNameRe ;	    		     
	    	   
	    	   var joinGroupOpusTag=$scope.activityInfo.tempGroupOpusRel.actGroupOpusTag;	           
	    	   for(i =0; i < $scope.activityInfo.actGroupOpusOrgs.length; i ++)
	    		   joinGroupOpusTag +=','+ $scope.activityInfo.actGroupOpusOrgs[i].actGroupOpusTagRe ;
	    	  
	    	   var joinOrganizationName=$scope.activityInfo.tempOrganizationRel.actOrganizationName;	           
	    	   for(i =0; i < $scope.activityInfo.actOrganizationOrgs.length; i ++)
	    		   joinOrganizationName +=','+ $scope.activityInfo.actOrganizationOrgs[i].actOrganizationNameRe ;	    		     
	    	   
	    	   var joinOrganizationTag=$scope.activityInfo.tempOrganizationRel.actOrganizationTag;	           
	    	   for(i =0; i < $scope.activityInfo.actOrganizationOrgs.length; i ++)
	    		   joinOrganizationTag +=','+ $scope.activityInfo.actOrganizationOrgs[i].actOrganizationTagRe ;
 	      
	    	   //将拼接后的姓名、标签，以及拼接前的姓名和标签的值写入参与活动人员信息数组persionRels中
	    	   var tmpWinnerRels ={};
	    	  
	    	   tmpWinnerRels.actAwardName = joinAwardName;
	    	   tmpWinnerRels.actWinnerName = joinWinnerName;
	    	   tmpWinnerRels.actWinnerTag = joinWinnerTag;
	    	   tmpWinnerRels.actGroupOpusName = joinGroupOpusName;
	    	   tmpWinnerRels.actGroupOpusTag = joinGroupOpusTag;
	    	   tmpWinnerRels.actOrganizationName = joinOrganizationName;
	    	   tmpWinnerRels.actOrganizationTag = joinOrganizationTag;
	    	   
	    	   tmpWinnerRels.tempAwardName = $scope.activityInfo.tempAwardName;
	    	   tmpWinnerRels.tempactAwardOrgs = $scope.activityInfo.actAwardNameOrgs;
	    	   tmpWinnerRels.tmpWinnerRel = $scope.activityInfo.tempWinnerRel;    	 
	    	   tmpWinnerRels.tmpactWinnerOrgs = $scope.activityInfo.actWinnerOrgs;	
	    	   
	    	   tmpWinnerRels.tmpGroupOpusRel = $scope.activityInfo.tempGroupOpusRel;    	 
	    	   tmpWinnerRels.tmpactGroupOpusOrgs = $scope.activityInfo.actGroupOpusOrgs;	
	    	   tmpWinnerRels.tmpOrganizationRel = $scope.activityInfo.tempOrganizationRel;    	 
	    	   tmpWinnerRels.tmpactOrganizationOrgs = $scope.activityInfo.actOrganizationOrgs;	
	      
	    	 return tmpWinnerRels;	    	  		
	};
	
	
    var validate = function(){
        $('#activityWinnerRelFormId').validate({
           /* rules:{//要校验的字段及校验规则
            	opusId : {//作品名称
            		required:true,
            		chineseLength:32
                },
                joinDate:{//参与时间
                	required:true
                },
                dictProfession : {//职务
                	chineseLength:32
                },
                remark : {//备注
                	chineseLength:255
                }
            },*/
            messages: {
          	  
            }
        });
      
        $('#activityJudgesRelFormId').validate({//行政职位职务输入数据验证   绑定验证
            /* rules:{//要校验的字段及校验规则
             	opusId : {//作品名称
             		required:true,
             		chineseLength:32
                 },
                 joinDate:{//参与时间
                 	required:true
                 },
                 dictProfession : {//职务
                 	chineseLength:32
                 },
                 remark : {//备注
                 	chineseLength:255
                 }
             },*/
             messages: {
           	  
             }
         });

    };//end validate
  
	
     return result ;
});