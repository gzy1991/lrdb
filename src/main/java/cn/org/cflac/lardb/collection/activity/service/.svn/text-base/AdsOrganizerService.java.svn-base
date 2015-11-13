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
import cn.org.cflac.lardb.collection.activity.entity.TActivityAddressOrganizerEntity;
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
public class AdsOrganizerService {
	
	// 保存承办单位信息
	public boolean saveAdsOrganizer(List<TActivityAddressOrganizerEntity> adsOrganizers,
			String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

		for (TActivityAddressOrganizerEntity adsOrganizer : adsOrganizers) {
			adsOrganizer.setActivityId(activityId);
			try {

				if (SwordStringUtils.isEmpty(adsOrganizer.getActivityAddressOrganizerId())) {
					adsOrganizer.setActivityAddressOrganizerId(UUIDUtil.generateUUID());
				}
				dao.saveOrUpdate(adsOrganizer);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	// 删除承办单位信息
	public boolean deleteAdsOrganizer(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<TActivityAddressOrganizerEntity> adsOrganizers = queryAdsOrganizer(activityId);

		for (TActivityAddressOrganizerEntity adsOrganizer : adsOrganizers) {
			try {
				dao.delete(adsOrganizer);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	// 查询承办单位信息
	public List<TActivityAddressOrganizerEntity> queryAdsOrganizer(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_activity_address_organizer t where t.activity_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(activityId);
		List<TActivityAddressOrganizerEntity> sdsOrganizer = dao.findAllBySql(
				TActivityAddressOrganizerEntity.class, sql, sqlParam);
		return sdsOrganizer;
	}

}
