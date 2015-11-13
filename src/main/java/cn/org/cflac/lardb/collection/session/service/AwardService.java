/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>AwardService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午1:57:15<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TYearThAwardEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午1:57:15
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class AwardService {
	
	public void save(List<TYearThAwardEntity> awards,String sessionId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String yearThAwardIds = "";
		String sql = "select * from t_year_th_award t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThAwardEntity> awardList = dao.findAllBySql(TYearThAwardEntity.class, sql, param);//已存在信息
		
		//保存部分
		for(TYearThAwardEntity award : awards){
			award.setYearThId(sessionId);
			if(StringHelper.isEmpty(award.getYearThAwardId())){
				award.setYearThAwardId(UUIDUtil.generateUUID());
			}else{
				yearThAwardIds += (award.getYearThAwardId() + " ");
			}
			dao.saveOrUpdate(award);
		}
		
		//删除部分
		for(TYearThAwardEntity entity : awardList){
			if(yearThAwardIds.indexOf(entity.getYearThAwardId()) < 0){
				dao.delete(entity);
			}
		}
	}
	
	public List<TYearThAwardEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_award t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThAwardEntity> awards = dao.findAllBySql(TYearThAwardEntity.class, sql, param);
		return awards;
	}
	
}
