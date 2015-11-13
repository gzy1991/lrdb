
package cn.org.cflac.lardb.document.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import cn.org.cflac.lardb.collection.encyclopedia.service.AttachmentInfoService;
import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentDocument;

import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.SwordStringUtils;
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
@ServiceContainer("document/attachmentfile")
public class AttachmentFileService {
	
	private static final String TABLEOFATTACHMENT = "t_attachment_document t";
	
	@Inject
	private AttachmentInfoService attachInfoService;
	/**
	 * 
	 * @description 查询
	 * @methodName query
	 * @param
	 * @throws Exception 
	 * @returnType ISwordResponse   
	 * @throw
	 */
    @Service("query")
	public ISwordResponse query(ISwordRequest req, TAttachmentDocument entity) throws Exception {
		
		String querySql = "select * from " +TABLEOFATTACHMENT+ " where t.invalid='N' ";
		List<Object> param = new ArrayList<Object>();
		
		if ( !SwordStringUtils.isEmpty(entity.getDocumentName()) ){
		    querySql += " and t.document_name=? ";
		    param.add(entity.getDocumentName());
		}
		if ( !SwordStringUtils.isEmpty(entity.getDocumentTypeDict()) ){
            querySql += " and t.document_type_dict=? ";
            param.add(entity.getDocumentTypeDict());
        }
		if ( !SwordStringUtils.isEmpty(entity.getArtTypeDict()) ){
            querySql += " and t.art_type_dict=? ";
            param.add(entity.getArtTypeDict());
        }
		
		if ( !SwordStringUtils.isEmpty(entity.getOrgCode()) ){
		    querySql += " and t.org_code=? ";
		    param.add(entity.getOrgCode());
		}
		if ( !SwordStringUtils.isEmpty(entity.getDocumentLevelDict()) ){
		    querySql += " and t.document_level_dict=? ";
		    param.add(entity.getDocumentLevelDict());
		}
		if ( !SwordStringUtils.isEmpty(entity.getDocumentStateDict()) ){
		    querySql += " and t.document_state_dict=? ";
		    param.add(entity.getDocumentStateDict());
		}
		if ( !SwordStringUtils.isEmpty(req.getData("beginTime")) 
		        && !SwordStringUtils.isEmpty(req.getData("endTime")) ){
		    
		    querySql += " and t.create_time between ? and ? ";
		    param.add((Timestamp.valueOf(req.getData("beginTime")+" 00:00:00")));
            param.add((Timestamp.valueOf(req.getData("endTime")+" 00:00:00")));
		}
		querySql += "order by t.last_modify_time desc";
		     
		return new ResultData.Builder<TAttachmentDocument>().setListRows(new Page(req).getData(TAttachmentDocument.class, querySql,param.toArray())).build();
	}
	
	/**
	 * 
	 * @description 更新文档启用状态
	 * @methodName Update
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("Update")
    public ISwordResponse Update(ISwordRequest req, TAttachmentDocument doc) throws SwordBaseCheckedException {

        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

        TAttachmentDocument entity = dao.findOneByPrimaryKey(TAttachmentDocument.class, doc.getDocumentId());
        entity.setDocumentStateDict(doc.getDocumentStateDict());
        
        dao.saveOrUpdate(entity);

        return new ResultData.Builder<TAttachmentDocument>().setEntity(entity).build();

    }
	
	/**
	 * 
	 * @description 通过文档ID查询
	 * @methodName querybyID
	 * @param
	 * @returnType ISwordResponse   
	 * @throw
	 */
	@Service("queryById")
    public ISwordResponse querybyID(ISwordRequest req) {

        TAttachmentDocument entity = SwordPersistenceUtils.getPersistenceService().findOneByPrimaryKey(TAttachmentDocument.class,req.getData("documentId"));
        
        entity.setAttachdetailinfo(attachInfoService.queryDetailInfo(entity.getAttachmentId()));

        return new ResultData.Builder<TAttachmentDocument>().setEntity(entity).build();
    }
}
 