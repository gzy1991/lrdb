package cn.org.cflac.lardb.collection.classics.periodical.entity;

import java.io.Serializable;

import javax.persistence.*;

import cn.org.cflac.lardb.common.UUIDUtil;

import java.sql.Timestamp;


/**
 * The persistent class for the t_periodica_unit database table.
 * 
 */
@Entity
@Table(name="t_periodica_unit")
@NamedQuery(name="TPeriodicaUnitEntity.findAll", query="SELECT t FROM TPeriodicaUnitEntity t")
public class TPeriodicaUnitEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="unit_id")
	private String unitId;

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

	@Column(name="unit_name_id")
	private String unitNameId;

	@Column(name="unit_name_mix")
	private String unitNameMix;

	@Column(name="unit_type")
	private String unitType;

	public TPeriodicaUnitEntity() {
		this.unitId = UUIDUtil.generateUUID();
	}

	public String getUnitId() {
		return this.unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
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

	public String getUnitNameId() {
		return this.unitNameId;
	}

	public void setUnitNameId(String unitNameId) {
		this.unitNameId = unitNameId;
	}

	public String getUnitNameMix() {
		return this.unitNameMix;
	}

	public void setUnitNameMix(String unitNameMix) {
		this.unitNameMix = unitNameMix;
	}

	public String getUnitType() {
		return this.unitType;
	}

	public void setUnitType(String unitType) {
		this.unitType = unitType;
	}

}