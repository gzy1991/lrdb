define(['jquery','LrdbActDir/activityInfoSupport','LrdbActDir/persionRelSupport',
        'LrdbActDir/opusRelSupport','LrdbActDir/newsRelSupport','LrdbActDir/awardRelSupport',
        'LrdbActDir/festivalAwardRelSupport','LrdbActDir/organSupport','PDUtilDir/util','LrdbCommonDir/dict'],
    function($,support,perionRelSupport,opusRelSupport,newsRelSupport,
				awardRelSupport,festivalAwardRelSupport,organSupport,Util,Dict){
	return function($compile,$scope){
		$scope.$apply(function(){
			$scope.oldObj = {//此对象中的对象用于判断是新增还是编辑        		    
					oldPerionRelObj:'',//参与人员					
					oldOpusRelObj : '', //作品信息
					oldNewsRelObj : '', //作品信息
					oldJudgesRelObj : '', //评委信息
					oldFestivalAwardRelObj : '', //评委信息
					oldWinnerRelObj : '' //评委信息        	
	        	},			   
		    $scope.TeamIndex = 0,//获奖名单，双层 ng-repeat时，临时存储外层index值用
		    $scope.typeaHeadSite = {
		             //value : [],
		             initConfig : {
		                 key : {
		                 	id:'dictCode',
		                     name:'dictName'
		                 },
		                 data :[]
		             }
		    };
		    
			$scope.activityInfo = {
					template : {
				                activityInfoEdit:getStaticPath()+'/app/collection/activityInfo/views/activityEdit.html',	
				                activityInfoView:getStaticPath()+'/app/collection/activityInfo/views/activityView.html',	
				                processTrackInfo:getStaticPath()+'/app/collection/activityInfo/views/activityProcessTrack.html',
				                newsChoose:getStaticPath()+'/app/collection/activityInfo/views/newsList.html',
				                festivalAwardChoose:getStaticPath() + '/app/collection/activityInfo/views/festivalAwardList.html',
				                judgesChoose:getStaticPath() + '/app/collection/activityInfo/views/judgesList.html',
				                persionChoose:getStaticPath() + '/app/collection/activityInfo/views/persionList.html',
				                opusChoose:getStaticPath() + '/app/collection/activityInfo/views/opusList.html',
				                winnerChoose:getStaticPath() + '/app/collection/activityInfo/views/winnerList.html',
				                groupOpusChoose:getStaticPath() + '/app/collection/activityInfo/views/groupOpusList.html',
				                organizationChoose:getStaticPath() + '/app/collection/activityInfo/views/organizationList.html',
				                organChoose:getStaticPath() + '/app/collection/activityInfo/views/organList.html'				
					},
					entity:{},
					saveEntity:function(){
						support.saveEntity($scope);										
					},
				    query: {
						dto :{activityName:'',actArtType:'',activityType:'',beginData:'',endData:''},
						hidden : true,
						flag : false,
						query : function(){
								support.activityInfoListInit($scope);					
								},
						reset : function(){				
							    $scope.activityInfo.query.dto = {};							
								$scope.$digest();						
						     }
					    },					    					    
					    actArtTypeCodes : [],
					    actTypeCodes : [],
					    actLevelCodes:[],
					    actNatureCodes:[],
					    actProviceCodes:[],
					    actCityCodes:[],
					    actCoutryCodes:[],
					    sites:[],
				
					    ////////////////////动态添加和删除行记录的数据存储用
	                    actSiteOrgs:[],
					    actSponsorOrgs:[],//主办单位信息
					    delActSponsorOrgs:[],//删除主办单位信息
					    actOrganizerOrgs:[],//承办单位信息
					    delActOrganizerOrgs:[],//删除承办单位信息
					    actCoOrganizerOrgs:[],//协办单位信息
					    delActCoOrganizerOrgs:[],//删除协办单位信息
					    actPersionOrgs:[],//参与人员姓名/标签
					    delActPersionOrgs:[],//参与人员姓名/标签
					    actOpusOrgs:[],//参与人员姓名/标签
					    delActOpusOrgs:[],//参与人员姓名/标签
					    actWinnerOrgs:[],
					    delActWinnerOrgs:[],
					    actAwardOrgs:[],
					    delActAwardOrgs:[],
					    actGroupOpusOrgs:[],
					    delActGroupOpusOrgs:[],
					    actOrganizationOrgs:[],
					    delActOrganizationOrgs:[],
					    
					    
					    persionRels:[] ,//添加与活动相关的参与人员
					    OpusRels:[],//添加与活动相关的作品信息
					    NewsRels:[],//添加与活动相关的新闻信息
					    JudgesRels:[],//添加与活动相关的新闻信息
					    FestivalAwardRels:[],//添加与活动相关的新闻信息
					    AwardTeamRels:[],//添加与活动相关的获奖分组名称
					    WinnerRels:[],//添加与活动相关的获奖名单
		
					    tempPerionRel:{},//临时保存新增作品信息关联关系
					    tempOpusRel:{},//临时保存新增作品信息关联关系
					    tempNewsRel:{},//临时保存新增新闻信息关联关系
					    tempJudgesRel:{},//临时保存新增评委信息关联关系
					    tempFestivalAwardRel:{},//临时保存新增奖节信息关联关系
					    tempActAwardTeamName:{},//临时保存新增获奖分组名称
					  
					    tempWinnerRel:{}, //临时保存新增获奖分组名称
					    tempGroupOpusRel:{}, //临时保存新增获奖分组名称
					    tempOrganizationRel:{}, //临时保存新增获奖分组名称
		    
				       ////////在本页面动态地添加和删除行相关的函数//////////
					    addactSite:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actSiteOrgs ===''){
	                    		this.actSiteOrgs=[];//初始化
	                    	}
	                    	this.actSiteOrgs.push({});	                    	
	                    },
	                    
	                    initCreateSite:function(elmentId){
	                    	 support.initCreateSite($scope,elmentId);	                    	
	                    },
	                    
	                    		
	                    delactSite:function(index,oldSiteOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actSiteOrgs.splice(index,1);//删除
	                    
	                    },
	                    
	                    organChoose:{                	 
                    		showDialog:function(index,type){
                    		organSupport.showOrganDialog($compile,$scope,index,type);
 						    },
 						    query : {organizationName : ''},		 						
 						    reset : function(){		 							
 							$scope.activityInfo.organChoose.query = {organizationName : '' };
 						     },
 						     search : function(){		 							
 						    organSupport.organListInit('',$scope);
 						    }	                    			                    	
                        },	   
	                    
					    addactSponsor:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actSponsorOrgs ===''){
	                    		this.actSponsorOrgs=[];//初始化
	                    	}
	                    	this.actSponsorOrgs.push({});
	                    },
	                    
	                    //删除主办单位信息		
	                    delactSponsor:function(index,oldSponsorOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actSponsorOrgs.splice(index,1);//删除
	                    
	                    },
	                    addactOrganizer:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actOrganizerOrgs===''){
	                    		this.actOrganizerOrgs=[];//初始化
	                    	}
	                    	this.actOrganizerOrgs.push({});
	                    },
	                    //删除承办单位信息		
	                    delactOrganizer:function(index,oldOrganizerOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actOrganizerOrgs.splice(index,1);//删除
	                   
	                    },
	                    addactCoOrganizer:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actCoOrganizerOrgs===''){
	                    		this.actCoOrganizerOrgs=[];//初始化
	                    	}
	                    	this.actCoOrganizerOrgs.push({});
	                    },
	                    //删除协办单位信息		
	                    
	                    delactCoOrganizer:function(index,oldCoOrganizerOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actCoOrganizerOrgs.splice(index,1);//删除
	                    	//if(oldSubTypeObj.id.artistId!=''){//主键不为空即入库的数据才加入到删除列表
	                     
	                    },
	                    //
	                  /*  addactCoOrganizer:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actCoOrganizerOrgs==''){
	                    		this.actCoOrganizerOrgs=[];//初始化
	                    	}
	                    	this.actCoOrganizerOrgs.push({});
	                    },
	                    //删除协办单位信息		
	                    delactCoOrganizer:function(index,oldCoOrganizerOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actCoOrganizerOrgs.splice(index,1);//删除
	                   
	                   
	                    },
	                    */
	                  //增加参与人员姓名	
	                    addactPersion:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actPersionOrgs===''){
	                    		this.actPersionOrgs=[];//初始化
	                    	}
	                    	this.actPersionOrgs.push({});
	                    },
	                    
	                    //删除参与人员姓名		
	                    delactPersion:function(index,oldPersionOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actPersionOrgs.splice(index,1);//删除
	                    	
	                    },
	                    
	                    //增加作品
	                    addactOpus:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actOpusOrgs===''){
	                    		this.actOpusOrgs=[];//初始化
	                    	}
	                    	this.actOpusOrgs.push({});
	                    },
	                    
	                    //删除作品 		
	                    delactOpus:function(index,oldOpusOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actOpusOrgs.splice(index,1);//删除
	                   
	                    },
	                    
	                    //增加获奖名单人员姓名	
	                    addactWinner:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actWinnerOrgs===''){
	                    		this.actWinnerOrgs=[];//初始化
	                    	}
	                    	this.actWinnerOrgs.push({});
	                    },
	                    
	                    //删除获奖名单人员姓名			
	                    delactWinner:function(index,oldWinnerOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actWinnerOrgs.splice(index,1);//删除
	                   
	                  
	                    },
	                    	                    
	                    //增加奖项名称	
	                    addactAward:function(){
	                    	if(this.actAwardOrgs.length < 1){
	                    		this.actAwardOrgs.push({});
	                    	} else {
	                    		Util.alert('奖项不能超过两级');                 		
	                    	}                    	
	                    },
	                    
	                    //删除增加奖项名称		
	                    delactAward:function(index,oldAwardOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actAwardOrgs.splice(index,1);//删除	                    	                    
	                    },
	                    
	                    //增加团体名称	
	                    addactGroupOpus:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actGroupOpusOrgs===''){
	                    		this.actGroupOpusOrgs=[];//初始化
	                    	}
	                    	this.actGroupOpusOrgs.push({});
	                    },
	                    
	                    //删除单位名称		
	                    delactGroupOpus:function(index,oldGroupOpusOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actGroupOpusOrgs.splice(index,1);//删除	                    		                    
	                    },
	                    //增加单位名称	
	                    addactOrganization:function(){
	                    	//this.tempArtistSubtypeArray.push({});
	                    	if(this.actOrganizationOrgs === ''){
	                    		this.actOrganizationOrgs=[];//初始化
	                    	}
	                    	this.actOrganizationOrgs.push({});
	                    },
	                    
	                    //删除增加奖项名称		
	                    delactOrganization:function(index,oldOrganizationOrg){
	                    	//this.tempArtistSubtypeArray.splice(index,1);//删除
	                    	this.actOrganizationOrgs.splice(index,1);//删除
	                    	
	                    
	                    },
	                    
	                    
	                    ////////各tab页面中“添加”操作按钮相关函数//////////
	                    //参与人员信息
	                    addPerionRel:function(){
		        	    	this.tempPerionRel = {};
		        	    	this.actPersionOrgs =[];
		        	    	perionRelSupport.editPerionRel($compile,$scope,'');
		        	    
	                    },
	                    
	                    editPerionRel:function(index,oldPerionRelObj){//修改职务
	                    	 this.actPersionOrgs =[];
	                    	 this.tempPerionRel = oldPerionRelObj;//点击修改按钮后,将要修改的数据传送过去	                 	 
	                    	/* var tempActPer =[];	                    	 
	                    	 tempActPer =  this.tempPerionRel.activityPersion.split(',');
	                    	 this.tempPerionRel.activityPersion = tempActPer[0]; 
	                    	 this.tempPerionRel.activityPersionTag = this.persionRels[index].tmpPerionRel.activityPersionTag; 
	                    	 
	                    	 if(tempActPer.length > 1) { 	                    	
	                    		 for(i = 1; i < tempActPer.length; i++ ){
	                    			 var tempactPersionOrgs = {};
		                    		 tempactPersionOrgs.actPersionRe = tempActPer[i];
			                    	 tempactPersionOrgs.activityPersionTag = this.persionRels[index].tmpactPersionOrgs[i-1].activityPersionTag; 
			                    	 this.actPersionOrgs.push(tempactPersionOrgs);                 	 
		                    	 }
	                    		 
	                    	 }*/
	                    	 if(String(this.tempPerionRel.activityPersionTag).search(/,/) != -1){
	                    		 var tempActPerTag =[];	                    	 
		                    	 tempActPerTag =  this.tempPerionRel.activityPersionTag.split(',');
		                    	 this.tempPerionRel.activityPersionTag = tempActPerTag[0]; 
		                    	 this.tempPerionRel.activityPersion = this.persionRels[index].tmpPerionRel.activityPersion; 
		                    	 
		                    	 if(tempActPerTag.length > 1) { 	                    	
		                    		 for(i = 1; i < tempActPerTag.length; i++ ){
		                    			 var tempactPersionOrgs = {};
			                    		 tempactPersionOrgs.activityPersionTag = tempActPerTag[i];
				                    	 tempactPersionOrgs.actPersionRe = this.persionRels[index].tmpactPersionOrgs[i-1].actPersionRe; 
				                    	 this.actPersionOrgs.push(tempactPersionOrgs);                 	 
			                    	 }		                   		 
		                    	 }	                    		 
	                    	 }else {
	                    		 this.tempPerionRel.activityPersion = this.persionRels[index].tmpPerionRel.activityPersion;                     		 
	                    	 }
	                    	 
	                    	
	        	    	     perionRelSupport.editPerionRel($compile,$scope,oldPerionRelObj);
	                   },
	                   
	                   delPerionRel:function(index,oldPerionRelObj){
	                    	this.persionRels.splice(index,1);
	            
	                    },
	                       //弹出参与人员姓名列表供选择 dialog	                    	      	                     
	                     persionChoose:{                	 
		                    		showDialog:function(index){
		                    		perionRelSupport.showDialog($compile,$scope,index);
		 						},
		 						query : {persionName : ''},
		 						
		 						reset : function(){
		 							
		 							$scope.activityInfo.persionChoose.query = {persionName : '' };
		 						},
		 						search : function(){
		 							
		 							perionRelSupport.persionListInit('',$scope);
		 						}	                    			                    	
		                    },	                     
	                     ////添加 作品信息	                     
		                    addOpusRel:function(){
			        	    	this.tempOpusRel = {};

			        	    	opusRelSupport.editOpusRel($compile,$scope,'');
		                    },
		                    editOpusRel:function(oldOpusRelObj){//修改职
			        	    	 this.tempOpusRel = oldOpusRelObj;//点击修改按钮后,将要修改的数据传送过去
			    
			        	    	 opusRelSupport.editOpusRel($compile,$scope,oldOpusRelObj);
		                   },
		                    delOpusRel:function(index,oldOpusRelObj){
		                    	this.OpusRels.splice(index,1);
		                  
		                    },		                    		                  
		                     opusChoose:{
			                    	showDialog:function(){
			                    		opusRelSupport.showDialog($compile,$scope);
			 						},
			 						query : {opusName : ''},
			 						
			 						reset : function(){
			 							
			 							$scope.activityInfo.opusChoose.query = {opusName : '' };
			 						},
			 						search : function(){
			 							
			 							opusRelSupport.opusListInit('',$scope);
			 						}			                    				                    	
			                    },
		                     
		                     /////添加获奖情况--评委名单
		                     
			                    addJudgesRel:function(){
				        	        this.tempJudgesRel = {};					        	    	 
				        	    	awardRelSupport.editJudgesRel($compile,$scope,'');
			                    },
			                    editJudgesRel:function(oldJudgesRelObj){
				        	    	 this.tempJudgesRel = oldJudgesRelObj;//点击修改按钮后,将要修改的数据传送过去
				        	    	 awardRelSupport.editJudgesRel($compile,$scope,oldJudgesRelObj);
			                   },
			                    delJudgesRel:function(index,oldJudgesRelObj){
			                    	 this.JudgesRels.splice(index,1);
			    
			                    },
			                       //弹出评委名单姓名列表供选择 dialog
			                  /*  openJudgesList:function(){
			                    	awardRelSupport.openJudgesList($compile,$scope);
			                    },
			                   */
			                    judgesChoose:{
			                    	showDialog:function(){
			                    		awardRelSupport.showJudgesDialog($compile,$scope);
			 						},
			 						query : {judgesName : ''},
			 						
			 						reset : function(){
			 							
			 							$scope.activityInfo.judgesChoose.query = {judgesName : '' };
			 						},
			 						search : function(){
			 							
			 							awardRelSupport.judgesListInit('',$scope);
			 						}			                    				                    	
			                    },
			                    
			           
			                     
			                  ///////////添加 获奖分组名称/////////////
			                   addAwardTeam:function(){
			                	   this.tempActAwardTeamName = '';
			                	   
			                	   awardRelSupport.editAwardTeamNameRel($compile,$scope);	                	   
			                   },
			                   
			                   delAwardTeam:function(index){
			                	 //  if(!this.AwardTeamRels){
			                		   var last = this.AwardTeamRels.length;
			                		   this.AwardTeamRels.splice(index,1); 
			                	  // }
			                	      
			                   },			                   			                   			                   			                   			                   
			                   addWinnerRel:function(){
				        	       this.tempAwardRel = {};
			                	   this.tempWinnerRel = {};
			                	   this.tempGroupOpusRel = {};
			                	   this.tempOrganizationRel = {};
			                	   
				        	    	this.actWinnerOrgs =[];
				        	    	this.actAwardOrgs =[];
				        	    	this.actGroupOpusOrgs =[];
				        	    	this.actOrganizationOrgs =[];
				        	    	
				        	    	awardRelSupport.editWinnerRel($compile,$scope,'');
			                    },
			                    editWinnerRel:function(index,oldWinnerRelObj){
			                    	 this.tempWinnerRel = oldWinnerRelObj;//点击修改按钮后,将要修改的数据传送过去
				        	    	 this.actWinnerOrgs =[];
				        	    	 this.actAwardOrgs =[];
				        	    	 this.actGroupOpusOrgs =[];
				        	    	 this.actOrganizationOrgs =[];
				        	    	// awardRelSupport.editWinnerRel($compile,$scope,oldWinnerRelObj);
				        	    	 var tempActAward =[];
				        	    	  
				        	    	  if(String($scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actAwardName).search(/,/) != -1){
				        	    		  tempActAward =  $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actAwardName.split(',');
				        	    		  this.tempAwardRel.actAwardName = tempActAward[0]; 	
				        	    	  }else {
				        	    		  this.tempAwardRel.actAwardName = $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actAwardName;
				        	    		  
				        	    	  }
				        	    	       
				        	    	 
				        	    	 var tempActPer =[];
				        	    	 if(String($scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actWinnerName).search(/,/) != -1){
				        	    		 tempActPer =  $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actWinnerName.split(',');
				        	    		 this.tempWinnerRel.actWinnerName = tempActPer[0]; 
					                             	    		 
				        	    	 } else{
				        	    		  this.tempWinnerRel.actWinnerName =  $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actWinnerName; 					                    
				        	    	 } 
				        	    	       
				        	    	 
			                    	 var tempActTag =[];	
			                    	 if(String($scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actWinnerTag).search(/,/) != -1){
			                    		 tempActTag = $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actWinnerTag.split(',');  
			                    		 this.tempWinnerRel.actWinnerTag = tempActTag[0];
			                    	 } else {
			                    		  this.tempWinnerRel.actWinnerTag =  $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actWinnerTag;      	
			                    	 }
			                    		
			                    	 
			                    	 var tempActGroupOpus =[];
			                    	 if(String($scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actGroupOpusName).search(/,/) != -1){
			                    		 tempActGroupOpus =  $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actGroupOpusName.split(',');
			                    		 this.tempGroupOpusRel.actGroupOpusName = tempActGroupOpus[0]; 
			                    	 }else {
			                    		 this.tempGroupOpusRel.actGroupOpusName = $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actGroupOpusName; 
			                    	 }
			                    		
				        	    	 
			                    	 var tempActGroupOpusTag =[];
			                    	 if(String($scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actGroupOpusTag).search(/,/) != -1){
			                    		 tempActGroupOpusTag = $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actGroupOpusTag.split(',');  
			                    		 this.tempGroupOpusRel.actGroupOpusTag = tempActGroupOpusTag[0]; 
			                    	 } else {
			                    		 this.tempGroupOpusRel.actGroupOpusTag = $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actGroupOpusTag; 
			                    		 
			                    	 }
			                    		
			                    	
			                    	 var tempActOrganization =[];
			                    	 if(String($scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actOrganizationName).search(/,/) != -1){
			                    		 tempActOrganization =  $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actOrganizationName.split(',');
			                    		 this.tempOrganizationRel.actOrganizationName = tempActOrganization[0]; 
			                    	 } else{
			                    		 this.tempOrganizationRel.actOrganizationName =  $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actOrganizationName;			                    		 
			                    	 }
			                    		
				        	    	 
			                    	 var tempActOrganizationTag =[];
			                    	 if(String($scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actOrganizationTag).search(/,/) != -1) {
			                    		 tempActOrganizationTag = $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actOrganizationTag.split(','); 
			                    		 this.tempOrganizationRel.actOrganizationTag = tempActOrganizationTag[0];
			                    	 }else {
			                    		 this.tempOrganizationRel.actOrganizationTag = $scope.activityInfo.AwardTeamRels[0].WinnerRels[index].actOrganizationTag;			                    		 
			                    	 }
			                    	 if(tempActAward.length > 1) { 
			                    		 var i;
			                    		 for(i = 1; i < tempActAward.length; i++ ){
			                    			 var tempactAwardOrgs = {};
			                    			 tempactAwardOrgs.actAwardNameRe = tempActAward[i];
			                    			
					                    	 this.actAwardOrgs.push(tempactAwardOrgs);                 	 
				                    	 }		                   		 
			                    	 }	      			                    	 			                    	 
			                    	 
			                    	 if(tempActPer.length > 1) { 	                    	
			                    		 for(i = 1; i < tempActPer.length; i++ ){
			                    			 var tempactWinnerOrgs = {};
			                    			 tempactWinnerOrgs.actWinnerRe = tempActPer[i];
			                    			 tempactWinnerOrgs.actWinnerTagRe = tempActTag[i]; 
					                    	 this.actWinnerOrgs.push(tempactWinnerOrgs);                 	 
				                    	 }			                    		 
			                    	 }	 			                    	 
			                    	
			                    	 if(tempActGroupOpus.length > 1) { 	                    	
			                    		 for(i = 1; i < tempActGroupOpus.length; i++ ){
			                    			 var tempactGroupOpusOrgs = {};
			                    			 tempactGroupOpusOrgs.actGroupOpusNameRe = tempActGroupOpus[i];
			                    			 tempactGroupOpusOrgs.actGroupOpusTagRe = tempActGroupOpusTag[i]; 
					                    	 this.actGroupOpusOrgs.push(tempactGroupOpusOrgs);                 	 
				                    	 }			                    		 
			                    	 }				                    	 			                   	 
			                    	
			                    	 if(tempActOrganization.length > 1) { 	                    	
			                    		 for(i = 1; i < tempActOrganization.length; i++ ){
			                    			 var tempactOrganizationOrgs = {};
			                    			 tempactOrganizationOrgs.actOrganizationNameRe = tempActOrganization[i];
			                    			 tempactOrganizationOrgs.actOrganizationTagRe = tempActOrganizationTag[i]; 
					                    	 this.actOrganizationOrgs.push(tempactOrganizationOrgs);                 	 
				                    	 }
			                    		 
			                    	 }	
			                    	 awardRelSupport.editWinnerRel($compile,$scope,oldWinnerRelObj);
			                    },
			                    delWinnerRel:function(index,oldWinnerRelObj){			                  
			                    	 $scope.activityInfo.AwardTeamRels[0].WinnerRels.splice(index,1);
			                    },
			                    
			                    winnerChoose:{                	 
		                    		showDialog:function(index){
		                    		awardRelSupport.showWinnerDialog($compile,$scope,index);
		 						    },
		 						    query : {winnerName : ''},		 						
		 						    reset : function(){		 							
		 							$scope.activityInfo.winnerChoose.query = {winnerName : '' };
		 						     },
		 						     search : function(){		 							
		 							  awardRelSupport.winnerListInit('',$scope);
		 						      }	                    			                    	
		                        },	 
		                        groupOpusChoose:{                	 
		                    		showDialog:function(index){
		                    		awardRelSupport.showGroupOpusDialog($compile,$scope,index);
		 						    },
		 						    query : {opusName : ''},		 						
		 						    reset : function(){		 							
		 							$scope.activityInfo.groupOpusChoose.query = {opusName : '' };
		 						     },
		 						    search : function(){		 							
		 							  awardRelSupport.groupOpusListInit('',$scope);
		 						    }	                    			                    	
		                        },	   
		                        organizationChoose:{                	 
		                    		showDialog:function(index){
		                    		awardRelSupport.showOrganizationDialog($compile,$scope,index);
		 						    },
		 						    query : {organizationName : ''},		 						
		 						    reset : function(){		 							
		 							$scope.activityInfo.organizationChoose.query = {organizationName : '' };
		 						     },
		 						     search : function(){		 							
		 							  awardRelSupport.organizationListInit('',$scope);
		 						      }	                    			                    	
		                        },	   
			                    
			                                 			                     			
                                /////添加新闻资讯
			                     //弹出新闻资讯列表供选择 dialog
			                     newsChoose:{
			 						showDialog:function(){
			 							newsRelSupport.showDialog($compile,$scope);
			 						},
			 						query : {newsTitle : '' , newsAuthor : '' , newsTypes : '' , newsSource : ''},
			 						
			 						reset : function(){
			 							newsRelSupport.newsReset($scope);
			 							$scope.activityInfo.newsChoose.query = {newsTitle : '' , newsAuthor : '' , newsTypes : '', newsSource: ''};
			 						},
			 						search : function(){
			 							
			 							newsRelSupport.newsListInit($scope);
			 						},
			 						newsTypes:[]
			 						
			 					},	
			 					delNewsRel:function(index,oldNewsRelObj){
				                    this.NewsRels.splice(index,1);			                 
				                },
			                     
		                   //弹出奖节关联信息列表供选择 dialog
			                    
								 festivalAwardChoose:{
				 						showDialog:function(){
				 							festivalAwardRelSupport.showDialog($compile,$scope);
				 						},
				 						query : {actFestivalAwardTitle : '' , actFestivalAwardYear : '' , actFestivalAwardTimeNum : '' },
				 						
				 						reset : function(){
				 							
				 							$scope.activityInfo.festivalAwardChoose.query = {actFestivalAwardTitle : '' , actFestivalAwardYear : '' , actFestivalAwardTimeNum : '' };
				 						},
				 						search : function(){
				 							
				 							festivalAwardRelSupport.festivalAwardListInit($scope);
				 						}	
				 					},	
				        	        delFestivalAwardRel : function(index, oldFestivalAwardRelObj) {
									this.FestivalAwardRels.splice(index, 1);
								
								}								
							    
			            };//endofactivityInfo
		
		  });	
		
		//searchBlock.init('queryConditions');
		support.mainQueryInitInput($scope);
		support.activityInfoListInit($scope);
		
	  };
   }
);
