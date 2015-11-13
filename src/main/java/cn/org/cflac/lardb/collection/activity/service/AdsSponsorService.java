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
import cn.org.cflac.lardb.collection.activity.entity.TActivityAddressSponsorEntity;
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
public class AdsSponsorService {

	// 保存主办单位信息
	public boolean saveAdsSponsor(
			List<TActivityAddressSponsorEntity> adsSponsors, String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

		for (TActivityAddressSponsorEntity adsSponsor : adsSponsors) {
			adsSponsor.setActivityId(activityId);
			try {

				if (SwordStringUtils.isEmpty(adsSponsor
						.getActivityAddressSponsorId())) {
					adsSponsor.setActivityAddressSponsorId(UUIDUtil
							.generateUUID());
				}
				dao.saveOrUpdate(adsSponsor);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	// 删除主办单位信息
	public boolean deleteAdsSponsor(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<TActivityAddressSponsorEntity> adsSponsors = queryAdsSponsor(activityId);

		for (TActivityAddressSponsorEntity adsSponsor : adsSponsors) {
			try {
				dao.delete(adsSponsor);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	// 查询主办单位信息
	public List<TActivityAddressSponsorEntity> queryAdsSponsor(String activityId) {
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_activity_address_sponsor t where t.activity_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(activityId);
		List<TActivityAddressSponsorEntity> sdsSponsor = dao.findAllBySql(
				TActivityAddressSponsorEntity.class, sql, sqlParam);
		return sdsSponsor;
	}
}
