/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>opusService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:32:09<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TYearThOpusEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThOpusGroupingEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:32:09
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class OpusService {
	
	public void save(List<TYearThOpusEntity> opusList , String sessionId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已存在作品信息
		String yearThOpusIds = "";
		String sql = "select * from t_year_th_opus t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThOpusEntity> opusOldList = dao.findAllBySql(TYearThOpusEntity.class, sql, param);
		
		//保存作品信息
		for(TYearThOpusEntity opus : opusList){
			opus.setYearThId(sessionId);
			if(StringHelper.isEmpty(opus.getYearThOpusId())){
				opus.setYearThOpusId(UUIDUtil.generateUUID());
			}else{
				yearThOpusIds += (opus.getYearThOpusId() + " ");
			}
			dao.saveOrUpdate(opus);
			
			//查询已存在的作品分类
			String yearThOpusId = opus.getYearThOpusId();
			String groupIds = "";
			String sql1 = "select * from t_year_th_opus_grouping t where t.year_th_opus_id=?";
			List<String> param1 = new ArrayList<String>();
			param1.add(yearThOpusId);
			List<TYearThOpusGroupingEntity> groupList = dao.findAllBySql(TYearThOpusGroupingEntity.class, sql1, param1);
			
			//保存分类
			List<TYearThOpusGroupingEntity> groups = opus.getOpusTypes();
			for(TYearThOpusGroupingEntity group : groups){
				group.setYearThOpusId(yearThOpusId);
				if(StringHelper.isEmpty(group.getGroupingId())){
					group.setGroupingId(UUIDUtil.generateUUID());
				}else{
					groupIds += (group.getGroupingId() + " ");
				}
				dao.saveOrUpdate(group);
			}
			//删除分类
			for(TYearThOpusGroupingEntity entity : groupList){
				if(groupIds.indexOf(entity.getGroupingId()) < 0){
					dao.delete(entity);
				}
			}
		}
		
		//删除作品信息
		for(TYearThOpusEntity opusEntity : opusOldList){
			if(yearThOpusIds.indexOf(opusEntity.getYearThOpusId()) < 0){
				String sql2 = "select * from t_year_th_opus_grouping t where t.year_th_opus_id=?";
				List<String> param2 = new ArrayList<String>();
				param2.add(opusEntity.getYearThOpusId());
				List<TYearThOpusGroupingEntity> delGroups = dao.findAllBySql(TYearThOpusGroupingEntity.class, sql2, param2);
				dao.delete(opusEntity);
				dao.deleteBatch(delGroups);
			}
		}
	}
	
	public List<TYearThOpusEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_opus t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThOpusEntity> opus = dao.findAllBySql(TYearThOpusEntity.class, sql, param);
		
		for(TYearThOpusEntity entity : opus){
			String id = entity.getYearThOpusId();
			String sql1 = "select * from t_year_th_opus_grouping t where t.year_th_opus_id=?";
			List<String> param1 = new ArrayList<String>();
			param1.add(id);
			List<TYearThOpusGroupingEntity> groups = dao.findAllBySql(TYearThOpusGroupingEntity.class, sql1, param1);
			entity.setOpusTypes(groups);
			entity.setOpusName("opusName");
		}
		
		return opus;
	}
	
}
