package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_activity_awardteam_awardlist_person database table.
 * 
 */
@Entity
@Table(name="t_activity_awardteam_awardlist_person")
@NamedQuery(name="TActivityAwardteamAwardlistPersonEntity.findAll", query="SELECT t FROM TActivityAwardteamAwardlistPersonEntity t")
public class TActivityAwardteamAwardlistPersonEntity  extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="activity_awardlist_persion_id")
	private String activityAwardlistPersionId;

	@Column(name="activity_awardlist_id")
	private String activityAwardlistId;

	@Column(name="activity_persion_tag")
	private String activityPersionTag;

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

	@Column(name="person_id_mix")
	private String personIdMix;

	@Column(name="person_name_mix")
	private String personNameMix;

	public TActivityAwardteamAwardlistPersonEntity() {
	}

	public String getActivityAwardlistPersionId() {
		return this.activityAwardlistPersionId;
	}

	public void setActivityAwardlistPersionId(String activityAwardlistPersionId) {
		this.activityAwardlistPersionId = activityAwardlistPersionId;
	}

	public String getActivityAwardlistId() {
		return this.activityAwardlistId;
	}

	public void setActivityAwardlistId(String activityAwardlistId) {
		this.activityAwardlistId = activityAwardlistId;
	}

	public String getActivityPersionTag() {
		return this.activityPersionTag;
	}

	public void setActivityPersionTag(String activityPersionTag) {
		this.activityPersionTag = activityPersionTag;
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

	public String getPersonIdMix() {
		return this.personIdMix;
	}

	public void setPersonIdMix(String personIdMix) {
		this.personIdMix = personIdMix;
	}

	public String getPersonNameMix() {
		return this.personNameMix;
	}

	public void setPersonNameMix(String personNameMix) {
		this.personNameMix = personNameMix;
	}

}