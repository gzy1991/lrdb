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

import cn.org.cflac.lardb.collection.activity.entity.TActivityAddressSiteEntity;
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
public class SiteService {
	// 保存地点信息
	public boolean saveSite(List<TActivityAddressSiteEntity> sites,
			String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

		for (TActivityAddressSiteEntity site : sites) {
			site.setActivityId(activityId);
			try {

				if (SwordStringUtils.isEmpty(site.getActivityAddressId())) {
					site.setActivityAddressId(UUIDUtil.generateUUID());
				}
				dao.saveOrUpdate(site);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	// 删除地点信息
	public boolean deleteSites(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<TActivityAddressSiteEntity> orgSites = querySites(activityId);

		for (TActivityAddressSiteEntity orgSite : orgSites) {
			try {
				dao.delete(orgSite);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	// 查询地点信息
	public List<TActivityAddressSiteEntity> querySites(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_activity_address_site t where t.activity_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(activityId);
		List<TActivityAddressSiteEntity> sites = dao.findAllBySql(
				TActivityAddressSiteEntity.class, sql, sqlParam);
		return sites;
	}
}
