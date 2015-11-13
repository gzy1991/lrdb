package cn.org.cflac.lardb.collection.classics.periodical.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_periodical_columntree database table.
 * 
 */
@Entity
@Table(name="t_periodical_columntree")
@NamedQuery(name="TPeriodicalColumntreeEntity.findAll", query="SELECT t FROM TPeriodicalColumntreeEntity t")
public class TPeriodicalColumntreeEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="columntree_pertree_id")
	private String columntreePertreeId;

	@Column(name="columntree_name")
	private String columntreeName;

	@Column(name="columntree_name_en")
	private String columntreeNameEn;

	@Column(name="columntree_ppertree_id")
	private String columntreePpertreeId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="lastmodify_time")
	private Timestamp lastmodifyTime;

	@Column(name="lastmodify_user")
	private String lastmodifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="org_code")
	private String orgCode;

	@Column(name="periodical_id")
	private String periodicalId;

	public TPeriodicalColumntreeEntity() {
	}

	public String getColumntreePertreeId() {
		return this.columntreePertreeId;
	}

	public void setColumntreePertreeId(String columntreePertreeId) {
		this.columntreePertreeId = columntreePertreeId;
	}

	public String getColumntreeName() {
		return this.columntreeName;
	}

	public void setColumntreeName(String columntreeName) {
		this.columntreeName = columntreeName;
	}

	public String getColumntreeNameEn() {
		return this.columntreeNameEn;
	}

	public void setColumntreeNameEn(String columntreeNameEn) {
		this.columntreeNameEn = columntreeNameEn;
	}

	public String getColumntreePpertreeId() {
		return this.columntreePpertreeId;
	}

	public void setColumntreePpertreeId(String columntreePpertreeId) {
		this.columntreePpertreeId = columntreePpertreeId;
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

	public Timestamp getLastmodifyTime() {
		return this.lastmodifyTime;
	}

	public void setLastmodifyTime(Timestamp lastmodifyTime) {
		this.lastmodifyTime = lastmodifyTime;
	}

	public String getLastmodifyUser() {
		return this.lastmodifyUser;
	}

	public void setLastmodifyUser(String lastmodifyUser) {
		this.lastmodifyUser = lastmodifyUser;
	}

	public String getOperStatus() {
		return this.operStatus;
	}

	public void setOperStatus(String operStatus) {
		this.operStatus = operStatus;
	}

	public String getOrgCode() {
		return this.orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getPeriodicalId() {
		return this.periodicalId;
	}

	public void setPeriodicalId(String periodicalId) {
		this.periodicalId = periodicalId;
	}

}