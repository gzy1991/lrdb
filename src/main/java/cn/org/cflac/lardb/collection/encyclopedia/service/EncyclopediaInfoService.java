package cn.org.cflac.lardb.collection.encyclopedia.service;

import java.util.ArrayList;
import java.util.List;

import cn.org.cflac.lardb.collection.encyclopedia.entity.TEncyclopediaInfoEntity;
import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.common.UUIDUtil;

import com.alibaba.fastjson.JSON;
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
 * @description 百科基本信息表的CRUD
 * @createTime 2015年10月30日 上午11:43:17
 * @modifyTime 
 * @author ganbing@css.com.cn
 * @version 1.0
 */
@ServiceContainer("collection/encyclopedia")
public class EncyclopediaInfoService {

    private static final String TABLEOFENCYCLOPDIAINFO = "t_encyclopedia_info t";

/**
 * 
 * @description 添加或者更新百科基本信息表
 * @methodName saveOrUpdate
 * @param
 * @throws SwordBaseCheckedException 
 * @returnType ISwordResponse   
 * @throw
 */
    @Service("saveOrUpdate")
    public ISwordResponse saveOrUpdate(ISwordRequest req) throws SwordBaseCheckedException {

        TEncyclopediaInfoEntity entity = JSON.parseObject(req.getData("entityInfo"), TEncyclopediaInfoEntity.class);

        if ( SwordStringUtils.isEmpty(entity.getEncyclopediaId()) ){
           
            entity.setEncyclopediaId(UUIDUtil.generateUUID());
        }
        
        SwordPersistenceUtils.getPersistenceService().saveOrUpdate(entity);

        return new ResultData.Builder<TEncyclopediaInfoEntity>().setEntity(entity).build();

    }

    /**
     * 
     * @description 
     * @methodName delete
     * @param
     * @throws SwordBaseCheckedException 
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("delete")
    public ISwordResponse delete(ISwordRequest req) throws SwordBaseCheckedException {

        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();

        String[] strIDs = req.getData("encyclopediaId").split(",");

        for ( String strid : strIDs ){
            
            dao.deleteByprimaryKey(TEncyclopediaInfoEntity.class, strid);
        }

        return new ResultData.Builder<TEncyclopediaInfoEntity>().build();
    }

    /**
     * 
     * @description 根据查询条件查询百科信息
     * @methodName list
     * @param
     * @throws Exception 
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("list")
    public ISwordResponse list(ISwordRequest req, TEncyclopediaInfoEntity entity) throws Exception {

        String querySql = "select * from " + TABLEOFENCYCLOPDIAINFO  + " where t.invalid='N' ";
        List<String> param = new ArrayList<String>();

        if ( !SwordStringUtils.isEmpty(entity.getEncyclopediaTitle()) ){
            querySql += " and t.encyclopedia_title=? ";
            param.add(entity.getEncyclopediaTitle());
        }
        if ( !SwordStringUtils.isEmpty(entity.getEncyclopediaSource()) ){
            querySql += " and t.encyclopedia_source=? ";
            param.add(entity.getEncyclopediaSource());
        }
        
        if ( !SwordStringUtils.isEmpty(entity.getArtTypeDict()) ){
            querySql += " and t.art_type_dict=? ";
            param.add(entity.getArtTypeDict());
        }
        if ( !SwordStringUtils.isEmpty(entity.getEncyclopediaTypeDict()) ){
            querySql += " and t.encyclopedia_type_dict=? ";
            param.add(entity.getEncyclopediaTypeDict());
        }
        
        querySql += "order by t.lastmodify_time desc";
        
        return new ResultData.Builder<TEncyclopediaInfoEntity>().setListRows(new Page(req).getData(TEncyclopediaInfoEntity.class, querySql,param.toArray())).build();
        
    }

    /**
     * 
     * @description 根据百科ID查询百科信息
     * @methodName querybyID
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("queryById")
    public ISwordResponse querybyID(ISwordRequest req) {

        TEncyclopediaInfoEntity entity = SwordPersistenceUtils.getPersistenceService().findOneByPrimaryKey(TEncyclopediaInfoEntity.class,req.getData("encyclopediaId"));
        
        return new ResultData.Builder<TEncyclopediaInfoEntity>().setEntity(entity).build();
    }


}
