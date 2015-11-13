/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.activity.service<br/>  
 * <b>文件名：</b>ActivityInfoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b><br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.activity.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import com.css.sword.utils.SwordStringUtils;

import cn.org.cflac.lardb.collection.activity.entity.TActivityAwardteamAwardlistEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * @description TODO
 * @createTime 2015年10月23日 上午11:24:38
 * @modifyTime
 * @author sunqch@css.com.cn
 * @version 1.0
 */
public class ActAwardTeamAwardlistService {
	@Inject
	private ActAwardTeamListPersionService  awardListPersonService;
	@Inject
	private ActAwardTeamLlistOpusService awardListOpusService;
	@Inject
	private ActAwardTeamListOrganService  awardListOrganService;
	
	
	public boolean saveAwardList(List<TActivityAwardteamAwardlistEntity> actAwardLists,
			String AwardTeamId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		for (TActivityAwardteamAwardlistEntity actAwardList : actAwardLists) {
		      	    actAwardList.setActivityAwardteamId(AwardTeamId);
			try {
				if (SwordStringUtils.isEmpty(actAwardList.getActivityAwardlistId())) {
					actAwardList.setActivityAwardlistId(UUIDUtil.generateUUID());
				}
				dao.saveOrUpdate(actAwardList);
				awardListPersonService.saveAwardListPersion(actAwardList.getAwardlistPerson(), actAwardList.getActivityAwardlistId());
				awardListOpusService.saveAwardListOpus(actAwardList.getAwardlistOpus(), actAwardList.getActivityAwardlistId());
				awardListOrganService.saveAwardListOrgan(actAwardList.getAwardlistOrgan(), actAwardList.getActivityAwardlistId());
			
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public boolean deleteAwardList(String AwardTeamId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<TActivityAwardteamAwardlistEntity> actAwardTeams = queryAwardList(AwardTeamId);
		for (TActivityAwardteamAwardlistEntity actAwardTeam : actAwardTeams) {
			try {
				dao.delete(actAwardTeam);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public List<TActivityAwardteamAwardlistEntity> queryAwardList(String AwardTeamId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_activity_awardteam_awardlist t where t.activity_awardteam_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(AwardTeamId);
		List<TActivityAwardteamAwardlistEntity> actAwardTeam = dao.findAllBySql(
				TActivityAwardteamAwardlistEntity.class, sql, sqlParam);
		return actAwardTeam;
	}

}
