/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.award.service<br/>  
 * <b>文件名：</b>awardInfoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月22日 下午5:06:14<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.award.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.hibernate.annotations.common.util.StringHelper;

import cn.org.cflac.lardb.collection.award.entity.TAwardCourseEntity;
import cn.org.cflac.lardb.collection.award.entity.TAwardInfoEntity;
import cn.org.cflac.lardb.collection.award.entity.TAwardIntroductionEntity;
import cn.org.cflac.lardb.collection.award.entity.TAwardUnitEntity;
import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.web.components.grid.Page;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;

/**
 * @description TODO
 * @createTime 2015年10月22日 下午5:06:14
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
@ServiceContainer("awardInfoService")
public class AwardInfoService {
	
	@Inject
	private AwardUnitService unitService;
	@Inject
	private AwardCourseService courseService;
	@Inject
	private AwardIntroductionService introService;
	
	@Service("saveAwardInfo")
	public ISwordResponse saveAwardInfo(ISwordRequest req) throws SwordBaseCheckedException{
		
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		
		String reqString = req.getData("awardInfo");
		
		TAwardInfoEntity award = JSON.parseObject(reqString, TAwardInfoEntity.class);
		
		// 基本信息保存
		if(StringHelper.isEmpty(award.getAwardId())){
			award.setAwardId(UUIDUtil.generateUUID());
		}
		dao.saveOrUpdate(award);
		
		
		//处理及保存关联信息
		String awardId = award.getAwardId();
		
		//保存单位信息
		unitService.saveUnits(award.getUnitList(),awardId);
		
		//保存发展历程信息
		courseService.saveCourse(award.getCourseList(), awardId);
		
		//保存简介信息
		introService.saveIntro(award.getIntroduction(), awardId);
		
		return new ResultData.Builder<TAwardInfoEntity>().setEntity(award).build();
	}
	
	@Service("queryAwardInfo")
	public ISwordResponse queryAwardInfo(ISwordRequest req){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		
		String awardId = req.getData("awardId");
		TAwardInfoEntity award = dao.findOneByPrimaryKey(TAwardInfoEntity.class,awardId);
		
		List<TAwardCourseEntity> courses = courseService.queryCourse(awardId);
		List<TAwardUnitEntity> units = unitService.queryUnit(awardId);
		TAwardIntroductionEntity intro = introService.queryIntro(awardId);
		
		award.setCourseList(courses);
		award.setUnitList(units);
		award.setIntroduction(intro);
		
		return new ResultData.Builder<TAwardInfoEntity>().setEntity(award).build();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Service("searchAwardInfo")
	public ISwordResponse searchAwardInfo(ISwordRequest req) throws Exception{
		
		String awardCode = req.getData("awardCode");
		String arttype = req.getData("arttype");
		String startupTime = req.getData("startupTime");
		String level = req.getData("level");
		String nature = req.getData("nature");
		
		String sql = "select * from t_award_info t where 1=1 and t.invalid='N' ";
		List<String> param = new ArrayList<String>();
		
		if(StringHelper.isNotEmpty(awardCode)){
			sql += " and t.award_code=? ";
			param.add(awardCode);
		}
		
		if(StringHelper.isNotEmpty(arttype)){
			sql += " and t.art_type_dict=? ";
			param.add(arttype);
		}
		
		if(StringHelper.isNotEmpty(startupTime)){
			sql += " and t.startup_time=? ";
			param.add(startupTime);
		}
		
		if(StringHelper.isNotEmpty(level)){
			sql += " and t.award_level_dict=? ";
			param.add(level);
		}
		
		if(StringHelper.isNotEmpty(nature)){
			sql += " and t.award_nature_dict=? ";
			param.add(nature);
		}
		
		sql += "order by t.last_modify_time desc";
		
		JSONObject data = new JSONObject();
		
		
		data = new Page(req).getData(TAwardInfoEntity.class, sql,param.toArray());
		
		List<TAwardInfoEntity> awards = (List<TAwardInfoEntity>) data.get("curPageData");
		for(TAwardInfoEntity obj : awards){
			obj.setAwardName("awardName");
		}
		
		Long total = Long.parseLong(data.get("allDataCount").toString());
		
		return new ResultData.Builder<TAwardInfoEntity>().setRows(awards).setTotal(total).build();
	}
	
	@Service("delAwardInfo")
	public ISwordResponse delAwardInfo(ISwordRequest req) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String ids = req.getData("ids");
		String[] idArr = ids.split(",");
		for(String awardId : idArr){
			
			//删除历程
			courseService.saveCourse(new ArrayList<TAwardCourseEntity>(), awardId);
			//删除简介内容
			introService.saveIntro(null, awardId);
			//删除单位信息
			unitService.saveUnits(new ArrayList<TAwardUnitEntity>(), awardId);
			//删除主表
			dao.deleteByprimaryKey(TAwardInfoEntity.class, awardId);
		}
		
		return new ResultData.Builder<TAwardInfoEntity>().build();
	}
	
	
	
}
