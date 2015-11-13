/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.common<br/>  
 * <b>文件名：</b>UUIDUtil.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月26日 上午9:28:11<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.common;

import java.util.UUID;

/**
 * @description UUID生成工具类
 * @createTime 2015年10月26日 上午9:28:11
 * @modifyTime
 * @author gaodsh@css.com.cn
 * @version 1.0
 */
public class UUIDUtil {

    /**
     * @description 生成不带“-”的UUID
     * @methodName generateUUID
     * @param
     * @returnType String
     * @throw
     */
    public static String generateUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }
}
