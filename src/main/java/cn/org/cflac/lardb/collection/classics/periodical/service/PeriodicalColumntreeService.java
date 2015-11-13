/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.periodical.service<br/>  
 * <b>文件名：</b>PeriodicalColumntreeService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月23日 上午10:07:28<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.periodical.service;

import java.util.List;

import cn.org.cflac.lardb.collection.classics.periodical.entity.TPeriodicalColumntreeEntity;
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
 * @createTime 2015年10月23日 上午10:07:28
 * @modifyTime 
 * @author zhanglei@css.com.cn
 * @version 1.0
 */
@ServiceContainer(PeriodicalColumntreeService.serviceContainer)
public class PeriodicalColumntreeService {
			 
	public static final String serviceContainer = "collection/classics/periodicalColumntreeService";
	private static final SwordLogUtils logger = SwordLogUtils.getLogger(PeriodicalColumntreeService.class);
	private static final String TABLEOFEDU = "t_periodical_columntree";
	
	/**
	 * @description TODO
	 * @methodName SaveOrUpdatePeriodicalColumntree
	 * @param
	 * @returnType boolean   
	 * @throw
	 */
	public boolean SaveOrUpdatePeriodicalColumntree(List<TPeriodicalColumntreeEntity> periodicalColumntreeList,String periodicalId){
		logger.debug("---"+serviceContainer+"中的SaveOrUpdatePeriodicalColumntree方法开始---");
		delBatchPeriodicalColumntree(periodicalId);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if (periodicalColumntreeList != null) {
			for (TPeriodicalColumntreeEntity entity : periodicalColumntreeList) {
				entity.setPeriodicalId(periodicalId);		
				try {
					dao.saveOrUpdate(entity);
				} catch (SwordBaseCheckedException e) {
					e.printStackTrace();
					logger.debug("---"+serviceContainer+"中的SaveOrUpdatePeriodicalColumntree--->saveOrUpdate 方法报错---",e);
					return false;
				}
			}
		}
		logger.debug("---"+serviceContainer+"中的SaveOrUpdatePeriodicalColumntree方法结束---");
		return true;
	}
	
	/**
	 * @description TODO
	 * @methodName queryPeriodicalInfoById
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("queryPeriodicalColumntreeById")
	public ISwordResponse queryPeriodicalColumntreeById(ISwordRequest iReq){
		logger.debug("---"+serviceContainer+"中的queryPeriodicalColumntreeById方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String periodicalId = iReq.getData("periodicalId");
		String sql = " select * from "+TABLEOFEDU+" t where t.periodical_id = ?";
		List<TPeriodicalColumntreeEntity> periodicalColumntreeList = dao
				.findAllBySql(TPeriodicalColumntreeEntity.class, sql,
						periodicalId);
		logger.debug("---"+serviceContainer+"中的queryPeriodicalColumntreeById方法结束---");
		return new ResultData.Builder<TPeriodicalColumntreeEntity>().setRows(periodicalColumntreeList).build();
	}
	
	
	/**
	 * @description TODO
	 * @methodName delBatchPeriodicalColumntree
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	public static boolean delBatchPeriodicalColumntree(String periodicalId){
		logger.debug("---"+serviceContainer+"中的delBatchPeriodicalColumntree方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = " delete from "+TABLEOFEDU+" where periodical_id = ?";
		try {
			dao.deleteBySql(sql,periodicalId);
		} catch (SwordBaseCheckedException e) {
			e.printStackTrace();
			logger.debug("---"+serviceContainer+"中的delBatchPeriodicalColumntree方法结束---",e);
			return false;
		}
		logger.debug("---"+serviceContainer+"中的delBatchPeriodicalColumntree方法结束---");
		return true;
	}
}
