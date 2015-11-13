/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.stagePeriodical.service<br/>  
 * <b>文件名：</b>StagePeriodicalArticleInfoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月30日 下午3:34:43<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.stagePeriodical.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStageArtistUnitEntity;
import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStagePeriodicalArticleInfoEntity;
import cn.org.cflac.lardb.common.Paging;
import cn.org.cflac.lardb.common.ResultData;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.SwordStringUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;
import com.css.sword.web.response.SwordResponseFactory;

/**
 * @description TODO
 * @createTime 2015年10月30日 下午3:34:43
 * @modifyTime
 * @author zhanglei@css.com.cn
 * @version 1.0
 */
@ServiceContainer(StagePeriodicalArticleInfoService.serviceContainer)
public class StagePeriodicalArticleInfoService {
	public static final String serviceContainer = "collection/classics/stagePeriodicalArticleInfoService";
	private static final String TABLEOFEDU = "t_stage_periodical_article_info";
	private static final SwordLogUtils logger = SwordLogUtils
			.getLogger(StagePeriodicalArticleInfoService.class);

	@Service("queryStagePeriodicalArticleInfobyColumnIdList")
	public ISwordResponse queryStagePeriodicalArticleInfobyColumnIdList(
			ISwordRequest iReq, Paging paging) throws Exception {
		logger.debug("---" + serviceContainer
				+ "中的queryStagePeriodicalArticleInfobyColumnIdList方法开始---");
		String columntreePertreeId = iReq.getData("columntreePertreeId");
		JSONObject jsonObj = StagePeriodicalArticleInfoService.queryStagePeriodicalArticleInfobyColumnIdList(columntreePertreeId, paging);
		if(jsonObj != null){
			Long total = (Long) jsonObj.get("total");
			List<TStagePeriodicalArticleInfoEntity> stagePeriodicalArticleInfoList = (List<TStagePeriodicalArticleInfoEntity>) jsonObj.get("stagePeriodicalArticleInfoList");
			return new ResultData.Builder<TStagePeriodicalArticleInfoEntity>()
						.setRows(stagePeriodicalArticleInfoList).setTotal(total)
						.build();
		}else{
			return SwordResponseFactory.createSwordResponseInstance(null);
		}
		
	}

	public static JSONObject queryStagePeriodicalArticleInfobyColumnIdList(String columntreePertreeId, Paging paging){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		JSONObject jsonObj = new JSONObject();
		if (!SwordStringUtils.isEmpty(columntreePertreeId)) {
			String sql = "select * from " + TABLEOFEDU + " info where 1=1 ";
			String sqlCount = "select count(*) total from " + TABLEOFEDU
					+ " info where 1=1 ";
			String sqlTmp = "";
			List<Object> param = new ArrayList<Object>();
			if (!SwordStringUtils.isEmpty(columntreePertreeId)) {
				sqlTmp += "  and info.columntree_pertree_id = ? ";
				param.add(columntreePertreeId);
			}
			sqlTmp += " and invalid = 'N' ORDER BY info.lastmodify_time DESC";
			Object[] paramObj = null;
			if (null != param && param.size() > 0) {
				paramObj = param.toArray();
			}
			// 查询列表数据
			List<TStagePeriodicalArticleInfoEntity> stagePeriodicalArticleInfoList = dao
					.findAllBySqlWithPaging(
							TStagePeriodicalArticleInfoEntity.class, sql
									+ sqlTmp, paging.getCurPage(),
							paging.getPageSize(), paramObj);
			// 查询总条数
			Map<String, Object> map = dao.findOneBySql(sqlCount + sqlTmp,
					paramObj);
			Long total = Long.parseLong(map.get("total").toString());
			logger.debug("---" + serviceContainer
					+ "中的queryStagePeriodicalArticleInfobyColumnIdList方法结束---");
			jsonObj.put("stagePeriodicalArticleInfoList", stagePeriodicalArticleInfoList);
			jsonObj.put("total", total);
		}else{
			jsonObj = null;
		}
		return jsonObj;
	}
	
	public static boolean saveOrUpdateStagePeriodicalArticle(
			List<TStagePeriodicalArticleInfoEntity> articleInfoList)
			throws SwordBaseCheckedException {
		logger.debug("---" + serviceContainer
				+ "中的saveOrUpdateStagePeriodicalArticle方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if (articleInfoList != null) {
			for (TStagePeriodicalArticleInfoEntity entity : articleInfoList) {
				dao.saveOrUpdate(entity);
				StagePeriodicalArticleUnitService.saveOrUpdatePeriodicalArticleUnit(entity.getArtAuthors(), entity.getArtTranslators(), entity.getArticleId());
			}
		}
		logger.debug("---" + serviceContainer
				+ "中的saveOrUpdateStagePeriodicalArticle方法结束---");
		return true;
	}
	
