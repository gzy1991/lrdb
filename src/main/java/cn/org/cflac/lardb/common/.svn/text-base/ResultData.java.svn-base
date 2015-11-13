/**
 * <b>项目名：</b>dfbrck<br/>  
 * <b>包名：</b>cn.org.cflac.dfbrck.collection.artist.service<br/>  
 * <b>文件名：</b>ResultData.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月16日 下午5:29:19<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.common;

import java.util.List;

import cn.org.cflac.lardb.fileUpload.entity.TAttachmentDocument;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.annotation.JSONField;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;
import com.css.sword.web.response.SwordResponseFactory;

/**
 * @description 返回web前端json对象
 * @createTime 2015年10月16日 下午5:29:19
 * @modifyTime
 * @author gaodsh@css.com.cn
 * @version 1.0
 */
public class ResultData<T> {

    // grid列表对象
    @JSONField(name = "curPageData")
    // 前台接收时的名称
    private List<T> rows;

    // 总数
    @JSONField(name = "allDataCount")
    // 前台接收时的名称
    private Long total;

    // 实体对象
    private T entity;

    private ResultData(Builder<T> builder) {
        this.rows = builder.rows;
        this.total = builder.total;
        this.entity = builder.entity;
    }

    public static class Builder<T> {
        private List<T> rows;

        private Long total;

        private T entity;

        public Builder() {
        }

        public Builder(List<T> rows, Long total) {
            this.rows = rows;
            this.total = total;
        }

        public Builder(T entity) {
            this.entity = entity;
        }

        @SuppressWarnings("unchecked")
        public Builder<T> setListRows(JSONObject data) {

            List<T> entitylist = (List<T>) data.get("curPageData");       
            Long total = Long.parseLong(data.get("allDataCount").toString());
            
            this.setRows(entitylist).setTotal(total);
            return this;
        }
        
        public Builder<T> setRows(List<T> rows) {
            this.rows = rows;
            return this;
        }

        public Builder<T> setTotal(Long total) {
            this.total = total;
            return this;
        }

        public Builder<T> setEntity(T entity) {
            this.entity = entity;
            return this;
        }

        // 构造器入口
        public ISwordResponse build(ISwordRequest request) {
            ISwordResponse response = SwordResponseFactory.createSwordResponseInstance(request);
            response.setModel(new ResultData<T>(this));
            return response;
        }

        public ISwordResponse build() {
            ISwordResponse response = SwordResponseFactory.createSwordResponseInstance(null);
            response.setModel(new ResultData<T>(this));
            return response;
        }

    }

    public List<T> getRows() {
        return rows;
    }

    public Long getTotal() {
        return total;
    }

    public T getEntity() {
        return entity;
    }
}
