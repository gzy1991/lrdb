package com.css.sword.yaosiyu.service;




import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.type.YesNoType;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.gzy.entity.Gzy;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;
import com.css.sword.web.response.SwordResponseFactory;
import com.css.sword.yaosiyu.entity.Test;

import cn.org.cflac.lardb.common.ResultData;

import com.css.sword.web.components.grid.Page;

@ServiceContainer("/test/")
public class TestService {

	/**
	 * 获取全部数据
	 */
	@Service("getTestAll") 
	public ISwordResponse getyaosiyutestAll(ISwordRequest req) throws Exception {
		
		ISwordResponse res = SwordResponseFactory.createSwordResponseInstance(req);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String reqStr = req.getData("ysy");
		Test ysy = JSON.parseObject(reqStr, Test.class);
		List<Gzy> gzy = ysy.getList();
		ysy.setTestId("ysy");
		
//		List<Test> menuList = dao.findAllBySql(Test.class, "select * from yaosiyutest", new Object[]{});
//		res.setModel(menuList);
		
		return new ResultData.Builder<Test>().setEntity(ysy).build();
		
//		return res;
	}
/*	@Service(value="queryTestByPage",memo="分页查询Test")
	public ISwordResponse queryTestByPage(ISwordRequest iReq) throws SwordBaseCheckedException {
		ISwordResponse iRes = SwordResponseFactory.createSwordResponseInstance(iReq);
		ServiceResult result=new ServiceResult();
		try {
			List<Test> recordList=new ArrayList<Test>();
			String parentId=iReq.getData("parentId");
			if (StringUtil.checkStringValue(parentId)) {
				String jpql="select t as student from Student t where t.gradeId=?1 ";
				Integer parentIdVal=new Integer(parentId);
				recordList=(List<Test>)new Page(iReq).getData(jpql, new Object[]{parentIdVal}, Test.class);
			}
			result.setData(recordList);
		} catch (Exception e) {

			// TODO: change ERROR Info
			// logger.error("提示错误信息",new SwordBaseCheckedException(异常码, 原始异常对象));
		}
		iRes.setModel(result);
		return iRes;
	}*/
	
	
	
}
