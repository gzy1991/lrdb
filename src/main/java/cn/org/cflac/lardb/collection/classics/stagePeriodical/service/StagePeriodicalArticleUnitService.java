/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.periodical.service<br/>  
 * <b>文件名：</b>PeriodicaUnitService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月26日 下午4:54:07<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.stagePeriodical.service;

import java.util.List;

import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStageArtistUnitEntity;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.logger.SwordLogUtils;

/**
 * @description TODO
 * @createTime 2015年10月26日 下午4:54:07
 * @modifyTime 
 * @author zhanglei@css.com.cn
 * @version 1.0
 */

@ServiceContainer(StagePeriodicalArticleUnitService.serviceContainer)
public class StagePeriodicalArticleUnitService {
	public static final String serviceContainer = "collection/classics/stagePeriodicalArticleUnitService";
	private static final SwordLogUtils logger = SwordLogUtils.getLogger(StagePeriodicalArticleUnitService.class);
	private static final String TABLEOFEDU = "t_stage_artist__unit";
	
	public static boolean saveOrUpdatePeriodicalArticleUnit(JSONArray artAuthors,JSONArray artTranslators,String articleId) throws SwordBaseCheckedException{
		logger.debug("---"+serviceContainer+"中的saveOrUpdatePeriodicalArticleUnit方法开始---");
		delBatchArticleUnit(articleId);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if (artAuthors != null) {
			List<TStageArtistUnitEntity> artAuthorsList = JSON
					.parseArray(artAuthors.toString(),TStageArtistUnitEntity.class);
			for(TStageArtistUnitEntity entity : artAuthorsList){
				entity.setArticleId(articleId);
				dao.saveOrUpdate(entity);
			}
		}
		if (artTranslators != null) {
			List<TStageArtistUnitEntity> artTranslatorsList = JSON
					.parseArray(artTranslators.toString(),TStageArtistUnitEntity.class);
			for(TStageArtistUnitEntity entity : artTranslatorsList){
				entity.setArticleId(articleId);
				dao.saveOrUpdate(entity);
			}
		}
		logger.debug("---"+serviceContainer+"中的saveOrUpdatePeriodicalArticleUnit方法结束---");
		return true;
	}
	
	public static List<TStageArtistUnitEntity> queryStagePeriodicalArticleById(String articleId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = " select * from "+TABLEOFEDU+" t where t.article_id = ?";
		List<TStageArtistUnitEntity> artistUnitList = dao
				.findAllBySql(TStageArtistUnitEntity.class, sql,
						articleId);
		return artistUnitList;
	}
	
	public static boolean delBatchArticleUnit(String articleId) throws SwordBaseCheckedException{
		logger.debug("---"+serviceContainer+"中的delBatchArticleUnit方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = " delete from "+TABLEOFEDU+" where article_id = ?";
		dao.deleteBySql(sql,articleId);
		logger.debug("---"+serviceContainer+"中的delBatchArticleUnit方法结束---");
		return true;
	}
}
