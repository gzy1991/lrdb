package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_year_th_others_rel database table.
 * 
 */
@Entity
@Table(name="t_year_th_others_rel")
@NamedQuery(name="TYearThOthersRelEntity.findAll", query="SELECT t FROM TYearThOthersRelEntity t")
public class TYearThOthersRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="t_year_th_others_id")
	private String tYearThOthersId;

	@Column(name="others_id")
	private String othersId;

	@Column(name="year_th_id")
	private String yearThId;
	
	@Transient
	private String yearThTitle;
	
	@Transient
	private String yearThInfo;

	public TYearThOthersRelEntity() {
	}

	public String getTYearThOthersId() {
		return this.tYearThOthersId;
	}

	public void setTYearThOthersId(String tYearThOthersId) {
		this.tYearThOthersId = tYearThOthersId;
	}

	public String getOthersId() {
		return this.othersId;
	}

	public void setOthersId(String othersId) {
		this.othersId = othersId;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public String getYearThTitle() {
		return yearThTitle;
	}

	public void setYearThTitle(String yearThTitle) {
		this.yearThTitle = yearThTitle;
	}

	public String getYearThInfo() {
		return yearThInfo;
	}

	public void setYearThInfo(String yearThInfo) {
		this.yearThInfo = yearThInfo;
	}
	
}