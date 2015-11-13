/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.award.service<br/>  
 * <b>文件名：</b>AwardIntroductionService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月26日 下午1:42:17<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.award.service;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import cn.org.cflac.lardb.collection.award.entity.TAwardIntroductionEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * @description TODO
 * @createTime 2015年10月26日 下午1:42:17
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class AwardIntroductionService {
	
	public void saveIntro(TAwardIntroductionEntity introduction, String awardId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		if(introduction != null){
			introduction.setAwardId(awardId);
			if(StringHelper.isEmpty(introduction.getIntroductionId())){
				introduction.setIntroductionId(UUIDUtil.generateUUID());
			}
			dao.saveOrUpdate(introduction);
		}else{
			String sql = "select * from t_award_introduction t where t.award_id=? and t.invalid='N'";
			List<String> sqlParam = new ArrayList<String>();
			sqlParam.add(awardId);
			TAwardIntroductionEntity intro = dao.findOneBySql(TAwardIntroductionEntity.class, sql, sqlParam);
			if(intro != null){
				dao.delete(intro);
			}
		}
		
	}
	
	public TAwardIntroductionEntity queryIntro(String awardId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_award_introduction t where t.award_id=? and t.invalid='N'";
		List<String> sqlParam = new ArrayList<String>();
		sqlParam.add(awardId);
		TAwardIntroductionEntity intro = dao.findOneBySql(TAwardIntroductionEntity.class, sql, sqlParam);
		return intro;
	}
	
}
