package cn.org.cflac.lardb.collection.classics.periodical.entity;

import java.io.Serializable;

import javax.persistence.*;

import cn.org.cflac.lardb.common.UUIDUtil;

import java.sql.Timestamp;


/**
 * The persistent class for the t_periodical_info database table.
 * 
 */
@Entity
@Table(name="t_periodical_info")
@NamedQuery(name="TPeriodicalInfoEntity.findAll", query="SELECT t FROM TPeriodicalInfoEntity t")
public class TPeriodicalInfoEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="periodical_id")
	private String periodicalId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	@Column(name="folios_dict")
	private String foliosDict;

	private String invalid;

	@Column(name="is_submit")
	private String isSubmit;

	@Column(name="language_dict")
	private String languageDict;

	@Column(name="lastmodify_time")
	private Timestamp lastmodifyTime;

	@Column(name="lastmodify_user")
	private String lastmodifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="org_code")
	private String orgCode;

	@Column(name="periodical_dom_series")
	private String periodicalDomSeries;

	@Column(name="periodical_emailed_code")
	private String periodicalEmailedCode;

	@Column(name="periodical_envelope_id")
	private String periodicalEnvelopeId;

	@Column(name="periodical_envelope_name")
	private String periodicalEnvelopeName;

	@Column(name="periodical_envelope_url")
	private String periodicalEnvelopeUrl;

	@Column(name="periodical_first_time")
	private int periodicalFirstTime;

	@Column(name="periodical_former_name")
	private String periodicalFormerName;

	@Column(name="periodical_inter_series")
	private String periodicalInterSeries;

	@Lob
	@Column(name="periodical_introduction")
	private String periodicalIntroduction;

	@Column(name="periodical_keyword")
	private String periodicalKeyword;

	@Column(name="periodical_name_cn")
	private String periodicalNameCn;

	@Column(name="periodical_name_en")
	private String periodicalNameEn;

	@Column(name="periodical_publication_date")
	private String periodicalPublicationDate;

	@Column(name="publish_cycle_dict")
	private String publishCycleDict;

	@Column(name="publish_site_dict")
	private String publishSiteDict;

	@Column(name="type_dict")
	private String typeDict;
	
	//--非持久化字段--start--
	@Transient
	private String sponsor;
	@Transient
	private String publisher;
	public String getSponsor() {
		return sponsor;
	}

	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}
	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	//--非持久化字段--end--
	public TPeriodicalInfoEntity() {
		this.periodicalId = UUIDUtil.generateUUID();
	}

	public String getPeriodicalId() {
		return this.periodicalId;
	}

	public void setPeriodicalId(String periodicalId) {
		this.periodicalId = periodicalId;
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

	public String getFoliosDict() {
		return this.foliosDict;
	}

	public void setFoliosDict(String foliosDict) {
		this.foliosDict = foliosDict;
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

	public String getLanguageDict() {
		return this.languageDict;
	}

	public void setLanguageDict(String languageDict) {
		this.languageDict = languageDict;
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

	public String getPeriodicalDomSeries() {
		return this.periodicalDomSeries;
	}

	public void setPeriodicalDomSeries(String periodicalDomSeries) {
		this.periodicalDomSeries = periodicalDomSeries;
	}

	public String getPeriodicalEmailedCode() {
		return this.periodicalEmailedCode;
	}

	public void setPeriodicalEmailedCode(String periodicalEmailedCode) {
		this.periodicalEmailedCode = periodicalEmailedCode;
	}

	public String getPeriodicalEnvelopeId() {
		return this.periodicalEnvelopeId;
	}

	public void setPeriodicalEnvelopeId(String periodicalEnvelopeId) {
		this.periodicalEnvelopeId = periodicalEnvelopeId;
	}

	public String getPeriodicalEnvelopeName() {
		return this.periodicalEnvelopeName;
	}

	public void setPeriodicalEnvelopeName(String periodicalEnvelopeName) {
		this.periodicalEnvelopeName = periodicalEnvelopeName;
	}

	public String getPeriodicalEnvelopeUrl() {
		return this.periodicalEnvelopeUrl;
	}

	public void setPeriodicalEnvelopeUrl(String periodicalEnvelopeUrl) {
		this.periodicalEnvelopeUrl = periodicalEnvelopeUrl;
	}

	public int getPeriodicalFirstTime() {
		return this.periodicalFirstTime;
	}

	public void setPeriodicalFirstTime(int periodicalFirstTime) {
		this.periodicalFirstTime = periodicalFirstTime;
	}

	public String getPeriodicalFormerName() {
		return this.periodicalFormerName;
	}

	public void setPeriodicalFormerName(String periodicalFormerName) {
		this.periodicalFormerName = periodicalFormerName;
	}

	public String getPeriodicalInterSeries() {
		return this.periodicalInterSeries;
	}

	public void setPeriodicalInterSeries(String periodicalInterSeries) {
		this.periodicalInterSeries = periodicalInterSeries;
	}

	public String getPeriodicalIntroduction() {
		return this.periodicalIntroduction;
	}

	public void setPeriodicalIntroduction(String periodicalIntroduction) {
		this.periodicalIntroduction = periodicalIntroduction;
	}

	public String getPeriodicalKeyword() {
		return this.periodicalKeyword;
	}

	public void setPeriodicalKeyword(String periodicalKeyword) {
		this.periodicalKeyword = periodicalKeyword;
	}

	public String getPeriodicalNameCn() {
		return this.periodicalNameCn;
	}

	public void setPeriodicalNameCn(String periodicalNameCn) {
		this.periodicalNameCn = periodicalNameCn;
	}

	public String getPeriodicalNameEn() {
		return this.periodicalNameEn;
	}

	public void setPeriodicalNameEn(String periodicalNameEn) {
		this.periodicalNameEn = periodicalNameEn;
	}

	public String getPeriodicalPublicationDate() {
		return this.periodicalPublicationDate;
	}

	public void setPeriodicalPublicationDate(String periodicalPublicationDate) {
		this.periodicalPublicationDate = periodicalPublicationDate;
	}

	public String getPublishCycleDict() {
		return this.publishCycleDict;
	}

	public void setPublishCycleDict(String publishCycleDict) {
		this.publishCycleDict = publishCycleDict;
	}

	public String getPublishSiteDict() {
		return this.publishSiteDict;
	}

	public void setPublishSiteDict(String publishSiteDict) {
		this.publishSiteDict = publishSiteDict;
	}

	public String getTypeDict() {
		return this.typeDict;
	}

	public void setTypeDict(String typeDict) {
		this.typeDict = typeDict;
	}

}