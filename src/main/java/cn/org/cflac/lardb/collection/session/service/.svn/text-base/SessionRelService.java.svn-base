/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>SessionRelService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:34:40<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import cn.org.cflac.lardb.collection.session.entity.TYearThOthersRelEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:34:40
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class SessionRelService {

	public void save(List<TYearThOthersRelEntity> others , String sessionId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已存在关联届次
		String yearThOthersIds = "";
		String sql = "select * from t_year_th_others_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThOthersRelEntity> othersList = dao.findAllBySql(TYearThOthersRelEntity.class, sql, param);
		
		//保存关联届次
		for(TYearThOthersRelEntity other : others){
			other.setYearThId(sessionId);
			if(StringHelper.isEmpty(other.getTYearThOthersId())){
				other.setTYearThOthersId(UUIDUtil.generateUUID());
			}else{
				yearThOthersIds += (other.getTYearThOthersId() + " ");
			}
			dao.saveOrUpdate(other);
		}
		//删除关联届次
		for(TYearThOthersRelEntity entity : othersList){
			if(yearThOthersIds.indexOf(entity.getTYearThOthersId()) < 0){
				dao.delete(entity);
			}
		}
	}
	
	public List<TYearThOthersRelEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_others_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThOthersRelEntity> others = dao.findAllBySql(TYearThOthersRelEntity.class, sql, param);
		return others;
	}
	
}
