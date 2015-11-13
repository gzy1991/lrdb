package cn.org.cflac.lardb.collection.classics.stagePeriodical.entity;

import java.io.Serializable;

import javax.persistence.*;

import cn.org.cflac.lardb.common.UUIDUtil;

import java.sql.Timestamp;


/**
 * The persistent class for the t_stage_artist__unit database table.
 * 
 */
@Entity
@Table(name="t_stage_artist__unit")
@NamedQuery(name="TStageArtistUnitEntity.findAll", query="SELECT t FROM TStageArtistUnitEntity t")
public class TStageArtistUnitEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="stage_artist_unit_id")
	private String stageArtistUnitId;

	@Column(name="article_id")
	private String articleId;

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

	@Column(name="stage_artist_id")
	private String stageArtistId;

	@Column(name="stage_artist_name_mix")
	private String stageArtistNameMix;

	@Column(name="stage_artist_org")
	private String stageArtistOrg;

	@Column(name="stage_artist_type")
	private String stageArtistType;

	public TStageArtistUnitEntity() {
		this.stageArtistUnitId = UUIDUtil.generateUUID();
	}

	public String getStageArtistUnitId() {
		return this.stageArtistUnitId;
	}

	public void setStageArtistUnitId(String stageArtistUnitId) {
		this.stageArtistUnitId = stageArtistUnitId;
	}

	public String getArticleId() {
		return this.articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
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

	public String getStageArtistId() {
		return this.stageArtistId;
	}

	public void setStageArtistId(String stageArtistId) {
		this.stageArtistId = stageArtistId;
	}

	public String getStageArtistNameMix() {
		return this.stageArtistNameMix;
	}

	public void setStageArtistNameMix(String stageArtistNameMix) {
		this.stageArtistNameMix = stageArtistNameMix;
	}

	public String getStageArtistOrg() {
		return this.stageArtistOrg;
	}

	public void setStageArtistOrg(String stageArtistOrg) {
		this.stageArtistOrg = stageArtistOrg;
	}

	public String getStageArtistType() {
		return this.stageArtistType;
	}

	public void setStageArtistType(String stageArtistType) {
		this.stageArtistType = stageArtistType;
	}

}