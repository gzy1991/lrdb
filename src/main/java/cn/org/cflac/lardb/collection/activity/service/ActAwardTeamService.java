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
import cn.org.cflac.lardb.collection.activity.entity.TActivityAwardteamEntity;
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
public class ActAwardTeamService {
	@Inject
	private ActAwardTeamAwardlistService  awardList;
	public boolean saveAwardTeam(List<TActivityAwardteamEntity> actAwardTeams,
			String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		for (TActivityAwardteamEntity actAwardTeam : actAwardTeams) {
			actAwardTeam.setActivityId(activityId);
			try {
				if (SwordStringUtils.isEmpty(actAwardTeam.getActivityAwardteamId())) {
					actAwardTeam.setActivityAwardteamId(UUIDUtil.generateUUID());
				}
				dao.saveOrUpdate(actAwardTeam);
				awardList.saveAwardList(actAwardTeam.getAwardlist(), actAwardTeam.getActivityAwardteamId());
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}	
		}
		return true;
	}

	public boolean deleteAwardTeam(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<TActivityAwardteamEntity> actAwardTeams = queryAwardTeam(activityId);
		for (TActivityAwardteamEntity actAwardTeam : actAwardTeams) {
			try {
				dao.delete(actAwardTeam);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public List<TActivityAwardteamEntity> queryAwardTeam(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_activity_awardteam t where t.activity_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(activityId);
		List<TActivityAwardteamEntity> actJudges = dao.findAllBySql(
				TActivityAwardteamEntity.class, sql, sqlParam);
		return actJudges;
	}

}
