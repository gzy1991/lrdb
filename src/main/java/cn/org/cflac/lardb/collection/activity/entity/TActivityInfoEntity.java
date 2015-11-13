package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.alibaba.fastjson.annotation.JSONField;
import cn.org.cflac.lardb.collection.award.entity.TAwardUnitEntity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * The persistent class for the t_activity_info database table.
 * 
 */
@Entity
@Table(name = "t_activity_info")
@NamedQuery(name = "TActivityInfoEntity.findAll", query = "SELECT t FROM TActivityInfoEntity t")
public class TActivityInfoEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "activity_id")
	private String activityId;

	@Column(name = "activity_address")
	private String activityAddress;

	@JSONField(format = "yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	@Column(name = "activity_begin_date")
	private Date activityBeginDate;

	@Column(name = "activity_content")
	private String activityContent;

	@JSONField(format = "yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	@Column(name = "activity_end_date")
	private Date activityEndDate;

	@Column(name = "activity_introduction")
	private String activityIntroduction;

	@Column(name = "activity_keyword")
	private String activityKeyword;

	@Column(name = "activity_name")
	private String activityName;

	@Column(name = "activity_opus_front_tag")
	private String activityOpusFrontTag;

	@Column(name = "activity_time_num")
	private int activityTimeNum;

	@Column(name = "activity_year")
	private int activityYear;

	@Column(name = "acttype_dict")
	private String acttypeDict;

	@Column(name = "arttype_dict")
	private String arttypeDict;

	@Column(name = "create_time")
	private Timestamp createTime;

	@Column(name = "create_user")
	private String createUser;

	private String invalid;

	@Column(name = "is_submit")
	private String isSubmit;

	@Column(name = "lastmodify_time")
	private Timestamp lastmodifyTime;

	@Column(name = "lastmodify_user")
	private String lastmodifyUser;

	@Column(name = "level_dict")
	private String levelDict;

	@Column(name = "nature_dict")
	private String natureDict;

	@Column(name = "oper_status")
	private String operStatus;

	@Column(name = "org_code")
	private String orgCode;

	// ////////////非持久化属性//////////

	@Transient
	private List<TActivityAddressSiteEntity> siteList;
	@Transient
	private List<TActivityAddressSponsorEntity> sponsorList;
	@Transient
	private List<TActivityAddressOrganizerEntity> organizerList;
	@Transient
	private List<TActivityAddressOrganEntity> coOrganizerList;
	@Transient
	private List<TActivityJudgeEntity> judgeList;
	@Transient
	private List<TActivityNewsRelEntity> newsList;
	@Transient
	private List<TActivityOpusNameEntity> opusNameList;
	@Transient
	private List<TActivityPersonEntity> persionList;
	@Transient
	private List<TActivityAwardteamEntity> awardTeamList;
	@Transient
	private List<TActivityFestivalawardRelEntity> festivalawardList;
	@Transient
	private List<TActivityAwardteamAwardlistEntity> awardList;
	@Transient
	private List<TActivityAwardteamAwardlistOpusEntity> awardListOpus;
	@Transient
	private List<TActivityAwardteamAwardlistOrganEntity> awardListOrgan;
	@Transient
	private List<TActivityAwardteamAwardlistPersonEntity> awardListPerson;

	public List<TActivityAwardteamAwardlistPersonEntity> getAwardListPerson() {
		return awardListPerson;
	}

	public void setAwardListPerson(
			List<TActivityAwardteamAwardlistPersonEntity> awardListPerson) {
		this.awardListPerson = awardListPerson;
	}

	public List<TActivityAwardteamAwardlistOrganEntity> getAwardListOrgan() {
		return awardListOrgan;
	}

	public void setAwardListOrgan(
			List<TActivityAwardteamAwardlistOrganEntity> awardListOrgan) {
		this.awardListOrgan = awardListOrgan;
	}

	public List<TActivityAwardteamAwardlistOpusEntity> getAwardListOpus() {
		return awardListOpus;
	}

	public void setAwardListOpus(
			List<TActivityAwardteamAwardlistOpusEntity> awardListOpus) {
		this.awardListOpus = awardListOpus;
	}

	public List<TActivityAwardteamAwardlistEntity> getAwardList() {
		return awardList;
	}

	public void setAwardList(List<TActivityAwardteamAwardlistEntity> awardList) {
		this.awardList = awardList;
	}

	public List<TActivityFestivalawardRelEntity> getFestivalawardList() {
		return festivalawardList;
	}

	public void setFestivalawardList(
			List<TActivityFestivalawardRelEntity> festivalawardList) {
		this.festivalawardList = festivalawardList;
	}

	public List<TActivityAwardteamEntity> getAwardTeamList() {
		return awardTeamList;
	}

	public void setAwardTeamList(List<TActivityAwardteamEntity> awardTeamList) {
		this.awardTeamList = awardTeamList;
	}

	public List<TActivityPersonEntity> getPersionList() {
		return persionList;
	}

	public void setPersionList(List<TActivityPersonEntity> persionList) {
		this.persionList = persionList;
	}

	public List<TActivityOpusNameEntity> getOpusNameList() {
		return opusNameList;
	}

	public void setOpusNameList(List<TActivityOpusNameEntity> opusNameList) {
		this.opusNameList = opusNameList;
	}

	public List<TActivityNewsRelEntity> getNewsList() {
		return newsList;
	}

	public void setNewsList(List<TActivityNewsRelEntity> newsList) {
		this.newsList = newsList;
	}

	public List<TActivityJudgeEntity> getJudgeList() {
		return judgeList;
	}

	public void setJudgeList(List<TActivityJudgeEntity> judgeList) {
		this.judgeList = judgeList;
	}

	public List<TActivityAddressOrganEntity> getCoOrganizerList() {
		return coOrganizerList;
	}

	public void setCoOrganizerList(
			List<TActivityAddressOrganEntity> coOrganizerList) {
		this.coOrganizerList = coOrganizerList;
	}

	public List<TActivityAddressOrganizerEntity> getOrganizerList() {
		return organizerList;
	}

	public void setOrganizerList(
			List<TActivityAddressOrganizerEntity> organizerList) {
		this.organizerList = organizerList;
	}

	public List<TActivityAddressSponsorEntity> getSponsorList() {
		return sponsorList;
	}

	public void setSponsorList(List<TActivityAddressSponsorEntity> sponsorList) {
		this.sponsorList = sponsorList;
	}

	public List<TActivityAddressSiteEntity> getSiteList() {
		return siteList;
	}

	public void setSiteList(List<TActivityAddressSiteEntity> siteList) {
		this.siteList = siteList;
	}

	public TActivityInfoEntity() {
	}

	public String getActivityId() {
		return this.activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getActivityAddress() {
		return this.activityAddress;
	}

	public void setActivityAddress(String activityAddress) {
		this.activityAddress = activityAddress;
	}

	public Date getActivityBeginDate() {
		return this.activityBeginDate;
	}

	public void setActivityBeginDate(Date activityBeginDate) {
		this.activityBeginDate = activityBeginDate;
	}

	public String getActivityContent() {
		return this.activityContent;
	}

	public void setActivityContent(String activityContent) {
		this.activityContent = activityContent;
	}

	public Date getActivityEndDate() {
		return this.activityEndDate;
	}

	public void setActivityEndDate(Date activityEndDate) {
		this.activityEndDate = activityEndDate;
	}

	public String getActivityIntroduction() {
		return this.activityIntroduction;
	}

	public void setActivityIntroduction(String activityIntroduction) {
		this.activityIntroduction = activityIntroduction;
	}

	public String getActivityKeyword() {
		return this.activityKeyword;
	}

	public void setActivityKeyword(String activityKeyword) {
		this.activityKeyword = activityKeyword;
	}

	public String getActivityName() {
		return this.activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getActivityOpusFrontTag() {
		return this.activityOpusFrontTag;
	}

	public void setActivityOpusFrontTag(String activityOpusFrontTag) {
		this.activityOpusFrontTag = activityOpusFrontTag;
	}

	public int getActivityTimeNum() {
		return this.activityTimeNum;
	}

	public void setActivityTimeNum(int activityTimeNum) {
		this.activityTimeNum = activityTimeNum;
	}

	public int getActivityYear() {
		return this.activityYear;
	}

	public void setActivityYear(int activityYear) {
		this.activityYear = activityYear;
	}

	public String getActtypeDict() {
		return this.acttypeDict;
	}

	public void setActtypeDict(String acttypeDict) {
		this.acttypeDict = acttypeDict;
	}

	public String getArttypeDict() {
		return this.arttypeDict;
	}

	public void setArttypeDict(String arttypeDict) {
		this.arttypeDict = arttypeDict;
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

	public String getLevelDict() {
		return this.levelDict;
	}

	public void setLevelDict(String levelDict) {
		this.levelDict = levelDict;
	}

	public String getNatureDict() {
		return this.natureDict;
	}

	public void setNatureDict(String natureDict) {
		this.natureDict = natureDict;
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