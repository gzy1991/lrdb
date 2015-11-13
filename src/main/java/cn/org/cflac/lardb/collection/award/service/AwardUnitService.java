/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.award.service<br/>  
 * <b>文件名：</b>AwardUnitService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月26日 上午11:13:33<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.award.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import cn.org.cflac.lardb.collection.award.entity.TAwardUnitEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * @description TODO
 * @createTime 2015年10月26日 上午11:13:33
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class AwardUnitService {

	public void saveUnits(List<TAwardUnitEntity> units , String awardId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<String> sqlParam = new ArrayList<String>();
		String unitIdString = "";
		String sql = "select * from t_award_unit t where t.award_id=? and t.invalid='N'";
		sqlParam.add(awardId);
		List<TAwardUnitEntity> orgUnits = dao.findAllBySql(TAwardUnitEntity.class, sql, sqlParam);
		
		for(TAwardUnitEntity unit : units){
			unit.setAwardId(awardId);
			try {
				//保存单位信息
				if(StringHelper.isNotEmpty(unit.getAwardUnitId())){
					unitIdString += (unit.getAwardUnitId() + " ");
				}
				if(StringHelper.isEmpty(unit.getAwardUnitId())){
					unit.setAwardUnitId(UUIDUtil.generateUUID());
				}
				dao.saveOrUpdate(unit);
			} catch (SwordBaseCheckedException e) {
				e.printStackTrace();
			}
		}
		
		for(TAwardUnitEntity orgUnit : orgUnits){
			if(unitIdString.indexOf(orgUnit.getAwardUnitId()) < 0){
				try {
					//删除单位信息
					dao.delete(orgUnit);
				} catch (SwordBaseCheckedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public List<TAwardUnitEntity> queryUnit(String awardId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_award_unit t where t.award_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(awardId);
		List<TAwardUnitEntity> units = dao.findAllBySql(TAwardUnitEntity.class, sql, sqlParam);
		return units;
	}
	
	
}
