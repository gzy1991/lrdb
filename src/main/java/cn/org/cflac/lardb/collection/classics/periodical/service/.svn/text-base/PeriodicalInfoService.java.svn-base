/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.periodical.service<br/>  
 * <b>文件名：</b>PeriodicalInfoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月20日 下午2:36:43<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.periodical.service;
 
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.org.cflac.lardb.collection.classics.periodical.entity.TPeriodicaUnitEntity;
import cn.org.cflac.lardb.collection.classics.periodical.entity.TPeriodicalColumntreeEntity;
import cn.org.cflac.lardb.collection.classics.periodical.entity.TPeriodicalInfoEntity;
import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStagePeriodicalInfoEntity;
import cn.org.cflac.lardb.collection.classics.stagePeriodical.service.StagePeriodicalInfoService;
import cn.org.cflac.lardb.common.Paging;
import cn.org.cflac.lardb.common.ResultData;

import com.alibaba.fastjson.JSON;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.SwordStringUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;


/**
 * @description TODO
 * @createTime 2015年10月23日 下午4:59:35
 * @modifyTime 
 * @author zhanglei@css.com.cn
 * @version 1.0
 */
@ServiceContainer(PeriodicalInfoService.ServiceContainer)
public class PeriodicalInfoService {
	public static final String ServiceContainer = "collection/classics/periodicalInfoService";
//	private static final String TABLEOFEDU = "t_periodical_info";
	private static final SwordLogUtils logger = SwordLogUtils.getLogger(PeriodicalInfoService.class);
	/**
	 * @description TODO
	 * @methodName queryPeriodicalInfoList
	 * @param 
	 * 期刊名称 ：queryPerName
	 * 期刊类别：queryPerType
	 * 主办单位：querySponsorOrg
	 * 出版单位：queryPublisher
	 * @throws Exception 
	 * @returnType ISwordResponse   
	 * @throw 
	 */
	@Service("queryPeriodicalInfoList")
	public ISwordResponse queryPeriodicalInfoList(ISwordRequest iReq) throws Exception{
		
		logger.debug("---"+ServiceContainer+"中的queryPeriodicalInfoList方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String perName = iReq.getData("perName");
		String perType = iReq.getData("perType");
		String sponsor = iReq.getData("sponsor");
		String publisher = iReq.getData("publish");
		String sql = "select t.periodical_name_cn,t.type_dict,t.publish_cycle_dict,t.create_user,t.lastmodify_user,"
				+ "t.lastmodify_time,t.periodical_id, t.name as 'sponsor',t1.name as 'publisher' ";
		String sqlCount = " select count(*) total ";
		String sqlConditian	= "from (select info.periodical_name_cn,info.type_dict,info.publish_cycle_dict,info.lastmodify_user,info.lastmodify_time"
				+ ",info.create_user,info.periodical_id,s.unit_type,GROUP_CONCAT(s.sponsor_name) as name from t_periodical_info info, "
				+ "(select t.periodical_id, t.unit_name_id AS sponsor_id, t.unit_name_mix AS sponsor_name, t.unit_type  "
				+ "FROM t_periodica_unit t where t.unit_type <> '0') s "
				+ "where info.periodical_id = s.periodical_id  and invalid = 'N' and s.unit_type='1'  "
				+ "group by info.periodical_id,s.unit_type) t,"
				+ "(select info.periodical_id,s.unit_type,GROUP_CONCAT(s.sponsor_name) as name from t_periodical_info info, "
				+ "(select t.periodical_id, t.unit_name_id AS sponsor_id, "
				+ "t.unit_name_mix AS sponsor_name, t.unit_type  FROM t_periodica_unit t where t.unit_type <> '0') s "
				+ "where info.periodical_id = s.periodical_id  and invalid = 'N' and s.unit_type='2' "
				+ " group by info.periodical_id,s.unit_type) t1 where t.periodical_id=t1.periodical_id ";
		List<Object> param = new ArrayList<Object>();
		if(!SwordStringUtils.isEmpty(perName)){
			sqlConditian += " AND t.periodical_name_cn like ? ";
			param.add("%"+perName+"%");
		}
		if(!SwordStringUtils.isEmpty(perType)){
			sqlConditian += " and t.type_dict = ? ";
			param.add(perType);
		}
		if(!SwordStringUtils.isEmpty(sponsor)){
			sqlConditian += "  and t.name LIKE ? ";
			param.add("%"+sponsor+"%");
		}
		if(!SwordStringUtils.isEmpty(publisher)){
			sqlConditian += "  and t1.name LIKE ? ";
			param.add("%"+publisher+"%");
		}
		
		Object[] paramObj = null;
		if(null!=param && param.size()>0){
			paramObj=param.toArray();
		}
		Paging paging = new Paging();
		 //查询列表数据
        List<TPeriodicalInfoEntity> periodicalInfoList = dao.findAllBySqlWithPaging(TPeriodicalInfoEntity.class,sql+" "+sqlConditian, paging.getCurPage(), paging.getPageSize(), paramObj);
        //查询总条数
        Map<String,Object> map = dao.findOneBySql(sqlCount+" "+sqlConditian, paramObj);
        Long total = Long.parseLong(map.get("total").toString());
        logger.debug("---"+ServiceContainer+"中的queryPeriodicalInfoList方法结束---");
        return new ResultData.Builder<TPeriodicalInfoEntity>().setRows(periodicalInfoList).setTotal(total).build();
	}
	
	/**
	 * @description TODO
	 * @methodName saveAndUpdatePeriodical
	 * 保存或更新更新总体期刊信息
	 * @param
	 * @throws SwordBaseCheckedException 
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("saveOrUpdatePeriodical")
	public ISwordResponse saveOrUpdatePeriodical(ISwordRequest iReq) throws SwordBaseCheckedException{
		logger.debug("---"+ServiceContainer+"中的saveOrUpdatePeriodical方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String periodicalInfoStr = iReq.getData("periodicalInfo");
		String periodicalColumntreeStr = iReq.getData("periodicalColumntree");
		String periodicaUnitStr = iReq.getData("periodicaUnit");
		TPeriodicalInfoEntity periodicalInfo = JSON.parseObject(periodicalInfoStr, TPeriodicalInfoEntity.class);
		List<TPeriodicalColumntreeEntity> periodicalColumntreeList = JSON.parseArray(periodicalColumntreeStr, TPeriodicalColumntreeEntity.class);
		List<TPeriodicaUnitEntity> periodicaUnitList = JSON.parseArray(periodicaUnitStr, TPeriodicaUnitEntity.class);
		String periodicalId = periodicalInfo.getPeriodicalId();
		//栏目操作
		new PeriodicalColumntreeService().SaveOrUpdatePeriodicalColumntree(periodicalColumntreeList, periodicalId);
		//地点操作
		new PeriodicaUnitService().saveOrUpdatePeriodicaUnit(periodicaUnitList, periodicalId);
		dao.saveOrUpdate(periodicalInfo);
		logger.debug("---"+ServiceContainer+"中的saveOrUpdatePeriodical方法结束---");
		return new ResultData.Builder<TPeriodicalInfoEntity>().setEntity(periodicalInfo).build();
	}
	
	/**
	 * @description TODO
	 * @methodName queryPeriodicalInfoById
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("queryPeriodicalInfoById")
	public ISwordResponse queryPeriodicalInfoById(ISwordRequest iReq){
		logger.debug("---"+ServiceContainer+"中的queryPeriodicalInfoById方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String periodicalId = iReq.getData("periodicalId");
		TPeriodicalInfoEntity periodicalInfo = dao.findOneByPrimaryKey(
				TPeriodicalInfoEntity.class, periodicalId);
		logger.debug("---"
				+ServiceContainer+"中的queryPeriodicalInfoById方法结束---");
		return new ResultData.Builder<TPeriodicalInfoEntity>().setEntity(periodicalInfo).build();
	}
	
	/**
	 * @description TODO
	 * @methodName delBatchPeriodicalInfoById
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("delBatchPeriodicalInfoById")
	public ISwordResponse delBatchPeriodicalInfoById(ISwordRequest iReq) throws SwordBaseCheckedException{
		logger.debug("---"+ServiceContainer+"中的delBatchPeriodicalInfoById方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String periodicalIds = iReq.getData("periodicalIds");
		String[] idsList = periodicalIds.split(",");
		if(idsList.length>0){
			for(String periodicalId : idsList){
				dao.deleteByprimaryKey(TPeriodicalInfoEntity.class, periodicalId);
				PeriodicalColumntreeService.delBatchPeriodicalColumntree(periodicalId);
				PeriodicaUnitService.delBatchPeriodicaUnit(periodicalId);
				
				List<TStagePeriodicalInfoEntity> stagePeriodicalInfoList = StagePeriodicalInfoService.queryStagePeriodicalInfoByPeriodicalIdList(periodicalId);
				if(stagePeriodicalInfoList != null && stagePeriodicalInfoList.size() > 0){
					for(TStagePeriodicalInfoEntity entity : stagePeriodicalInfoList){
						StagePeriodicalInfoService.delBatchStagePeriodicalInfoById(entity.getStagePeriodicalId());
					}
				}
			}
		}
		logger.debug("---"+ServiceContainer+"中的delBatchPeriodicalInfoById方法结束---");
		return new ResultData.Builder<TPeriodicalInfoEntity>().build();
	}
}
