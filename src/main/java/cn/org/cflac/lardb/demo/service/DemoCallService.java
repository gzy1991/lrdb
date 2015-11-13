/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.demo.service<br/>  
 * <b>文件名：</b>DemoCallService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月23日 上午9:38:21<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.demo.service;

import java.util.List;

import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.demo.entity.DemoEntity;

import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;

/**
 * @description TODO
 * @createTime 2015年10月23日 上午9:38:21
 * @modifyTime
 * @author gaodsh@css.com.cn
 * @version 1.0
 */
@ServiceContainer("demoCallService")
public class DemoCallService {
    private static final SwordLogUtils logger = SwordLogUtils.getLogger(DemoCallService.class);

    @Service("list")
    public ISwordResponse list(ISwordRequest request) throws SwordBaseCheckedException {
        logger.debug("");
        List<DemoEntity> demos = null;
        return new ResultData.Builder<DemoEntity>().setRows(demos).setTotal(1L).build();
    }

}
