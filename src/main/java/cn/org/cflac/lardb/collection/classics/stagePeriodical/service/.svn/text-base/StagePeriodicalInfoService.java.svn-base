/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.stagePeriodical.service<br/>  
 * <b>文件名：</b>StagePeriodicalInfoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午3:33:14<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.stagePeriodical.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStagePeriodicalArticleInfoEntity;
import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStagePeriodicalColumntreeEntity;
import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStagePeriodicalInfoEntity;
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
 * @createTime 2015年10月28日 下午3:33:14
 * @modifyTime
 * @author zhanglei@css.com.cn
 * @version 1.0
 */
@ServiceContainer(StagePeriodicalInfoService.ServiceContainer)
public class StagePeriodicalInfoService {
	public static final String ServiceContainer = "collection/classics/stagePeriodicalInfoService";
	private static final String TABLEOFEDU = "t_stage_periodical_info";
	private static final SwordLogUtils logger = SwordLogUtils
			.getLogger(StagePeriodicalInfoService.class);

	/**
	 * @description TODO
	 * @methodName queryStagePeriodicalInfoList
	 * @param
	 * @returnType ISwordResponse
	 * @throw
	 */
	@Service("queryStagePeriodicalInfoList")
	public ISwordResponse queryStagePeriodicalInfoList(ISwordRequest iReq)
			throws Exception {
		logger.debug("---" + ServiceContainer
				+ "中的queryStagePeriodicalInfoList方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String stagePerName = iReq.getData("stagePerName");
		String stagePerStage = iReq.getData("stagePerStage");
		String stagePerYear = iReq.getData("stagePerYear");
		String perType = iReq.getData("perType");
		String sql = "select * from " + TABLEOFEDU + " info where 1=1 ";
		String sqlCount = "select count(*) total from " + TABLEOFEDU
				+ " info where 1=1 ";
		String sqlTmp = "";
		List<Object> param = new ArrayList<Object>();
		if (!SwordStringUtils.isEmpty(stagePerName)) {
			sqlTmp += "  and info.stage_periodical_name LIKE ? ";
			param.add("%" + stagePerName + "%");
		}
		if (!SwordStringUtils.isEmpty(stagePerStage)) {
			sqlTmp += "  and (info.stage_periodical_stage LIKE ? or info.stage_periodical_total_stage LIKE ?) ";
			param.add("%" + stagePerStage + "%");
			param.add("%" + stagePerStage + "%");
		}
		if (!SwordStringUtils.isEmpty(stagePerYear)) {
			sqlTmp += "  and info.stage_periodical_publish_date LIKE ? ";
			param.add("%" + stagePerYear + "%");
		}
		if (!SwordStringUtils.isEmpty(perType)) {
			sqlTmp += "  and info.type_dict LIKE ? ";
			param.add("%" + perType + "%");
		}
		sqlTmp += " and invalid = 'N' ORDER BY info.lastmodify_time DESC";
		Object[] paramObj = null;
		if (null != param && param.size() > 0) {
			paramObj = param.toArray();
		}
		Paging paging = new Paging();
		// 查询列表数据
		List<TStagePeriodicalInfoEntity> stagePeriodicalInfoList = dao
				.findAllBySqlWithPaging(TStagePeriodicalInfoEntity.class, sql
						+ sqlTmp, paging.getCurPage(), paging.getPageSize(),
						paramObj);
		// 查询总条数
		Map<String, Object> map = dao.findOneBySql(sqlCount + sqlTmp, paramObj);
		Long total = Long.parseLong(map.get("total").toString());
		logger.debug("---" + ServiceContainer
				+ "中的queryStagePeriodicalInfoList方法结束---");
		return new ResultData.Builder<TStagePeriodicalInfoEntity>()
				.setRows(stagePeriodicalInfoList).setTotal(total).build();
	}

	/**
	 * @description TODO
	 * @methodName saveOrUpdateStagePeriodical
	 * @param
	 * @returnType ISwordResponse
	 * @throw
	 */
	@Service("saveOrUpdateStagePeriodical")
	public ISwordResponse saveOrUpdateStagePeriodical(ISwordRequest iReq)
			throws SwordBaseCheckedException {
		logger.debug("---" + ServiceContainer
				+ "中的saveOrUpdatePeriodical方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String stagePeriodicalInfoStr = iReq.getData("stagePeriodicalInfo");
		String stagePeriodicalColumntreeStr = iReq
				.getData("stagePeriodicalColumntree");
		String articleInfoListStr = iReq.getData("articleInfoList");
		String delArticleIds = iReq.getData("delArticleInfoIds");
		TStagePeriodicalInfoEntity stagePeriodicalInfo = JSON.parseObject(
				stagePeriodicalInfoStr, TStagePeriodicalInfoEntity.class);
		List<TStagePeriodicalColumntreeEntity> stagePeriodicalColumntreeList = JSON
				.parseArray(stagePeriodicalColumntreeStr,
						TStagePeriodicalColumntreeEntity.class);
		List<TStagePeriodicalArticleInfoEntity> articleInfoList = JSON
				.parseArray(articleInfoListStr,
						TStagePeriodicalArticleInfoEntity.class);
		String stagePeriodicalId = stagePeriodicalInfo.getStagePeriodicalId();
		// 保存文章信息
		StagePeriodicalArticleInfoService
				.saveOrUpdateStagePeriodicalArticle(articleInfoList);
		// 删除文章信息
		StagePeriodicalArticleInfoService
				.delBatchArticleInfoByPrimaryKey(delArticleIds);
		// 栏目操作
		StagePeriodicalColumntreeService.saveOrUpdateStagePeriodicalColumntree(
				stagePeriodicalColumntreeList, stagePeriodicalId);
		// 保存分期信息
		dao.saveOrUpdate(stagePeriodicalInfo);
		logger.debug("---" + ServiceContainer
				+ "中的saveOrUpdatePeriodical方法结束---");
		return new ResultData.Builder<TStagePeriodicalInfoEntity>().setEntity(
				stagePeriodicalInfo).build();
	}

	@Service("queryStagePeriodicalInfoById")
	public ISwordResponse queryStagePeriodicalInfoById(ISwordRequest iReq) {
		logger.debug("---" + ServiceContainer
				+ "中的queryStagePeriodicalInfoById方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String stagePeriodicalId = iReq.getData("stagePeriodicalId");
		TStagePeriodicalInfoEntity stagePeriodicalInfo = dao
				.findOneByPrimaryKey(TStagePeriodicalInfoEntity.class,
						stagePeriodicalId);
		logger.debug("---" + ServiceContainer
				+ "中的queryStagePeriodicalInfoById方法结束---");
		return new ResultData.Builder<TStagePeriodicalInfoEntity>().setEntity(
				stagePeriodicalInfo).build();
	}

	@Service("delBatchStagePeriodicalInfoById")
	public ISwordResponse delBatchStagePeriodicalInfoById(ISwordRequest iReq)
			throws SwordBaseCheckedException {
		logger.debug("---" + ServiceContainer
				+ "中的delBatchStagePeriodicalInfoById方法开始---");
		String stagePeriodicalIds = iReq.getData("stagePeriodicalIds");
		delBatchStagePeriodicalInfoById(stagePeriodicalIds);
		return new ResultData.Builder<TStagePeriodicalInfoEntity>().build();
	}
	
	public static boolean  delBatchStagePeriodicalInfoById(String stagePeriodicalIds) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String[] idsList = stagePeriodicalIds.split(",");
		if (idsList.length > 0) {
			for (String stagePeriodicalId : idsList) {
				dao.deleteByprimaryKey(TStagePeriodicalInfoEntity.class,
						stagePeriodicalId);
				List<TStagePeriodicalColumntreeEntity> stagePeriodicalColumntreeList = StagePeriodicalColumntreeService
						.queryStagePeriodicalColumntreeById(stagePeriodicalId);
				for(TStagePeriodicalColumntreeEntity entity: stagePeriodicalColumntreeList){
					//删除文章信息
					StagePeriodicalArticleInfoService.delBatchArticleInfoByColumnId(entity.getColumntreePertreeId());
				}
				// 删除栏目信息
				StagePeriodicalColumntreeService
						.delBatchStagePeriodicalColumntree(stagePeriodicalId);
			}
		}
		logger.debug("---" + ServiceContainer
				+ "中的delBatchStagePeriodicalInfoById方法结束---");
		return true;
	}
	
	public static List<TStagePeriodicalInfoEntity> queryStagePeriodicalInfoByPeriodicalIdList(String periodicalId){
		logger.debug("---" + ServiceContainer
				+ "中的queryStagePeriodicalInfoByPeriodicalIdList方法结束---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "SELECT info FROM TStagePeriodicalInfoEntity info  WHERE info.invalid = 'N'  AND info.periodicalId = ? ";
		List<TStagePeriodicalInfoEntity> stagePeriodicalInfoList = dao.findAllByJpql(TStagePeriodicalInfoEntity.class, sql, periodicalId);
		logger.debug("---" + ServiceContainer
				+ "中的queryStagePeriodicalInfoByPeriodicalIdList方法结束---");
		return stagePeriodicalInfoList;
	}
}
