package com.css.sword.gzy.service;

import com.css.sword.core.kernel.base.annotation.ServiceContainer;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import cn.org.cflac.lardb.common.Paging;

import java.util.ArrayList;
import java.util.List;

import cn.org.cflac.lardb.collection.encyclopedia.entity.TEncyclopediaInfoEntity;
import cn.org.cflac.lardb.common.ResultData;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentInfo;
//import com.gs.test.Test;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.web.components.grid.Page;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;
import com.css.sword.web.response.SwordResponseFactory;

import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import com.css.sword.gzy.entity.Gzy;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;
import com.css.sword.web.response.SwordResponseFactory;

@ServiceContainer("/gzy/")
public class GzyService {

	/**
	 *测试接收参数
	 */
	@Service("receivePara") 
	public ISwordResponse receivePara(ISwordRequest req,String  pa)throws Exception{
		ISwordResponse res = SwordResponseFactory.createSwordResponseInstance(req);
		//IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		System.out.println(pa);
		res.setModel("receive para success: pa="+pa);
		return res;
	}
	
	
	/**
	 * 添加一个gzy
	 */
	@Service("addGzy") 
	public ISwordResponse addGzy(ISwordRequest req,Gzy gzy)throws Exception{
		ISwordResponse res = SwordResponseFactory.createSwordResponseInstance(req);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		dao.saveOrUpdate(gzy);
		res.setModel("add success!");
		return res;
	}
	
	/**
	 * 删除一个gzy
	 */
	@Service("deleteGzy") 
	public ISwordResponse deleteGzy(ISwordRequest req,Gzy gzy)throws Exception{
		ISwordResponse res = SwordResponseFactory.createSwordResponseInstance(req);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		dao.delete(gzy);
		res.setModel("delete success!");
		return res;
	}
	
	/**
	 * 获取全部gzy
	 */
	@Service("getGzyAll") 
	public ISwordResponse getGzyAll(ISwordRequest req) throws Exception {
		ISwordResponse res = SwordResponseFactory.createSwordResponseInstance(req);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		List<Gzy> gzyList = dao.findAllBySql(Gzy.class, "select * from gzy", null);
		res.setModel(gzyList);
		return res;
	}
	
	/**
	 * 获取一个gzy
	 */
	@Service("getGzy") 
	public ISwordResponse getGzy(ISwordRequest req ,Gzy gzy) throws Exception {
		ISwordResponse res = SwordResponseFactory.createSwordResponseInstance(req);
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String id=gzy.getTestId();
		List<Object> param = new ArrayList<Object>();
		param.add(gzy.getTestId());
		Gzy dbGzy=dao.findOneBySql(Gzy.class,  "select * from gzy where test_id=?", param.toArray());
		//Gzy dbGzy=dao.findOneByPrimaryKey(Gzy.class, testId);
		//List<Gzy> gzyList = dao.findAllBySql(Gzy.class, "select * from gzy", null);
		res.setModel(dbGzy);
		return res;
	}
	
	/**
	 * 获取人员列表，带分页
	 * 
	 */
	@Service("getGzyPage")
	public ISwordResponse getMenuJson(ISwordRequest req) throws Exception {
		
		
		ISwordResponse res = SwordResponseFactory.createSwordResponseInstance(req);
		try {
			String sql = "select * from gzy";
			res.setModel(new Page(req).getData(sql, null));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
}
