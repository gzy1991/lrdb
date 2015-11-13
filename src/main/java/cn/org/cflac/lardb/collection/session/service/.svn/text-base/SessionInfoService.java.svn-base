/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>SessionInfoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 上午9:57:50<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.hibernate.annotations.common.util.StringHelper;

import cn.org.cflac.lardb.collection.activity.entity.TActivityInfoEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThActivityRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThAwardEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThAwardRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThCommentRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThInfoEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThJudgeEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThNewsRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThOpusEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThOthersRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThScheduleGroupingEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThUnitEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThWinnersGroupingEntity;
import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.web.components.grid.Page;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;

/**
 * @description TODO
 * @createTime 2015年10月28日 上午9:57:50
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
@ServiceContainer("sessionInfoService")
public class SessionInfoService {
	
	@Inject
	private AwardService awardService;
	@Inject
	private UnitService unitService;
	@Inject
	private ScheduleService scheduleService;
	@Inject
	private OpusService opusService;
	@Inject
	private JudgeService judgeService;
	@Inject
	private WinnersService winnersService;
	@Inject
	private ActivityRelService activityRelService;
	@Inject
	private NewsRelService newsRelService;
	@Inject
	private CommentRelService commentRelService;
	@Inject
	private AwardRelService awardRelService;
	@Inject
	private SessionRelService sessionRelService;
	
	@Service("save")
	public ISwordResponse save(ISwordRequest req) throws SwordBaseCheckedException{
		
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sessionInfo = req.getData("sessionInfo");
		TYearThInfoEntity session = JSON.parseObject(sessionInfo, TYearThInfoEntity.class);
		
		if(StringHelper.isEmpty(session.getYearThId())){
			session.setYearThId(UUIDUtil.generateUUID());
		}
		dao.saveOrUpdate(session);
		
		String sessionId = session.getYearThId();
		
		//基本奖节届次表
		awardService.save(session.getAwards(), sessionId);
		//主办、承办、协办单位信息
		unitService.save(session.getUnits(), sessionId);
		//日程信息
		scheduleService.save(session.getScheduleGroups(), sessionId);
		//作品信息
		opusService.save(session.getOpusList(), sessionId);
		//评委信息
		judgeService.save(session.getJudges(), sessionId);
		//获奖信息
		winnersService.save(session.getWinnerGroups(), sessionId);
		//活动关联
		activityRelService.save(session.getActivityList(), sessionId);
		//新闻关联
		newsRelService.save(session.getNewsList(), sessionId);
		//评论关联
		commentRelService.save(session.getComments(), sessionId);
		//奖节关联
		awardRelService.save(session.getAwardRels(), sessionId);
		//届次关联
		sessionRelService.save(session.getSessions(), sessionId);
		
		return new ResultData.Builder<TYearThInfoEntity>().setEntity(session).build();
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Service("search")
	public ISwordResponse search(ISwordRequest req) throws Exception{
		
		String title = req.getData("title");
		String arttype = req.getData("arttype");
		String awardCode = req.getData("awardCode");
		String yearMin = req.getData("yearMin");
		String yearMax = req.getData("yearMax");
		String timeMin = req.getData("timeMin");
		String timeMax = req.getData("timeMax");
		
		String sql = "select distinct t.* from t_year_th_info t where t.invalid='N' ";
		int index = sql.indexOf("where");
		String insertSql = ",t_year_th_award a ";
		String insertWhere = " and t.year_th_id=a.year_th_id ";
		List<String> param = new ArrayList<String>();
		
		if(StringHelper.isNotEmpty(title)){
			sql += " and t.year_th_title like ? ";
			param.add("%" + title + "%");
		}
		
		if(StringHelper.isNotEmpty(arttype)){
			sql += " and t.art_type_dict=? ";
			param.add(arttype);
		}
		
		if(StringHelper.isNotEmpty(awardCode)){
			//查出子节点的code
			
			//拼接sql
			if(sql.indexOf(insertSql) < 0){
				sql = sql.substring(0, index) + insertSql + sql.substring(index, sql.length());
			}
			sql += " and a.year_th_id=t.year_th_id and a.award_code in ? ";
			if(sql.indexOf(insertWhere) < 0){
				sql += insertWhere;
			}
			param.add(awardCode);
		}
		
		if(StringHelper.isNotEmpty(yearMin)){
			if(sql.indexOf(insertSql) < 0){
				sql = sql.substring(0, index) + insertSql + sql.substring(index, sql.length());
			}
			sql += " and a.award_year >= ? ";
			if(sql.indexOf(insertWhere) < 0){
				sql += insertWhere;
			}
			param.add(yearMin);
		}
		
		if(StringHelper.isNotEmpty(yearMax)){
			if(sql.indexOf(insertSql) < 0){
				sql = sql.substring(0, index) + insertSql + sql.substring(index, sql.length());
			}
			sql += " and a.award_year <= ? ";
			if(sql.indexOf(insertWhere) < 0){
				sql += insertWhere;
			}
			param.add(yearMax);
		}
		
		if(StringHelper.isNotEmpty(timeMin)){
			if(sql.indexOf(insertSql) < 0){
				sql = sql.substring(0, index) + insertSql + sql.substring(index, sql.length());
			}
			sql += " and a.award_year_th >= ? ";
			if(sql.indexOf(insertWhere) < 0){
				sql += insertWhere;
			}
			param.add(timeMin);
		}
		
		if(StringHelper.isNotEmpty(timeMax)){
			if(sql.indexOf(insertSql) < 0){
				sql = sql.substring(0, index) + insertSql + sql.substring(index, sql.length());
			}
			sql += " and a.award_year_th <= ? ";
			if(sql.indexOf(insertWhere) < 0){
				sql += insertWhere;
			}
			param.add(timeMax);
		}
		
		JSONObject data = new JSONObject();
		data = new Page(req).getData(TYearThInfoEntity.class,sql,param.toArray());
		List<TYearThInfoEntity> yearThInfos = (List<TYearThInfoEntity>) data.get("curPageData");
		for(TYearThInfoEntity yearTh : yearThInfos){
			List<TYearThAwardEntity> awards = awardService.query(yearTh.getYearThId());
			yearTh.setYearThInfo(yearThToString(awards));
		}
		Long total = Long.parseLong(data.get("allDataCount").toString());
		
		return new ResultData.Builder<TYearThInfoEntity>().setRows(yearThInfos).setTotal(total).build();
	}
	
	@Service("query")
	public ISwordResponse query(ISwordRequest req){
		String yearThId = req.getData("yearThId");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		TYearThInfoEntity yearTh = dao.findOneByPrimaryKey(TYearThInfoEntity.class, yearThId);
		
		//主办、承办、协办单位信息
		List<TYearThUnitEntity> units = unitService.query(yearThId);
		//奖节届次信息
		List<TYearThAwardEntity> awards = awardService.query(yearThId);
		//日程信息
		List<TYearThScheduleGroupingEntity> groups = scheduleService.query(yearThId);
		//作品信息
		List<TYearThOpusEntity> opus = opusService.query(yearThId);
		//评委信息
		List<TYearThJudgeEntity> judges = judgeService.query(yearThId);
		//获奖信息
		List<TYearThWinnersGroupingEntity> winnerGroups = winnersService.query(yearThId);
		//活动关联
		List<TYearThActivityRelEntity> activities = activityRelService.query(yearThId);
		for(TYearThActivityRelEntity rel : activities){
			TActivityInfoEntity activity =  dao.findOneByPrimaryKey(TActivityInfoEntity.class, rel.getActivityId());
			rel.setActivityBeginDate(activity.getActivityBeginDate());
			rel.setActivityEndDate(activity.getActivityEndDate());
			rel.setActivityName(activity.getActivityName());
		}
		//新闻关联
		List<TYearThNewsRelEntity> news = newsRelService.query(yearThId);
		//评论关联
		List<TYearThCommentRelEntity> comments = commentRelService.query(yearThId);
		//奖节关联
		List<TYearThAwardRelEntity> awardRels = awardRelService.query(yearThId);
		//届次关联
		List<TYearThOthersRelEntity> others = sessionRelService.query(yearThId);
		for(TYearThOthersRelEntity other : others){
			List<TYearThAwardEntity> awardList = awardService.query(yearTh.getYearThId());
			other.setYearThInfo(yearThToString(awardList));
			TYearThInfoEntity entity = dao.findOneByPrimaryKey(TYearThInfoEntity.class, other.getOthersId());
			other.setYearThTitle(entity.getYearThTitle());
		}
		
		yearTh.setUnits(units);
		yearTh.setAwards(awards);
		yearTh.setScheduleGroups(groups);
		yearTh.setOpusList(opus);
		yearTh.setJudges(judges);
		yearTh.setWinnerGroups(winnerGroups);
		yearTh.setActivityList(activities);
		yearTh.setNewsList(news);
		yearTh.setComments(comments);
		yearTh.setAwardRels(awardRels);
		yearTh.setSessions(others);
		
		return new ResultData.Builder<TYearThInfoEntity>().setEntity(yearTh).build();
	}
	
	@Service("delete")
	public ISwordResponse delete(ISwordRequest req) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String yearThIds = req.getData("yearThIds");
		String[] yearThIdArr = yearThIds.split(",");
		for(String id : yearThIdArr){
			//基本奖节届次表
			awardService.save(new ArrayList<TYearThAwardEntity>(), id);
			//主办、承办、协办单位信息
			unitService.save(new ArrayList<TYearThUnitEntity>(), id);
			//日程信息
			scheduleService.save(new ArrayList<TYearThScheduleGroupingEntity>(), id);
			//作品信息
			opusService.save(new ArrayList<TYearThOpusEntity>(), id);
			//评委信息
			judgeService.save(new ArrayList<TYearThJudgeEntity>(), id);
			//获奖信息
			winnersService.save(new ArrayList<TYearThWinnersGroupingEntity>(), id);
			//活动关联
			activityRelService.save(new ArrayList<TYearThActivityRelEntity>(), id);
			//新闻关联
			newsRelService.save(new ArrayList<TYearThNewsRelEntity>(), id);
			//评论关联
			commentRelService.save(new ArrayList<TYearThCommentRelEntity>(), id);
			//奖节关联
			awardRelService.save(new ArrayList<TYearThAwardRelEntity>(), id);
			//届次关联
			sessionRelService.save(new ArrayList<TYearThOthersRelEntity>(), id);
			
			//删除主表
			dao.deleteByprimaryKey(TYearThInfoEntity.class, id);
		}
		return new ResultData.Builder<TYearThInfoEntity>().build();
	}
	
	private String yearThToString(List<TYearThAwardEntity> awards){
		String str = "";
		for(TYearThAwardEntity award : awards){
			str = str + " " + award.getAwardYear() + "年第" + award.getAwardYearTh() + "次" + award.getAwardCode();
		}
		return str;
	}
	
}
