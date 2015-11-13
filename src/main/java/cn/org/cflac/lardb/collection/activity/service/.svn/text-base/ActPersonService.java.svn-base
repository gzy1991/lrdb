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

import com.css.sword.utils.SwordStringUtils;
import cn.org.cflac.lardb.collection.activity.entity.TActivityPersonEntity;
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
public class ActPersonService {

	public boolean savePerson(List<TActivityPersonEntity> actPersons,
			String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

		for (TActivityPersonEntity actPerson : actPersons) {
			actPerson.setActivityId(activityId);
			try {

				if (SwordStringUtils.isEmpty(actPerson.getActivityPersionId())) {
					actPerson.setActivityPersionId(UUIDUtil.generateUUID());
				}
				dao.saveOrUpdate(actPerson);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public boolean deletePerson(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<TActivityPersonEntity> actPersions = queryPersons(activityId);

		for (TActivityPersonEntity actPersion : actPersions) {
			try {
				dao.delete(actPersion);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public List<TActivityPersonEntity> queryPersons(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_activity_person t where t.activity_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(activityId);
		List<TActivityPersonEntity> actPerson = dao.findAllBySql(
				TActivityPersonEntity.class, sql, sqlParam);
		return actPerson;
	}
}

