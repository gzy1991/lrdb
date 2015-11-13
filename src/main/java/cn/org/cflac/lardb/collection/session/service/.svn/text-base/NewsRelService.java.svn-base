/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>NewsRelService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:33:40<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TYearThNewsRelEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:33:40
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class NewsRelService {

	public void save(List<TYearThNewsRelEntity> news , String sessionId) throws SwordBaseCheckedException{
		
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已存在的关联新闻
		String yearThNewsIds = "";
		String sql = "select * from t_year_th_news_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThNewsRelEntity> newsList = dao.findAllBySql(TYearThNewsRelEntity.class, sql, param);
		
		//保存
		for(TYearThNewsRelEntity newsEntity : news){
			newsEntity.setYearThId(sessionId);
			if(StringHelper.isEmpty(newsEntity.getTYearThNewsId())){
				newsEntity.setTYearThNewsId(UUIDUtil.generateUUID());
			}else{
				yearThNewsIds += (newsEntity.getTYearThNewsId() + " ");
			}
			dao.saveOrUpdate(newsEntity);
		}
		
		//删除
		for(TYearThNewsRelEntity delEntity : newsList){
			if(yearThNewsIds.indexOf(delEntity.getTYearThNewsId()) < 0){
				dao.delete(delEntity);
			}
		}
	}
	
	public List<TYearThNewsRelEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_news_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThNewsRelEntity> newsList = dao.findAllBySql(TYearThNewsRelEntity.class, sql, param);
		return newsList;
	}
	
}
