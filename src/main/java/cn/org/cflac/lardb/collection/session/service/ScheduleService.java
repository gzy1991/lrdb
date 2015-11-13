/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>ScheduleService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午3:36:30<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TYearThScheduleEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThScheduleGroupingEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午3:36:30
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class ScheduleService {
	
	public void save(List<TYearThScheduleGroupingEntity> scheduleGroups , String sessionId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已存在分组信息
		String scheduleGroupIds = "";
		String sql = "select * from t_year_th_schedule_grouping t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThScheduleGroupingEntity> scheduleGroupList = dao.findAllBySql(TYearThScheduleGroupingEntity.class, sql, param);
		
		//保存分组
		for(TYearThScheduleGroupingEntity scheduleGroup : scheduleGroups){
			scheduleGroup.setYearThId(sessionId);
			if(StringHelper.isEmpty(scheduleGroup.getScheduleGroupingId())){
				scheduleGroup.setScheduleGroupingId(UUIDUtil.generateUUID());
			}else{
				scheduleGroupIds += (scheduleGroup.getScheduleGroupingId() + " ");
			}
			dao.saveOrUpdate(scheduleGroup);
			String scheduleGroupId = scheduleGroup.getScheduleGroupingId();
			
			//查询已存在日程信息
			String scheduleIds = "";
			String sql1 = "select * from t_year_th_schedule t where t.grouping_id=? and t.invalid='N'";
			List<String> param1 = new ArrayList<String>();
			param1.add(scheduleGroupId);
			List<TYearThScheduleEntity> scheduleList = dao.findAllBySql(TYearThScheduleEntity.class, sql1, param1);
			
			//保存及删除该分组下的日程信息
			List<TYearThScheduleEntity> schedules = scheduleGroup.getSchedules();
			for(TYearThScheduleEntity schedule : schedules){
				schedule.setGroupingId(scheduleGroupId);
				if(StringHelper.isEmpty(schedule.getScheduleId())){
					schedule.setScheduleId(UUIDUtil.generateUUID());
				}else{
					scheduleIds += (schedule.getScheduleId() + " ");
				}
				dao.saveOrUpdate(schedule);
			}
			for(TYearThScheduleEntity entity : scheduleList){
				if(scheduleIds.indexOf(entity.getScheduleId()) < 0){
					dao.delete(entity);
				}
			}
		}
		
		//删除不需要的分组
		for(TYearThScheduleGroupingEntity groupEntity : scheduleGroupList){
			if(scheduleGroupIds.indexOf(groupEntity.getScheduleGroupingId()) < 0){
				String sql2 = "select * from t_year_th_schedule t where t.grouping_id=? and t.invalid='N'";
				List<String> param2 = new ArrayList<String>();
				param2.add(groupEntity.getScheduleGroupingId());
				List<TYearThScheduleEntity> scheduleList = dao.findAllBySql(TYearThScheduleEntity.class, sql2, param2);
				dao.delete(groupEntity);
				dao.deleteBatch(scheduleList);
			}
		}
	}
	
	public List<TYearThScheduleGroupingEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_schedule_grouping t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThScheduleGroupingEntity> groups = dao.findAllBySql(TYearThScheduleGroupingEntity.class, sql, param);
		for(TYearThScheduleGroupingEntity group : groups){
			String groupId = group.getScheduleGroupingId();
			String sql1 = "select * from t_year_th_schedule t where t.grouping_id=? and t.invalid='N'";
			List<String> param1 = new ArrayList<String>();
			param1.add(groupId);
			List<TYearThScheduleEntity> schedules = dao.findAllBySql(TYearThScheduleEntity.class, sql1, param1);
			group.setSchedules(schedules);
		}
		return groups;
	}
	
}
