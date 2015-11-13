package com.css.sword.gzy.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.css.sword.core.kernel.base.dataElement.AbsPersistObject;


@Entity
@Table(name="gzy")
/*@NamedQuery(name="gzy.findAll", query="SELECT o FROM gzy o")
*/
public class Gzy extends AbsPersistObject implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="test_id")
	private String  testId;
	@Column(name="test_name")
	private String testName;
	
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
}
