package cn.org.cflac.lardb.collection.award.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;


/**
 * The persistent class for the t_award_unit database table.
 * 
 */
@Entity
@Table(name="t_award_unit")
@NamedQuery(name="TAwardUnitEntity.findAll", query="SELECT t FROM TAwardUnitEntity t")
public class TAwardUnitEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="award_unit_id")
	private String awardUnitId;

	@Column(name="award_id")
	private String awardId;

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

	@Column(name="unit_id")
	private String unitId;

	@Column(name="unit_mix")
	private String unitMix;

	@Column(name="unit_sort_number")
	private Integer unitSortNumber;

	@Column(name="unit_type_dict")
	private String unitTypeDict;

	public TAwardUnitEntity() {
	}

	public String getAwardUnitId() {
		return this.awardUnitId;
	}

	public void setAwardUnitId(String awardUnitId) {
		this.awardUnitId = awardUnitId;
	}

	public String getAwardId() {
		return this.awardId;
	}

	public void setAwardId(String awardId) {
		this.awardId = awardId;
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

	public String getUnitId() {
		return this.unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getUnitMix() {
		return this.unitMix;
	}

	public void setUnitMix(String unitMix) {
		this.unitMix = unitMix;
	}
	
	public Integer getUnitSortNumber() {
		return unitSortNumber;
	}

	public void setUnitSortNumber(Integer unitSortNumber) {
		this.unitSortNumber = unitSortNumber;
	}

	public String getUnitTypeDict() {
		return this.unitTypeDict;
	}

	public void setUnitTypeDict(String unitTypeDict) {
		this.unitTypeDict = unitTypeDict;
	}

}