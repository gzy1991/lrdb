
package cn.org.cflac.lardb.formatTypesetting.service;

import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.formatTypesetting.entity.TFormatTypesetting;

import com.alibaba.fastjson.JSON;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;

@ServiceContainer("ckeditor/formatTypeSetting")
public class FormatTypesettingService {
	
	private static final String TABLEOFFORMAT = "t_format_typesetting t";
	
	/**
	 * 
	 * @description 更新
	 * @methodName Update
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("Update")
    public ISwordResponse Update(ISwordRequest req, TFormatTypesetting doc) throws SwordBaseCheckedException {

        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

        TFormatTypesetting entity = JSON.parseObject(req.getData("entityInfo"),TFormatTypesetting.class);
        
        dao.saveOrUpdate(entity);

        return new ResultData.Builder<TFormatTypesetting>().setEntity(entity).build();

    }
	
	/**
	 * 
	 * @description 通过ID查询
	 * @methodName query
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("query")
    public ISwordResponse query(ISwordRequest req) {

        TFormatTypesetting entity = SwordPersistenceUtils.getPersistenceService().findOneByPrimaryKey(TFormatTypesetting.class,req.getData("formatsettingId"));
        
        //entity.setAttachdetailinfo(attachInfoService.queryDetailInfo(entity.getAttachmentId()));

        return new ResultData.Builder<TFormatTypesetting>().setEntity(entity).build();
    }
}
 