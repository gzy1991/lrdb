package cn.org.cflac.lardb.collection.classics.stagePeriodical.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.alibaba.fastjson.annotation.JSONField;

import cn.org.cflac.lardb.common.UUIDUtil;

import java.util.Date;
import java.sql.Timestamp;


/**
 * The persistent class for the t_stage_periodical_info database table.
 * 
 */
@Entity
@Table(name="t_stage_periodical_info")
@NamedQuery(name="TStagePeriodicalInfoEntity.findAll", query="SELECT t FROM TStagePeriodicalInfoEntity t")
public class TStagePeriodicalInfoEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="stage_periodical_id")
	private String stagePeriodicalId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="is_submit")
	private String isSubmit;

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

	@Lob
	@Column(name="stage_periodical_introduction")
	private String stagePeriodicalIntroduction;

	@Column(name="stage_periodical_is_core")
	private String stagePeriodicalIsCore;

	@Column(name="stage_periodical_keyword")
	private String stagePeriodicalKeyword;

	@Column(name="stage_periodical_name")
	private String stagePeriodicalName;

	@Temporal(TemporalType.DATE)
	@Column(name="stage_periodical_publish_date")
	@JSONField(format = "yyyy-MM-dd")
	private Date stagePeriodicalPublishDate;

	@Column(name="stage_periodical_stage")
	private String stagePeriodicalStage;

	@Column(name="stage_periodical_total_stage")
	private String stagePeriodicalTotalStage;

	@Column(name="type_dict")
	private String typeDict;

	public TStagePeriodicalInfoEntity() {
		this.stagePeriodicalId = UUIDUtil.generateUUID();
	}

	public String getStagePeriodicalId() {
		return this.stagePeriodicalId;
	}

	public void setStagePeriodicalId(String stagePeriodicalId) {
		this.stagePeriodicalId = stagePeriodicalId;
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

	public String getIsSubmit() {
		return this.isSubmit;
	}

	public void setIsSubmit(String isSubmit) {
		this.isSubmit = isSubmit;
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

	public String getStagePeriodicalIntroduction() {
		return this.stagePeriodicalIntroduction;
	}

	public void setStagePeriodicalIntroduction(String stagePeriodicalIntroduction) {
		this.stagePeriodicalIntroduction = stagePeriodicalIntroduction;
	}

	public String getStagePeriodicalIsCore() {
		return this.stagePeriodicalIsCore;
	}

	public void setStagePeriodicalIsCore(String stagePeriodicalIsCore) {
		this.stagePeriodicalIsCore = stagePeriodicalIsCore;
	}

	public String getStagePeriodicalKeyword() {
		return this.stagePeriodicalKeyword;
	}

	public void setStagePeriodicalKeyword(String stagePeriodicalKeyword) {
		this.stagePeriodicalKeyword = stagePeriodicalKeyword;
	}

	public String getStagePeriodicalName() {
		return this.stagePeriodicalName;
	}

	public void setStagePeriodicalName(String stagePeriodicalName) {
		this.stagePeriodicalName = stagePeriodicalName;
	}

	public Date getStagePeriodicalPublishDate() {
		return this.stagePeriodicalPublishDate;
	}

	public void setStagePeriodicalPublishDate(Date stagePeriodicalPublishDate) {
		this.stagePeriodicalPublishDate = stagePeriodicalPublishDate;
	}

	public String getStagePeriodicalStage() {
		return this.stagePeriodicalStage;
	}

	public void setStagePeriodicalStage(String stagePeriodicalStage) {
		this.stagePeriodicalStage = stagePeriodicalStage;
	}

	public String getStagePeriodicalTotalStage() {
		return this.stagePeriodicalTotalStage;
	}

	public void setStagePeriodicalTotalStage(String stagePeriodicalTotalStage) {
		this.stagePeriodicalTotalStage = stagePeriodicalTotalStage;
	}

	public String getTypeDict() {
		return this.typeDict;
	}

	public void setTypeDict(String typeDict) {
		this.typeDict = typeDict;
	}

}