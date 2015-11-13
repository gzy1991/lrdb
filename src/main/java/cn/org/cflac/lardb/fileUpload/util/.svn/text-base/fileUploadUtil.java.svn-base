package cn.org.cflac.lardb.fileUpload.util;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

/**
 * 
 * @description 附件上传帮助类
 * @createTime 2015年10月28日 下午4:26:34
 * @modifyTime 
 * @author liwei@css.com.cn
 * @version 1.0
 */
public class fileUploadUtil {
    
    /**
     * 
     * @description 根据文件类型获取文件分类
     * @methodName getPostfix
     * @param
     * @returnType String   
     * @throw
     */
	public String getPostfix(String type){
		return mFileTypes.get(type);
	}
	
	/**
	 * 
	 * @description 根据业务表id获取文件类型
	 * @methodName getTypeById
	 * @param
	 * @returnType String   
	 * @throw
	 */
	public String getTypeById(String id){
	    IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
	    /*
         * 处理逻辑：首先根据业务表id查询该id对应的附件类型
         */
        String sql = "select 'file' as type from t_attachment_file t,"
                + " t_attachment_info info where t.attachment_id=info.attachment_id"
                + " and t.file_id=? union all select 'picture' as type"
                + " from t_attachment_picture t,t_attachment_info info"
                + " where t.attachment_id=info.attachment_id and t.picture_id=?"
                + " union ALL select 'audio' as type"
                + " from t_attachment_audio t,t_attachment_info info"
                + " where t.attachment_id=info.attachment_id and t.audio_id=?"
                + " union ALL select 'video' as type"
                + " from t_attachment_video t,t_attachment_info info"
                + " where t.attachment_id=info.attachment_id and t.video_id=?";
        List param = new ArrayList<Object>();
        param.add(id);
        Object[] paramObj = null;
        if (null != param && param.size() > 0) {
            paramObj = param.toArray();
        }
	    Map resultMap=dao.findOneBySql(sql, paramObj);
	    String type=null;
	    if(null!=resultMap && resultMap.size()>0){
	        type=(String)resultMap.get("type");
	    }
	    return type;
    }
	
	/**
	 * 
	 * @description 根据业务表id获取附件信息和附件的文件类型
	 * @methodName getFileInfoAndTypeById
	 * @param
	 * @returnType String   
	 * @throw
	 */
	public Map getFileInfoAndTypeById(String id){
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        /*
         * 处理逻辑：首先根据业务表id查询该id对应的附件信息和附件的文件类型
         */
        String sql = "select info.*,'file' as type from t_attachment_file t,"
                + " t_attachment_info info where t.attachment_id=info.attachment_id"
                + " and t.file_id=? union all select info.*,'picture' as type"
                + " from t_attachment_picture t,t_attachment_info info"
                + " where t.attachment_id=info.attachment_id and t.picture_id=?"
                + " union ALL select info.*,'audio' as type from t_attachment_audio t,"
                + " t_attachment_info info where t.attachment_id=info.attachment_id"
                + " and t.audio_id=? union ALL select info.*,'video' as type"
                + " from t_attachment_video t,t_attachment_info info"
                + " where t.attachment_id=info.attachment_id and t.video_id=?";
        List param = new ArrayList<Object>();
        param.add(id);
        Object[] paramObj = null;
        if (null != param && param.size() > 0) {
            paramObj = param.toArray();
        }
        Map resultMap=dao.findOneBySql(sql, paramObj);
        return resultMap;
    }
 	/*
    * 缓存各类后缀的资源类型分类
    */
   public static final HashMap<String, String> mFileTypes = new HashMap<String, String>();
   static {
	   mFileTypes.put("doc", "document");
	   mFileTypes.put("docx", "document");
	   mFileTypes.put("ppt", "document");
	   mFileTypes.put("pptx", "document");
	   mFileTypes.put("xls", "document");
	   mFileTypes.put("xlsx", "document");
	   mFileTypes.put("pdf", "document");
	   mFileTypes.put("png", "picture");
	   mFileTypes.put("bmp", "picture");
	   mFileTypes.put("jpg", "picture");
	   mFileTypes.put("tiff", "picture");
	   mFileTypes.put("gif", "picture");
	   mFileTypes.put("mp4", "video");
	   mFileTypes.put("flv", "video");
	   mFileTypes.put("avi", "video");
	   mFileTypes.put("wmv", "video");
	   mFileTypes.put("rmvb", "video");
	   mFileTypes.put("mov", "video");
	   mFileTypes.put("mpg", "video");
	   mFileTypes.put("gif", "video");
	   mFileTypes.put("mp3", "audio");
	   mFileTypes.put("wma", "audio");
	   mFileTypes.put("wav", "audio");
   }
}
