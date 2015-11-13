
package cn.org.cflac.lardb.collection.encyclopedia.service;

import java.util.ArrayList;
import java.util.List;

import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentInfo;

import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.web.components.grid.Page;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;
/**
 * 
 * @description 附件信息表的CRUD
 * @createTime 2015年10月30日 下午2:12:51
 * @modifyTime 
 * @author ganbing@css.com.cn
 * @version 1.0
 */
@ServiceContainer("collection/encyclopedia")
public class AttachmentInfoService {
	
	private static final String TABLEOFATTACHMENT = "t_attachment_info t";
	
	/**
	 * 
	 * @description 根据附件名称查询
	 * @methodName queryBypicName
	 * @param
	 * @throws Exception 
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("queryBypicName")
	public ISwordResponse queryBypicName(ISwordRequest req) throws Exception {
		
		String querySql = "select * from " +TABLEOFATTACHMENT+ " where ";
		String encyTitleStr = "%" + req.getData("attachmentName") + "%";
		
		List<String> param = new ArrayList<String>();
		param.add(encyTitleStr);
		
		querySql += "attachment_name like ? ";
        
		return new ResultData.Builder<TAttachmentInfo>().setListRows(new Page(req).getData(TAttachmentInfo.class, querySql,param.toArray())).build();
		
	}
	
	public TAttachmentInfo queryDetailInfo(String strId){
	    
	    return SwordPersistenceUtils.getPersistenceService().findOneByPrimaryKey(TAttachmentInfo.class, strId);
	}
}
 