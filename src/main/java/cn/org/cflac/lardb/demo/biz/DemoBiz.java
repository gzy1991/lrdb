/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.demo.biz<br/>  
 * <b>文件名：</b>DemoBiz.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月23日 上午10:30:47<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.demo.biz;

import java.util.ArrayList;
import java.util.List;

import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.demo.entity.DemoEntity;

/**
 * @description TODO
 * @createTime 2015年10月23日 上午10:30:47
 * @modifyTime
 * @author gaodsh@css.com.cn
 * @version 1.0
 */
public class DemoBiz {

    public List<DemoEntity> queryDemoList() {
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        List<DemoEntity> demos = new ArrayList<DemoEntity>();
        DemoEntity entity = new DemoEntity();
        entity.setRoleName("dddd");
        entity.setUserCode("hhhhhhhhh");
        demos.add(entity);
        return demos;
    }
}
