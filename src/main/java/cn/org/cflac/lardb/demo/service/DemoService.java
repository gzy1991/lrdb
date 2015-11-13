/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.demo<br/>  
 * <b>文件名：</b>DemoService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月20日 下午1:25:14<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.demo.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import cn.org.cflac.lardb.common.Paging;
import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.common.UUIDUtil;
import cn.org.cflac.lardb.demo.biz.DemoBiz;
import cn.org.cflac.lardb.demo.entity.DemoEntity;
import cn.org.cflac.lardb.demo.entity.NewsInfoEntity;

import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;

/**
 * @description 测试架构返回数据
 * @createTime 2015年10月20日 下午1:25:14
 * @modifyTime
 * @author gaodsh@css.com.cn
 * @version 1.0
 */
@ServiceContainer("demoService")
public class DemoService {

    private static final SwordLogUtils logger = SwordLogUtils.getLogger(DemoService.class);

    @Inject
    private DemoBiz demoBiz;

    @Service("list")
    public ISwordResponse list(ISwordRequest request, DemoEntity entity) {
        logger.debug("列表查询--->>> " + entity.getUserCode());
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        String sql = "select user_code,user_name role_name from org_user";
        List<DemoEntity> demos = dao.findAllBySql(DemoEntity.class, sql);
        return new ResultData.Builder<DemoEntity>().setRows(demos).build();
    }

    @Service("slist")
    public ISwordResponse slist(ISwordRequest request, DemoEntity entity) {
        logger.debug("封装列表查询--->>> " + entity.getUserCode());
        List<DemoEntity> demos = demoBiz.queryDemoList();
        return new ResultData.Builder<DemoEntity>().setRows(demos).build();
    }

    @Service("page")
    public ISwordResponse page(ISwordRequest request, Paging paging) {
        logger.debug("分页查询--->>> " + paging.toString());
        logger.debug("分页对象pageNum从1开始--->>> ");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        String sql = "select user_code,user_name role_name from org_user";
        String sqlCount = "select count(*) total from org_user";
        // 查询列表数据
        List<DemoEntity> demos = dao.findAllBySqlWithPaging(DemoEntity.class, sql, paging.getCurPage(), paging.getPageSize());
        // 查询总条数
        Map<String, Object> map = dao.findOneBySql(sqlCount);
        Long total = Long.parseLong(map.get("total").toString());
        return new ResultData.Builder<DemoEntity>().setRows(demos).setTotal(total).build();
    }

    @Service("sqlInject")
    public ISwordResponse sqlInject(ISwordRequest request, DemoEntity entity) {
        logger.debug("测试SQL注入--->>> " + entity.toString());
        // userCode= "dsfsdfs%' or 1=1 or 1 = '%1";
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        String sql = "select user_code,user_name role_name from org_user where user_name like '%" + entity.getUserCode() + "%'";
        List<DemoEntity> demos = dao.findAllBySql(DemoEntity.class, sql);

        // String sql2
        // ="select user_code,user_name role_name from org_user where user_name like '%?%'";
        // List<DemoEntity> demos2 =
        // dao.findAllBySql(DemoEntity.class,sql2,entity.getUserCode());
        return new ResultData.Builder<DemoEntity>().setRows(demos).build();
    }

    @Service("save")
    public ISwordResponse save(ISwordRequest request, DemoEntity entity) throws SwordBaseCheckedException {
        logger.debug("添加修改--->>> " + entity.toString());
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        NewsInfoEntity info = new NewsInfoEntity();
        info.setTemplateId("rrrrrrrrrrrrrrrr");
        info.setArtType("dddddddddddddddddddd");
        info.setNewsId(UUIDUtil.generateUUID());
        boolean flag = dao.saveOrUpdate(info);
        logger.debug("添加修改是否成功--->>> " + flag);
        return new ResultData.Builder<NewsInfoEntity>().setEntity(info).build();
    }
    
    
    /**
     * @description url 要这么写才能接收到数据
     *<p> /query/123/ </p>
     *<p> 123会自动赋值到id上，关键是123后面的"/"一定要加 </p>
     * @methodName query
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("query")
    public ISwordResponse query(ISwordRequest request, String  id) {
        logger.debug("查询--->>> " + id);
        return new ResultData.Builder<NewsInfoEntity>().build();
    }
    
    
    @Service("statistics")
    public ISwordResponse statistics(ISwordRequest request) {
        logger.debug("统计查询--->>> ");
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("333", "ddddd");
        map.put("555", "ddddd");
        map.put("666", "ddddd");
        map.put("777", "ddddd");
        List<Map<String,Object>> list = new ArrayList<>();
        list.add(map);
        return new ResultData.Builder<Map<String,Object>>().setRows(list).build();
    }
    
    
    @Service("date")
    public ISwordResponse date(ISwordRequest request) {
        logger.debug("返回日期查询--->>> ");
        DemoEntity entity = new DemoEntity();
        entity.setData(new Date());
        return new ResultData.Builder<DemoEntity>().setEntity(entity).build();
    }
    
    
    
    
    
    

}
