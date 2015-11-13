package cn.org.cflac.lardb.fileUpload.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 
 * @description 路径获取帮助类
 * @createTime 2015年10月28日 下午4:25:15
 * @modifyTime 
 * @author liwei@css.com.cn
 * @version 1.0
 */
public class PathUtil {
	
    /**
     * 
     * @description 获取发布工程物理路径
     * @methodName getPublishPath
     * @param
     * @returnType String   
     * @throw
     */
	public String getPublishPath(){
		Properties properties = new Properties();
		String path=null;
	    InputStream in = this.getClass().getResourceAsStream("/fileUpload.properties");
		try {
			if(null!= in && !"".equals(in)){
				properties.load(in);
				path=properties.getProperty("fileUploadPath");
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return path;
	}
	
	/**
	 * 
	 * @description 获取本地工程路径
	 * @methodName getWebappPath
	 * @param
	 * @returnType String   
	 * @throw
	 */
	public String getWebappPath(){
		/*
		 *得到路径的格式d:/tomcat/webapps/工程名WEB-INF/classes/路径  
		 */
		String path=this.getClass().getResource("/").getPath();
		/*
		 *从路径字符串中取出工程路路径
		 */
		path=path.substring(1, path.indexOf("WEB-INF/classes"));
		return path;
	}
	
	/**
	 * 
	 * @description 判断文件夹是否存在，不存在则创建
	 * @methodName isFilePath
	 * @param
	 * @returnType void   
	 * @throw
	 */
	public void isFilePath(String path) {
		File file = new File(path);
		if (!file.isDirectory()) {
			file.mkdirs();
		}
	}
}
