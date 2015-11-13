package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_activity_awardteam_awardlist_organ database table.
 * 
 */
@Entity
@Table(name="t_activity_awardteam_awardlist_organ")
@NamedQuery(name="TActivityAwardteamAwardlistOrganEntity.findAll", query="SELECT t FROM TActivityAwardteamAwardlistOrganEntity t")
public class TActivityAwardteamAwardlistOrganEntity  extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="activity_awardlist_organ_id")
	private String activityAwardlistOrganId;

	@Column(name="activity_awardlist_id")
	private String activityAwardlistId;

	@Column(name="activity_organ_tag")
	private String activityOrganTag;

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

	@Column(name="organ_id_mix")
	private String organIdMix;

	@Column(name="organ_name_mix")
	private String organNameMix;

	public TActivityAwardteamAwardlistOrganEntity() {
	}

	public String getActivityAwardlistOrganId() {
		return this.activityAwardlistOrganId;
	}

	public void setActivityAwardlistOrganId(String activityAwardlistOrganId) {
		this.activityAwardlistOrganId = activityAwardlistOrganId;
	}

	public String getActivityAwardlistId() {
		return this.activityAwardlistId;
	}

	public void setActivityAwardlistId(String activityAwardlistId) {
		this.activityAwardlistId = activityAwardlistId;
	}

	public String getActivityOrganTag() {
		return this.activityOrganTag;
	}

	public void setActivityOrganTag(String activityOrganTag) {
		this.activityOrganTag = activityOrganTag;
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

	public String getOrganIdMix() {
		return this.organIdMix;
	}

	public void setOrganIdMix(String organIdMix) {
		this.organIdMix = organIdMix;
	}

	public String getOrganNameMix() {
		return this.organNameMix;
	}

	public void setOrganNameMix(String organNameMix) {
		this.organNameMix = organNameMix;
	}

}