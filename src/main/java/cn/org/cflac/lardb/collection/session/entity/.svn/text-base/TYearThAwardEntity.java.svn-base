package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;


/**
 * The persistent class for the t_year_th_award database table.
 * 
 */
@Entity
@Table(name="t_year_th_award")
@NamedQuery(name="TYearThAwardEntity.findAll", query="SELECT t FROM TYearThAwardEntity t")
public class TYearThAwardEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="year_th_award_id")
	private String yearThAwardId;

	@Column(name="award_code")
	private String awardCode;

	@Column(name="award_year")
	private int awardYear;

	@Column(name="award_year_th")
	private int awardYearTh;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="last_modify_time")
	private Timestamp lastModifyTime;

	@Column(name="last_modify_user")
	private String lastModifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="year_th_id")
	private String yearThId;

	public TYearThAwardEntity() {
	}

	public String getYearThAwardId() {
		return this.yearThAwardId;
	}

	public void setYearThAwardId(String yearThAwardId) {
		this.yearThAwardId = yearThAwardId;
	}

	public String getAwardCode() {
		return this.awardCode;
	}

	public void setAwardCode(String awardCode) {
		this.awardCode = awardCode;
	}

	public int getAwardYear() {
		return this.awardYear;
	}

	public void setAwardYear(int awardYear) {
		this.awardYear = awardYear;
	}

	public int getAwardYearTh() {
		return this.awardYearTh;
	}

	public void setAwardYearTh(int awardYearTh) {
		this.awardYearTh = awardYearTh;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getInvalid() {
		return this.invalid;
	}

	public void setInvalid(String invalid) {
		this.invalid = invalid;
	}

	public Timestamp getLastModifyTime() {
		return this.lastModifyTime;
	}

	public void setLastModifyTime(Timestamp lastModifyTime) {
		this.lastModifyTime = lastModifyTime;
	}

	public String getLastModifyUser() {
		return this.lastModifyUser;
	}

	public void setLastModifyUser(String lastModifyUser) {
		this.lastModifyUser = lastModifyUser;
	}

	public String getOperStatus() {
		return this.operStatus;
	}

	public void setOperStatus(String operStatus) {
		this.operStatus = operStatus;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

}