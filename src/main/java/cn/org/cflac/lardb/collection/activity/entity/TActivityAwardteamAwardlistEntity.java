package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;
import java.util.*;


/**
 * The persistent class for the t_activity_awardteam_awardlist database table.
 * 
 */
@Entity
@Table(name="t_activity_awardteam_awardlist")
@NamedQuery(name="TActivityAwardteamAwardlistEntity.findAll", query="SELECT t FROM TActivityAwardteamAwardlistEntity t")
public class TActivityAwardteamAwardlistEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="activity_awardlist_id")
	private String activityAwardlistId;

	@Column(name="activity_awardname")
	private String activityAwardname;

	@Column(name="activity_awardteam_id")
	private String activityAwardteamId;

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
	
	@Transient
	List<TActivityAwardteamAwardlistPersonEntity> awardlistPerson;
	
	@Transient
	List<TActivityAwardteamAwardlistOpusEntity> awardlistOpus;
	
	@Transient
	List<TActivityAwardteamAwardlistOrganEntity> awardlistOrgan;
	
	public List<TActivityAwardteamAwardlistPersonEntity> getAwardlistPerson() {
		return awardlistPerson;
	}

	public void setAwardlistPerson(
			List<TActivityAwardteamAwardlistPersonEntity> awardlistPerson) {
		this.awardlistPerson = awardlistPerson;
	}
	
	public List<TActivityAwardteamAwardlistOpusEntity> getAwardlistOpus() {
		return awardlistOpus;
	}

	public void setAwardlistOpus(
			List<TActivityAwardteamAwardlistOpusEntity> awardlistOpus) {
		this.awardlistOpus = awardlistOpus;
	}

	public List<TActivityAwardteamAwardlistOrganEntity> getAwardlistOrgan() {
		return awardlistOrgan;
	}

	public void setAwardlistOrgan(
			List<TActivityAwardteamAwardlistOrganEntity> awardlistOrgan) {
		this.awardlistOrgan = awardlistOrgan;
	}

	public TActivityAwardteamAwardlistEntity() {
	}

	public String getActivityAwardlistId() {
		return this.activityAwardlistId;
	}

	public void setActivityAwardlistId(String activityAwardlistId) {
		this.activityAwardlistId = activityAwardlistId;
	}

	public String getActivityAwardname() {
		return this.activityAwardname;
	}

	public void setActivityAwardname(String activityAwardname) {
		this.activityAwardname = activityAwardname;
	}

	public String getActivityAwardteamId() {
		return this.activityAwardteamId;
	}

	public void setActivityAwardteamId(String activityAwardteamId) {
		this.activityAwardteamId = activityAwardteamId;
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

}