/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>AwardRelService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:34:28<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import cn.org.cflac.lardb.collection.session.entity.TYearThAwardRelEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:34:28
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class AwardRelService {

	public void save(List<TYearThAwardRelEntity> awardRels , String sessionId) throws SwordBaseCheckedException{
		
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已存在关联奖节code
		String sql = "select * from t_year_th_award_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThAwardRelEntity> awardRelList = dao.findAllBySql(TYearThAwardRelEntity.class, sql, param);
		
		//保存关联奖节
		for(TYearThAwardRelEntity awardRel : awardRels){
			awardRel.setYearThId(sessionId);
			awardRel.setTYearThAwardId(UUIDUtil.generateUUID());
			dao.saveOrUpdate(awardRel);
		}
		//删除关联奖节
		dao.deleteBatch(awardRelList);
		
	}
	
	public List<TYearThAwardRelEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_award_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThAwardRelEntity> awardRels = dao.findAllBySql(TYearThAwardRelEntity.class, sql, param);
		return awardRels;
	}
	
}
