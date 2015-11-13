package com.css.sword.yaosiyu.entity;




import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.css.sword.core.kernel.base.dataElement.AbsPersistObject;
import com.css.sword.gzy.entity.Gzy;


@Entity
@Table(name="yaosiyutest")
public class Test extends AbsPersistObject implements Serializable{
	
	
	
	@Id
	@Column(name="test_id")
	private  String testId;		//id
	@Column(name="test_name")
	private String testName;	//名字
	@Transient
	private List<Gzy> list;
	
	
	public String getTestId() {
		return testId;
	}
	public void setTestId(String testId) {
		this.testId = testId;
	}
	public String getTestName() {
		return testName;
	}
	public void setTestName(String testName) {
		this.testName = testName;
	}
	public List<Gzy> getList() {
		return list;
	}
	public void setList(List<Gzy> list) {
		this.list = list;
	}
	
	
}
