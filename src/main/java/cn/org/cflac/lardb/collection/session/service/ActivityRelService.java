/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>ActivityRelService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:33:26<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TYearThActivityRelEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:33:26
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class ActivityRelService {

	public void save(List<TYearThActivityRelEntity> activities , String sessionId) throws SwordBaseCheckedException{
		
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已存在的关联关系
		String yearThActivityIds = "";
		String sql = "select * from t_year_th_activity_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThActivityRelEntity> activityList = dao.findAllBySql(TYearThActivityRelEntity.class, sql, param);
		
		//保存关联活动
		for(TYearThActivityRelEntity activity : activities){
			activity.setYearThId(sessionId);
			if(StringHelper.isEmpty(activity.getYearThActivityId())){
				activity.setYearThActivityId(UUIDUtil.generateUUID());
			}else{
				yearThActivityIds += (activity.getYearThActivityId() + " ");
			}
			dao.saveOrUpdate(activity);
		}
		//删除关联活动
		for(TYearThActivityRelEntity delEntity : activityList){
			if(yearThActivityIds.indexOf(delEntity.getYearThActivityId()) < 0){
				dao.delete(delEntity);
			}
		}
		
	}
	
	public List<TYearThActivityRelEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_activity_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThActivityRelEntity> activities = dao.findAllBySql(TYearThActivityRelEntity.class, sql, param);
		return activities;
	}
	
}
