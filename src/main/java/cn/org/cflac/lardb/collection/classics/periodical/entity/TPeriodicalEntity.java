/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.classics.periodical.entity<br/>  
 * <b>文件名：</b>TPeriodicalEntity.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月22日 下午5:17:46<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.classics.periodical.entity;

import java.util.ArrayList;


/**
 * @description TODO
 * @createTime 2015年10月22日 下午5:17:46
 * @modifyTime 
 * @author zhanglei@css.com.cn
 * @version 1.0
 */
public class TPeriodicalEntity {
	private TPeriodicalInfoEntity periodicalInfoEntity;
	private ArrayList<TPeriodicalInfoEntity> periodicalInfoListEntity;
	private TPeriodicalColumntreeEntity periodicalColumntreeEntity;
	private ArrayList<TPeriodicalColumntreeEntity> periodicalColumntreeListEntity;
	private String entity;
	private ArrayList<String> entityList;
	public TPeriodicalEntity(){
		
	}
	
	public TPeriodicalInfoEntity getPeriodicalInfoEntity() {
		return periodicalInfoEntity;
	}
	public void setPeriodicalInfoEntity(TPeriodicalInfoEntity periodicalInfoEntity) {
		this.periodicalInfoEntity = periodicalInfoEntity;
	}
	public ArrayList<TPeriodicalInfoEntity> getPeriodicalInfoListEntity() {
		return periodicalInfoListEntity;
	}
	public void setPeriodicalInfoListEntity(
			ArrayList<TPeriodicalInfoEntity> periodicalInfoListEntity) {
		this.periodicalInfoListEntity = periodicalInfoListEntity;
	}
	public TPeriodicalColumntreeEntity getPeriodicalColumntreeEntity() {
		return periodicalColumntreeEntity;
	}
	public void setPeriodicalColumntreeEntity(
			TPeriodicalColumntreeEntity periodicalColumntreeEntity) {
		this.periodicalColumntreeEntity = periodicalColumntreeEntity;
	}
	public ArrayList<TPeriodicalColumntreeEntity> getPeriodicalColumntreeListEntity() {
		return periodicalColumntreeListEntity;
	}
	public void setPeriodicalColumntreeListEntity(
			ArrayList<TPeriodicalColumntreeEntity> periodicalColumntreeListEntity) {
		this.periodicalColumntreeListEntity = periodicalColumntreeListEntity;
	}
	public String getEntity() {
		return entity;
	}
	public void setEntity(String entity) {
		this.entity = entity;
	}
	public ArrayList<String> getEntityList() {
		return entityList;
	}
	public void setEntityList(ArrayList<String> entityList) {
		this.entityList = entityList;
	}
}
