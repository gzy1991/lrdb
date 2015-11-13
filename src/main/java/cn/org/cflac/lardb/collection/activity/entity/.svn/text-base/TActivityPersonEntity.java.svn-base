package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_activity_person database table.
 * 
 */
@Entity
@Table(name="t_activity_person")
@NamedQuery(name="TActivityPersonEntity.findAll", query="SELECT t FROM TActivityPersonEntity t")
public class TActivityPersonEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="activity_persion_id")
	private String activityPersionId;

	@Column(name="activity_id")
	private String activityId;

	@Column(name="activity_person_tag")
	private String activityPersonTag;

	@Column(name="activity_position")
	private String activityPosition;

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

	@Column(name="person_id")
	private String personId;

	@Column(name="person_name_mix")
	private String personNameMix;

	public TActivityPersonEntity() {
	}

	public String getActivityPersionId() {
		return this.activityPersionId;
	}

	public void setActivityPersionId(String activityPersionId) {
		this.activityPersionId = activityPersionId;
	}

	public String getActivityId() {
		return this.activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getActivityPersonTag() {
		return this.activityPersonTag;
	}

	public void setActivityPersonTag(String activityPersonTag) {
		this.activityPersonTag = activityPersonTag;
	}

	public String getActivityPosition() {
		return this.activityPosition;
	}

	public void setActivityPosition(String activityPosition) {
		this.activityPosition = activityPosition;
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

	public String getPersonId() {
		return this.personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getPersonNameMix() {
		return this.personNameMix;
	}

	public void setPersonNameMix(String personNameMix) {
		this.personNameMix = personNameMix;
	}

}