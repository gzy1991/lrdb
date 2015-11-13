/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.stagePeriodical.service<br/>  
 * <b>文件名：</b>StagePeriodicalColumntreeService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月29日 下午1:58:43<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.stagePeriodical.service;

import java.util.List;

import cn.org.cflac.lardb.collection.classics.stagePeriodical.entity.TStagePeriodicalColumntreeEntity;
import cn.org.cflac.lardb.common.ResultData;

import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;

/**
 * @description TODO
 * @createTime 2015年10月29日 下午1:58:43
 * @modifyTime 
 * @author zhanglei@css.com.cn
 * @version 1.0
 */
@ServiceContainer(StagePeriodicalColumntreeService.serviceContainer)
public class StagePeriodicalColumntreeService {
	public static final String serviceContainer = "collection/classics/stagePeriodicalColumntreeService";
	private static final String TABLEOFEDU = "t_stage_periodical_columntree";
	private static final SwordLogUtils logger = SwordLogUtils.getLogger(StagePeriodicalColumntreeService.class);
	
	/**
	 * @description TODO
	 * @methodName SaveOrUpdateStagePeriodicalColumntree
	 * @param
	 * @returnType boolean   
	 * @throw
	 */
	public static boolean saveOrUpdateStagePeriodicalColumntree(List<TStagePeriodicalColumntreeEntity> stagePeriodicalColumntreeList,String stagePeriodicalId){
		logger.debug("---"+serviceContainer+"中的SaveOrUpdateStagePeriodicalColumntree方法开始---");
		delBatchStagePeriodicalColumntree(stagePeriodicalId);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if (stagePeriodicalColumntreeList != null) {
			for (TStagePeriodicalColumntreeEntity entity : stagePeriodicalColumntreeList) {
				entity.setStagePeriodicalId(stagePeriodicalId);		
				try {
					dao.saveOrUpdate(entity);
				} catch (SwordBaseCheckedException e) {
					e.printStackTrace();
					logger.debug("---"+serviceContainer+"中的SaveOrUpdateStagePeriodicalColumntree--->saveOrUpdate 方法报错---",e);
					return false;
				}
			}
		}
		logger.debug("---"+serviceContainer+"中的SaveOrUpdatePeriodicalColumntree方法结束---");
		return true;
	}
	
	/**
	 * @description TODO
	 * @methodName delBatchPeriodicalColumntree
	 * @param
	 * @returnType boolean   
	 * @throw
	 */
	public static boolean delBatchStagePeriodicalColumntree(String stagePeriodicalId){
		logger.debug("---"+serviceContainer+"中的delBatchPeriodicalColumntree方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = " delete from "+TABLEOFEDU+" where stage_periodical_id = ?";
		try {
			dao.deleteBySql(sql,stagePeriodicalId);
		} catch (SwordBaseCheckedException e) {
			e.printStackTrace();
			logger.debug("---"+serviceContainer+"中的delBatchPeriodicalColumntree方法结束---",e);
			return false;
		}
		logger.debug("---"+serviceContainer+"中的delBatchPeriodicalColumntree方法结束---");
		return true;
	}
	
	@Service("queryStagePeriodicalColumntreeById")
	public ISwordResponse queryStagePeriodicalColumntreeById(ISwordRequest iReq){
		logger.debug("---"+serviceContainer+"中的queryStagePeriodicalColumntreeById方法开始---");
		
		String stagePeriodicalId = iReq.getData("stagePeriodicalId");
		List<TStagePeriodicalColumntreeEntity> stagePeriodicalColumntreeList = queryStagePeriodicalColumntreeById(stagePeriodicalId);
		logger.debug("---"+serviceContainer+"中的queryStagePeriodicalColumntreeById方法结束---");
		return new ResultData.Builder<TStagePeriodicalColumntreeEntity>().setRows(stagePeriodicalColumntreeList).build();
	}
	
	public static List<TStagePeriodicalColumntreeEntity> queryStagePeriodicalColumntreeById(String stagePeriodicalId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = " select * from "+TABLEOFEDU+" t where t.stage_periodical_id = ?";
		List<TStagePeriodicalColumntreeEntity> stagePeriodicalColumntreeList = dao
				.findAllBySql(TStagePeriodicalColumntreeEntity.class, sql,
						stagePeriodicalId);
		return stagePeriodicalColumntreeList;
	}

}