	@Service("queryStagePeriodicalArticleById")
	public ISwordResponse queryStagePeriodicalArticleById(ISwordRequest iReq){
		logger.debug("---"+serviceContainer+"中的queryStagePeriodicalArticleById方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String articleId = iReq.getData("articleId");
		TStagePeriodicalArticleInfoEntity stagePeriodicalArticle = dao.findOneByPrimaryKey(TStagePeriodicalArticleInfoEntity.class, articleId);
		
		List<TStageArtistUnitEntity>  artistUnitList = StagePeriodicalArticleUnitService.queryStagePeriodicalArticleById(stagePeriodicalArticle.getArticleId());
		if(artistUnitList.size() > 0){
			JSONArray artAuthorsJsonObj = new JSONArray();
			JSONArray artTranslatorsJsonObj = new JSONArray();
			for(TStageArtistUnitEntity entity: artistUnitList){
				JSONObject artAuthorsObj = null;
				JSONObject artTranslatorsObj = null;
				if(entity.getStageArtistType().equals("artAuthor")){
					artAuthorsObj = new JSONObject();
					artAuthorsObj.put("stageArtistType", "artAuthor");
					artAuthorsObj.put("stageArtistNameMix", entity.getStageArtistNameMix());
					artAuthorsObj.put("stageArtistOrg", entity.getStageArtistOrg());
				}else if(entity.getStageArtistType().equals("artTranslator")){
					artTranslatorsObj = new JSONObject();
					artTranslatorsObj.put("stageArtistType", "artTranslator");
					artTranslatorsObj.put("stageArtistNameMix", entity.getStageArtistNameMix());
					artTranslatorsObj.put("stageArtistOrg", entity.getStageArtistOrg());
				}
				if(artAuthorsObj != null){
					artAuthorsObj.put("stageArtistType", "artAuthor");
					artAuthorsJsonObj.add(artAuthorsObj);
				}
				if(artTranslatorsObj != null){
					artTranslatorsObj.put("stageArtistType", "artTranslator");
					artTranslatorsJsonObj.add(artTranslatorsObj);
				}
			}
			if(artAuthorsJsonObj.size() == 0){
				artAuthorsJsonObj.add(new JSONObject());
			}if(artTranslatorsJsonObj.size() == 0){
				artTranslatorsJsonObj.add(new JSONObject());
			}
			stagePeriodicalArticle.setArtAuthors(artAuthorsJsonObj);
			stagePeriodicalArticle.setArtTranslators(artTranslatorsJsonObj);
		}
		logger.debug("---"+serviceContainer+"中的queryStagePeriodicalArticleById方法结束---");
		return new ResultData.Builder<TStagePeriodicalArticleInfoEntity>().setEntity(stagePeriodicalArticle).build();
	}
	
	public static boolean delBatchArticleInfoByPrimaryKey(String articleIds) throws SwordBaseCheckedException{
		logger.debug("---"+serviceContainer+"中的delBatchArticleInfoById方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if(!SwordStringUtils.isEmpty(articleIds)){
			String sql = " delete from "+TABLEOFEDU+" where article_id = ?";
			String[] idsList = articleIds.split(",");
			if(idsList.length>0){
				for(String articleId : idsList){
					dao.deleteBySql(sql,articleId);
				}
			}
		}
		logger.debug("---"+serviceContainer+"中的delBatchArticleInfoById方法结束---");
		return true;
	}
	
	public static boolean delBatchArticleInfoByColumnId(String ColumnId) throws SwordBaseCheckedException{
		logger.debug("---"+serviceContainer+"中的delBatchArticleInfoByColumnId方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if(!SwordStringUtils.isEmpty(ColumnId)){
			
			JSONObject jsonObj = StagePeriodicalArticleInfoService.queryStagePeriodicalArticleInfobyColumnIdList(ColumnId, new Paging());
			if(jsonObj != null){
				List<TStagePeriodicalArticleInfoEntity> stagePeriodicalArticleInfoList = (List<TStagePeriodicalArticleInfoEntity>) jsonObj.get("stagePeriodicalArticleInfoList");
				if(stagePeriodicalArticleInfoList.size() > 0){
					for(TStagePeriodicalArticleInfoEntity entity:stagePeriodicalArticleInfoList){
						StagePeriodicalArticleUnitService.delBatchArticleUnit(entity.getArticleId());
					}
				}
			}
			String sql = " delete from "+TABLEOFEDU+" where columntree_pertree_id = ?";
			dao.deleteBySql(sql,ColumnId);
		}
		logger.debug("---"+serviceContainer+"中的delBatchArticleInfoByColumnId方法结束---");
		return true;
	}
}
