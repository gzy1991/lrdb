/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>JudgeService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:32:26<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import cn.org.cflac.lardb.collection.session.entity.TYearThJudgeEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:32:26
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class JudgeService {

	public void save(List<TYearThJudgeEntity> judges , String sessionId) throws SwordBaseCheckedException{
		
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已有的评委信息
		String yearThJudgeIds = "";
		String sql = "select * from t_year_th_judge t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThJudgeEntity> judgeList = dao.findAllBySql(TYearThJudgeEntity.class, sql, param);
		
		//保存评委信息
		for(TYearThJudgeEntity judge : judges){
			judge.setYearThId(sessionId);
			if(StringHelper.isEmpty(judge.getYearThJudgeId())){
				judge.setYearThJudgeId(UUIDUtil.generateUUID());
			}else{
				yearThJudgeIds += (judge.getYearThJudgeId() + " ");
			}
			dao.saveOrUpdate(judge);
		}
		//删除评委信息
		for(TYearThJudgeEntity entity : judgeList){
			if(yearThJudgeIds.indexOf(entity.getYearThJudgeId()) < 0){
				dao.delete(entity);
			}
		}
		
	}
	
	public List<TYearThJudgeEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_judge t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThJudgeEntity> judges = dao.findAllBySql(TYearThJudgeEntity.class, sql, param);
		return judges;
	}
	
}
