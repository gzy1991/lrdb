/**
 * 
 */

define(['jquery','LrdbAwardDir/awardSessionSupport','LrdbAwardDir/opusSupport','LrdbAwardDir/scheduleSupport','LrdbAwardDir/awardInfoSupport','LrdbAwardDir/activitySupport','LrdbAwardDir/newsSupport','LrdbAwardDir/commentSupport','LrdbAwardDir/relAwardSupport'],
		function($,support,opusSupport,scheduleSupport,awardInfoSupport,activitySupport,newsSupport,commentSupport,relAwardSupport){
	
	return function($compile,$scope){
		$scope.$apply(function(){
			$scope.session = {
					template : {
						sessionEdit : getStaticPath() + '/app/collection/award/views/awardSessionEdit.html',
						editSessionInfo : getStaticPath() + '/app/collection/award/views/editSessionInfo.html',
						editScheduleGroup : getStaticPath() + '/app/collection/award/views/editScheduleGroup.html',
						editSchedule : getStaticPath() + '/app/collection/award/views/editSchedule.html',
						editOpus : getStaticPath() + '/app/collection/award/views/editOpus.html',
						getOpus : getStaticPath() + '/app/collection/award/views/getOpus.html',
						editJudge : getStaticPath() + '/app/collection/award/views/editJudge.html',
						getJudge : getStaticPath() + '/app/collection/award/views/getJudge.html',
						editWinnerGroup : getStaticPath() + '/app/collection/award/views/editWinnerGroup.html',
						editWinner : getStaticPath() + '/app/collection/award/views/editWinner.html',
						getMember : getStaticPath() + '/app/collection/award/views/getMember.html',
						getAwardOpus : getStaticPath() + '/app/collection/award/views/getAwardOpus.html',
						getGroup : getStaticPath() + '/app/collection/award/views/getGroup.html',
						getActivity : getStaticPath() + '/app/collection/award/views/getActivity.html',
						getNews : getStaticPath() + '/app/collection/award/views/getNews.html',
						getComment : getStaticPath() + '/app/collection/award/views/getComment.html',
						getRelAward : getStaticPath() + '/app/collection/award/views/getRelAward.html',
						getRelSession : getStaticPath() + '/app/collection/award/views/getRelSession.html'
					},
					entity : {opus:{},activity:{}},
					query : {
						cons : {},
						opus : {},
						judge : {},
						member : {},
						awardOpus : {},
						awardGroup : {},
						activity : {},
						news : {},
						comment : {},
						relAward : {},
						relSession : {}
					},
					//存放字典数据的数组
					arttypes : [],
					levels : [],
					natures : [],
					awards : [],
					activityTypes : [],
					showTemplates : [],
					//当前届次信息
					editSessionInfo : function(){
						support.editSessionInfo($compile,$scope);
					},
					addSession : function(index){
						support.addSession($scope,index);
					},
					delSession : function(index){
						support.delSession($scope,index);
					},
					//日程
					scheduleGroups : [],
					scheduleGroup : {},
					schedule : {},
					addScheduleGroup : function(){
						scheduleSupport.editScheduleGroup($compile,$scope);
					},
					editScheduleGroup : function(index){
						scheduleSupport.editScheduleGroup($compile,$scope,index);
					},
					delScheduleGroup : function(index){
						scheduleSupport.delScheduleGroup($scope,index);
					},
					addSchedule : function(index){
						scheduleSupport.editSchedule($compile,$scope,index);
					},
					editSchedule : function(pIndex,index){
						scheduleSupport.editSchedule($compile,$scope,pIndex,index);
					},
					delSchedule : function(pIndex,index){
						scheduleSupport.delSchedule($scope,pIndex,index);
					},
					//作品
					opusArr : [],
					opus : {},
					addOpus : function(){
						opusSupport.editOpus($compile,$scope);
					},
					editOpus : function(index){
						opusSupport.editOpus($compile,$scope,index);
					},
					delOpus : function(index){
						opusSupport.delOpus($scope,index);
					},
					getOpus : function(){
						opusSupport.getOpus($compile,$scope);
					},
					addOpusLabel : function(index){
						opusSupport.addOpusLabel($scope,index);
					},
					delOpusLabel : function(index){
						opusSupport.delOpusLabel($scope,index);
					},
					opusSearch : function(){
						opusSupport.initOpusGrid($scope);
					},
					//获奖情况
					winnerGroups : [],
					winnerGroup : {},
					winner : {},
					addWinnerGroup : function(){
						awardInfoSupport.editWinnerGroup($compile,$scope);
					},
					editWinnerGroup : function(index){
						awardInfoSupport.editWinnerGroup($compile,$scope,index);
					},
					delWinnerGroup : function(index){
						awardInfoSupport.delWinnerGroup($scope,index);
					},
					addWinner : function(index){
						awardInfoSupport.editWinner($compile,$scope,index);
					},
					editWinner : function(pIndex,index){
						awardInfoSupport.editWinner($compile,$scope,pIndex,index);
					},
					delWinner : function(pIndex,index){
						awardInfoSupport.delWinner($scope,pIndex,index);
					},
					judges : [],
					judge : {},
					addJudge : function(){
						awardInfoSupport.editJudge($compile,$scope);
					},
					editJudge : function(index){
						awardInfoSupport.editJudge($compile,$scope,index);
					},
					delJudge : function(index){
						awardInfoSupport.delJudge($scope,index);
					},
					getJudge : function(){
						awardInfoSupport.getJudge($compile,$scope);
					},
					judgeSearch : function(){
						awardInfoSupport.initJudgeGrid($scope);
					},
					getMember : function(index){
						awardInfoSupport.getMember($compile,$scope,index);
					},
					addMember : function(index){
						awardInfoSupport.addMember($scope,index);
					},
					delMember : function(index){
						awardInfoSupport.delMember($scope,index);
					},
					memberSearch : function(){
						awardInfoSupport.initMemberGrid($scope);
					},
					getAwardOpus : function(index){
						awardInfoSupport.getAwardOpus($compile,$scope,index);
					},
					addAwardOpus : function(index){
						awardInfoSupport.addAwardOpus($scope,index);
					},
					delAwardOpus : function(index){
						awardInfoSupport.delAwardOpus($scope,index);
					},
					awardOpusSearch : function(){
						awardInfoSupport.initOpusGrid($scope);
					},
					getGroup : function(index){
						awardInfoSupport.getGroup($compile,$scope,index);
					},
					addAwardGroup : function(index){
						awardInfoSupport.addAwardGroup($scope,index);
					},
					delAwardGroup : function(index){
						awardInfoSupport.delAwardGroup($scope,index);
					},
					awardGroupSearch : function(){
						awardInfoSupport.initGroupGrid($scope);
					},
					//活动情况
					activityArr : [],
					addActivity : function(){
						activitySupport.addActivity($compile,$scope);
					},
					delActivity : function(index){
						activitySupport.delActivity($scope,index);
					},
					activitySearch : function(){
						activitySupport.initActivityGrid($scope);
					},
					//关联新闻
					newsArr : [],
					getNews : function(){
						newsSupport.getNews($compile,$scope);
					},
					delNews : function(index){
						newsSupport.delNews($scope,index);
					},
					newsSearch : function(){
						newsSupport.initNewsGrid($scope);
					},
					//相关评论
					comments : [],
					getComment : function(){
						commentSupport.getComment($compile,$scope);
					},
					delComment : function(index){
						commentSupport.delComment($scope,index);
					},
					commentSearch : function(){
						commentSupport.initCommentGrid($scope);
					},
					//关联奖节情况
					relAwards : [],
					relSessions : [],
					getRelAward : function(){
						relAwardSupport.getRelAward($compile,$scope);
					},
					delRelAward : function(index){
						relAwardSupport.delRelAward($scope,index);
					},
					relAwardSearch : function(){
						relAwardSupport.initRelAwardGrid($scope);
					},
					getRelSession : function(){
						relAwardSupport.getRelSession($compile,$scope);
					},
					delRelSession : function(index){
						relAwardSupport.delRelSession($scope,index);
					},
					relSessionSearch : function(){
						relAwardSupport.initRelSessionGrid($scope);
					}
			}
		});
		
		support.init($compile,$scope);
		support.initDictData($scope);
		
	};
	
	
	
});