/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>CommentRelService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:33:59<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TYearThCommentRelEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:33:59
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class CommentRelService {

	public void save(List<TYearThCommentRelEntity> comments , String sessionId) throws SwordBaseCheckedException{
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		//查询已存在关联评论
		String yearThCommentIds = "";
		String sql = "select * from t_year_th_comment_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThCommentRelEntity> commentList = dao.findAllBySql(TYearThCommentRelEntity.class, sql, param);
		
		//保存关联评论
		for(TYearThCommentRelEntity comment : comments){
			comment.setYearThId(sessionId);
			if(StringHelper.isEmpty(comment.getYearThCommentId())){
				comment.setYearThCommentId(UUIDUtil.generateUUID());
			}else{
				yearThCommentIds += (comment.getYearThCommentId() + " ");
			}
			dao.saveOrUpdate(comment);
		}
		
		//删除关联评论
		for(TYearThCommentRelEntity entity : commentList){
			if(yearThCommentIds.indexOf(entity.getYearThCommentId()) < 0){
				dao.delete(entity);
			}
		}
	}
	
	public List<TYearThCommentRelEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_comment_rel t where t.year_th_id=?";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThCommentRelEntity> comments = dao.findAllBySql(TYearThCommentRelEntity.class, sql, param);
		return comments;
	}
	
}
