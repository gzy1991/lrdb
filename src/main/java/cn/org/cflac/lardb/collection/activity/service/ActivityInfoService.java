/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.activity.service<br/>  
 * <b>文件名：</b>ActivityInfoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 上午11:24:38<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.activity.service;

/**
 * @description TODO
 * @createTime 2015年10月22日 上午11:24:38
 * @modifyTime 
 * @author sunqch@css.com.cn
 * @version 1.0
 */
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import cn.org.cflac.lardb.collection.activity.entity.TActivityInfoEntity;
import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
/*import com.css.sword.common.org.api.SwordOrgUtils;*/
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.SwordStringUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.components.grid.Page;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;

/**
 * @author sunqch
 *
 */
@ServiceContainer("activityInfoService")
public class ActivityInfoService {

	@Inject
	private SiteService siteService;
	@Inject
	private AdsSponsorService sponsorService;
	@Inject
	private AdsOrganizerService organizerService;
	@Inject
	private AdsCoOrganizerService coOrganService;	
	@Inject
	private ActPersonService personService;	
	@Inject
	private ActOpusService  opusService;
	@Inject
	private ActNewService  newService;	
	@Inject
	private ActJudgeService  judgeService;	
	@Inject
	private ActFestivalAwardService  festivalAwardService;
    @Inject
	private ActAwardTeamService  awardTeamService;
/*	@Inject
	private ActAwardTeamAwardlistService  awardList;
	@Inject
	private ActAwardTeamListPersionService  awardListPersonService;
	@Inject
	private ActAwardTeamLlistOpusService awardListOpusService;
	@Inject
	private ActAwardTeamListOrganService  awardListOrganService;*/

	private static final SwordLogUtils logger = SwordLogUtils
			.getLogger(ActivityInfoService.class);

	/* 获取艺术家列表数据 */
	@Service("getActivityInfoList")
	public ISwordResponse getActivityInfoList(ISwordRequest iReq) {
		String activityName = iReq.getData("activityName");
		String artTypeDict = iReq.getData("actArtType");
		String activityType = iReq.getData("activityType");
		String beginData = iReq.getData("beginData");
		String endData = iReq.getData("endData");
		List<TActivityInfoEntity> activityList = new ArrayList<TActivityInfoEntity>();
		List<String> paramList = new ArrayList<String>();// sql参数
		String sql = "select * from t_activity_info a where a.invalid = 'N'";
		if (!SwordStringUtils.isEmpty(activityName)) {
			sql += "and a.activity_name like ?";
			paramList.add("%" + activityName + "%");
		}
		if (!SwordStringUtils.isEmpty(artTypeDict)) {
			sql += "and a.arttype_dict like ? \n";
			paramList.add("%" + artTypeDict + "%");
		}
		if (!SwordStringUtils.isEmpty(activityType)) {
			sql += "and a.acttype_dict like ?  \n";
			paramList.add("%" + activityType + "%");
		}
		if (!SwordStringUtils.isEmpty(beginData)
				&& !SwordStringUtils.isEmpty(endData)) {
			sql += "and a.activity_begin_date  between  ?  and  ? \n";
			paramList.add("%" + beginData + "%");
			paramList.add("%" + endData + "%");
		}
		sql += "order by a.lastmodify_time desc";
		JSONObject data = new JSONObject();
		try {
			data = new Page(iReq).getData(TActivityInfoEntity.class, sql,
					paramList.toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		activityList = (List<TActivityInfoEntity>) data.get("curPageData");
		return new ResultData.Builder<TActivityInfoEntity>().setRows(
				activityList).build();
	}

	@Service("saveActivityInfo")
	public ISwordResponse saveActivityInfo(ISwordRequest iReq)
			throws SwordBaseCheckedException {

		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

		String reqInfo = iReq.getData("activityInfo");
		TActivityInfoEntity activityInfo = JSON.parseObject(
				iReq.getData("activityInfo"), TActivityInfoEntity.class);
	

		// 基本信息保存
		if (SwordStringUtils.isEmpty(activityInfo.getActivityId())) {
			activityInfo.setActivityId(UUIDUtil.generateUUID());
		}
		dao.saveOrUpdate(activityInfo);
		// 处理及保存关联信息
		String activityId = activityInfo.getActivityId();
		

		// 保存site信息
		siteService.saveSite(activityInfo.getSiteList(), activityId);
		sponsorService.saveAdsSponsor(activityInfo.getSponsorList(), activityId);
		organizerService.saveAdsOrganizer(activityInfo.getOrganizerList(), activityId);
		coOrganService.saveAdsCoOrganizer(activityInfo.getCoOrganizerList(), activityId);
		personService.savePerson(activityInfo.getPersionList(), activityId);
		opusService.saveOpus(activityInfo.getOpusNameList(), activityId);
		newService.saveNew(activityInfo.getNewsList(), activityId);
		judgeService.saveJudge(activityInfo.getJudgeList(), activityId);
		festivalAwardService.saveFestivalAward(activityInfo.getFestivalawardList(), activityId);
		/*awardTeamService.saveAwardTeam(activityInfo.getAwardTeamList(), activityId);*/
	
	/*	awardList.saveAwardList(activityInfo.getAwardTeamList(), AwardteamId);
		awardListPersonService.saveAwardListPersion(activityInfo.getAwardListPerson(), AwardListId);
		awardListOpusService.saveAwardListOpus(activityInfo.getAwardListOpus(), AwardListId);
		awardListOrganService.saveAwardListOrgan(activityInfo.getAwardListOrgan(), AwardListId)*/
		
		
		return new ResultData.Builder<TActivityInfoEntity>().setEntity(activityInfo).build();
	}

	@Service("queryActivityInfoById")
	public ISwordResponse queryActivityInfoById(ISwordRequest iReq)
			throws SwordBaseCheckedException {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String activityId = iReq.getData("activityId");
		String sql = "select * from  t_activity_info  t  where t.activity_id = ?";
		List<TActivityInfoEntity> activityInfoList = dao.findAllBySql(
				TActivityInfoEntity.class, sql, activityId);

		return new ResultData.Builder<TActivityInfoEntity>().setRows(
				activityInfoList).build();
	}

	/**
	 * @param iReq
	 * @return
	 * @throws SwordBaseCheckedException
	 */
	@Service("delActivityInfoByIds")
	public ISwordResponse delActivityInfoByIds(ISwordRequest iReq)
			throws SwordBaseCheckedException {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String activityIds = iReq.getData("activityIds");
		// String sql =
		// "delete  from  t_activity_info  t  where t.activity_id = ?";
		String[] activityIdsList = activityIds.split(",");

		if (activityIdsList.length > 0) {
			for (String activityId : activityIdsList) {
				dao.deleteByprimaryKey(TActivityInfoEntity.class, activityId);
			}
		}
		return new ResultData.Builder<TActivityInfoEntity>().build();
	}
}
