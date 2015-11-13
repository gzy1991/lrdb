/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.demo.entity<br/>  
 * <b>文件名：</b>DemoEntity.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月20日 下午1:56:34<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.demo.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.css.sword.core.kernel.base.dataElement.IValueObject;

/**
 * @description TODO
 * @createTime 2015年10月20日 下午1:56:34
 * @modifyTime
 * @author gaodsh@css.com.cn
 * @version 1.0
 */
public class DemoEntity implements IValueObject {

    private static final long serialVersionUID = 7891672768223654950L;

    private String userCode;

    private String roleName;

    private String userId;

    @JSONField(format="yyyy-MM-dd")
    private Date data;

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "DemoEntity [userCode=" + userCode + ", roleName=" + roleName + ", userId=" + userId + ", data=" + data + "]";
    }

}
