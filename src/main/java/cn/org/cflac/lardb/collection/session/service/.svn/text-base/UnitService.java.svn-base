/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>UnitService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午3:23:04<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TYearThUnitEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午3:23:04
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class UnitService {
	
	public void save(List<TYearThUnitEntity> units , String sessionId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String yearThUnitIds = "";
		String sql = "select * from t_year_th_unit t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThUnitEntity> unitList = dao.findAllBySql(TYearThUnitEntity.class, sql, param);//已存在信息
		
		//保存部分
		for(TYearThUnitEntity unit : units){
			unit.setYearThId(sessionId);
			if(StringHelper.isEmpty(unit.getYearThUnitId())){
				unit.setYearThUnitId(UUIDUtil.generateUUID());;
			}else{
				yearThUnitIds += (unit.getYearThUnitId() + " ");
			}
			dao.saveOrUpdate(unit);
		}
		
		//删除部分
		for(TYearThUnitEntity entity : unitList){
			if(yearThUnitIds.indexOf(entity.getYearThUnitId()) < 0){
				dao.delete(entity);
			}
		}
	}
	
	public List<TYearThUnitEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_unit t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThUnitEntity> units = dao.findAllBySql(TYearThUnitEntity.class, sql, param);
		return units;
	}
	
}
