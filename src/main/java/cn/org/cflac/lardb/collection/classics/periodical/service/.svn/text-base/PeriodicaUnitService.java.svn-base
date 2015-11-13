/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.periodical.service<br/>  
 * <b>文件名：</b>PeriodicaUnitService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月26日 下午4:54:07<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.periodical.service;

import java.util.List;

import cn.org.cflac.lardb.collection.classics.periodical.entity.TPeriodicaUnitEntity;
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
 * @createTime 2015年10月26日 下午4:54:07
 * @modifyTime 
 * @author zhanglei@css.com.cn
 * @version 1.0
 */
@ServiceContainer(PeriodicaUnitService.serviceContainer)
public class PeriodicaUnitService {
	public static final String serviceContainer = "collection/classics/periodicaUnitService";
	private static final SwordLogUtils logger = SwordLogUtils.getLogger(PeriodicaUnitService.class);
	private static final String TABLEOFEDU = "t_periodica_unit";
	
	public boolean saveOrUpdatePeriodicaUnit(List<TPeriodicaUnitEntity> periodicaUnitList,String periodicalId){
		logger.debug("---"+serviceContainer+"中的saveOrUpdatePeriodicaUnit方法开始---");
		delBatchPeriodicaUnit(periodicalId);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if (periodicaUnitList != null) {
			for (TPeriodicaUnitEntity entity : periodicaUnitList) {
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
		logger.debug("---"+serviceContainer+"中的saveOrUpdatePeriodicaUnit方法结束---");
		return true;
	}
	
	/**
	 * @description TODO
	 * @methodName queryPeriodicaUnitById
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("queryPeriodicaUnitById")
	public ISwordResponse queryPeriodicaUnitById(ISwordRequest iReq){
		logger.debug("---"+serviceContainer+"中的queryPeriodicaUnitById方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String periodicalId = iReq.getData("periodicalId");
 		String sql = "select * from "+TABLEOFEDU+" t where t.periodical_id = ?";
		List<TPeriodicaUnitEntity> periodicaUnitList = dao
				.findAllBySql(TPeriodicaUnitEntity.class, sql,
						periodicalId);
		logger.debug("---"+serviceContainer+"中的queryPeriodicaUnitById方法结束---");
		return new ResultData.Builder<TPeriodicaUnitEntity>().setRows(periodicaUnitList).build();
	}
	
	public static boolean delBatchPeriodicaUnit(String periodicalId){
		logger.debug("---"+serviceContainer+"中的delBatchperiodicaUnit方法开始---");
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = " delete from "+TABLEOFEDU+" where periodical_id = ?";
		try {
			dao.deleteBySql(sql,periodicalId);
		} catch (SwordBaseCheckedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.debug("---"+serviceContainer+"中的delBatchPeriodicaUnit方法结束---",e);
			return false;
		}
		logger.debug("---"+serviceContainer+"中的delBatchPeriodicaUnit方法结束---");
		return true;
	}
}
