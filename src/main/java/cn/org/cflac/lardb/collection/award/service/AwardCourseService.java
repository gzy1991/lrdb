/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.award.service<br/>  
 * <b>文件名：</b>AwardCourseService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月26日 下午1:04:35<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.award.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import cn.org.cflac.lardb.collection.award.entity.TAwardCourseEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * @description TODO
 * @createTime 2015年10月26日 下午1:04:35
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class AwardCourseService {

	public void saveCourse(List<TAwardCourseEntity> courses , String awardId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<String> sqlParam = new ArrayList<String>();
		String courseIdString = "";
		String sql = "select * from t_award_course t where t.award_id=? and t.invalid='N'";
		sqlParam.add(awardId);
		List<TAwardCourseEntity> originCourses = dao.findAllBySql(TAwardCourseEntity.class, sql, sqlParam);
		
		for(TAwardCourseEntity course : courses){
			course.setAwardId(awardId);
			//保存历程信息
			if(StringHelper.isNotEmpty(course.getCourseId())){
				courseIdString += (course.getCourseId() + " ");
			}
			if(StringHelper.isEmpty(course.getCourseId())){
				course.setCourseId(UUIDUtil.generateUUID());
			}
			dao.saveOrUpdate(course);
		}
		
		for(TAwardCourseEntity originCourse : originCourses){
			if(courseIdString.indexOf(originCourse.getCourseId()) < 0){
				//删除历程信息
				dao.delete(originCourse);
			}
		}
	}
	
	public List<TAwardCourseEntity> queryCourse(String awardId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_award_course t where t.award_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(awardId);
		List<TAwardCourseEntity> courses = dao.findAllBySql(TAwardCourseEntity.class, sql, sqlParam);
		return courses;
	}
	
	
}
