package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_activity_address_organ database table.
 * 
 */
@Entity
@Table(name="t_activity_address_organ")
@NamedQuery(name="TActivityAddressOrganEntity.findAll", query="SELECT t FROM TActivityAddressOrganEntity t")
public class TActivityAddressOrganEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="activity_address_coorganizer_id")
	private String activityAddressCoorganizerId;

	@Column(name="activity_id")
	private String activityId;

	@Column(name="coorganizer_id")
	private String coorganizerId;

	@Column(name="coorganizer_mix")
	private String coorganizerMix;

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

	public TActivityAddressOrganEntity() {
	}

	public String getActivityAddressCoorganizerId() {
		return this.activityAddressCoorganizerId;
	}

	public void setActivityAddressCoorganizerId(String activityAddressCoorganizerId) {
		this.activityAddressCoorganizerId = activityAddressCoorganizerId;
	}

	public String getActivityId() {
		return this.activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getCoorganizerId() {
		return this.coorganizerId;
	}

	public void setCoorganizerId(String coorganizerId) {
		this.coorganizerId = coorganizerId;
	}

	public String getCoorganizerMix() {
		return this.coorganizerMix;
	}

	public void setCoorganizerMix(String coorganizerMix) {
		this.coorganizerMix = coorganizerMix;
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

}