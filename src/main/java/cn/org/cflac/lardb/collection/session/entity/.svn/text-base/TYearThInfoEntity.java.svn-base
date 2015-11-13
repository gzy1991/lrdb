package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the t_year_th_info database table.
 * 
 */
@Entity
@Table(name="t_year_th_info")
@NamedQuery(name="TYearThInfoEntity.findAll", query="SELECT t FROM TYearThInfoEntity t")
public class TYearThInfoEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="year_th_id")
	private String yearThId;

	@Column(name="activity_introduction")
	private String activityIntroduction;

	@Column(name="activity_label")
	private String activityLabel;
	
	@Column(name="art_type_dict")
	private String artTypeDict;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	@Temporal(TemporalType.DATE)
	@Column(name="end_time")
	private Date endTime;

	private String invalid;

	@Column(name="last_modify_time")
	private Timestamp lastModifyTime;

	@Column(name="last_modify_user")
	private String lastModifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="opus_introduction")
	private String opusIntroduction;

	@Column(name="opus_label")
	private String opusLabel;

	@Column(name="picture_id")
	private String pictureId;

	@Column(name="picture_path")
	private String picturePath;

	@Temporal(TemporalType.DATE)
	@Column(name="start_time")
	private Date startTime;

	@Column(name="year_th_keyword")
	private String yearThKeyword;

	@Column(name="year_th_place")
	private String yearThPlace;

	@Column(name="year_th_template")
	private String yearThTemplate;

	@Column(name="year_th_title")
	private String yearThTitle;
	
	@Column(name="year_th_introduction")
	private String yearThIntroduction;
	
	@Transient
	private List<TYearThAwardEntity> awards;
	
	@Transient
	private List<TYearThUnitEntity> units;
	
	@Transient
	private List<TYearThScheduleGroupingEntity> scheduleGroups;
	
	@Transient
	private List<TYearThOpusEntity> opusList;
	
	@Transient
	private List<TYearThJudgeEntity> judges;
	
	@Transient
	private List<TYearThWinnersGroupingEntity> winnerGroups;
	
	@Transient
	private List<TYearThActivityRelEntity> activityList;
	
	@Transient
	private List<TYearThCommentRelEntity> comments;
	
	@Transient
	private List<TYearThNewsRelEntity> newsList;
	
	@Transient
	private List<TYearThAwardRelEntity> awardRels;
	
	@Transient
	private List<TYearThOthersRelEntity> sessions;

	@Transient
	private String yearThInfo;
	
	public TYearThInfoEntity() {
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public String getActivityIntroduction() {
		return this.activityIntroduction;
	}

	public void setActivityIntroduction(String activityIntroduction) {
		this.activityIntroduction = activityIntroduction;
	}

	public String getActivityLabel() {
		return this.activityLabel;
	}

	public void setActivityLabel(String activityLabel) {
		this.activityLabel = activityLabel;
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

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
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

	public String getOpusIntroduction() {
		return this.opusIntroduction;
	}

	public void setOpusIntroduction(String opusIntroduction) {
		this.opusIntroduction = opusIntroduction;
	}

	public String getOpusLabel() {
		return this.opusLabel;
	}

	public void setOpusLabel(String opusLabel) {
		this.opusLabel = opusLabel;
	}

	public String getPictureId() {
		return this.pictureId;
	}

	public void setPictureId(String pictureId) {
		this.pictureId = pictureId;
	}

	public String getPicturePath() {
		return this.picturePath;
	}

	public void setPicturePath(String picturePath) {
		this.picturePath = picturePath;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public String getYearThKeyword() {
		return this.yearThKeyword;
	}

	public void setYearThKeyword(String yearThKeyword) {
		this.yearThKeyword = yearThKeyword;
	}

	public String getYearThPlace() {
		return this.yearThPlace;
	}

	public void setYearThPlace(String yearThPlace) {
		this.yearThPlace = yearThPlace;
	}

	public String getYearThTemplate() {
		return this.yearThTemplate;
	}

	public void setYearThTemplate(String yearThTemplate) {
		this.yearThTemplate = yearThTemplate;
	}

	public String getYearThTitle() {
		return this.yearThTitle;
	}

	public void setYearThTitle(String yearThTitle) {
		this.yearThTitle = yearThTitle;
	}

	public List<TYearThAwardEntity> getAwards() {
		return awards;
	}

	public void setAwards(List<TYearThAwardEntity> awards) {
		this.awards = awards;
	}

	public List<TYearThUnitEntity> getUnits() {
		return units;
	}

	public void setUnits(List<TYearThUnitEntity> units) {
		this.units = units;
	}

	public List<TYearThScheduleGroupingEntity> getScheduleGroups() {
		return scheduleGroups;
	}

	public void setScheduleGroups(List<TYearThScheduleGroupingEntity> scheduleGroups) {
		this.scheduleGroups = scheduleGroups;
	}

	public List<TYearThOpusEntity> getOpusList() {
		return opusList;
	}

	public void setOpusList(List<TYearThOpusEntity> opusList) {
		this.opusList = opusList;
	}

	public List<TYearThJudgeEntity> getJudges() {
		return judges;
	}

	public void setJudges(List<TYearThJudgeEntity> judges) {
		this.judges = judges;
	}

	public List<TYearThWinnersGroupingEntity> getWinnerGroups() {
		return winnerGroups;
	}

	public void setWinnerGroups(List<TYearThWinnersGroupingEntity> winnerGroups) {
		this.winnerGroups = winnerGroups;
	}

	public List<TYearThActivityRelEntity> getActivityList() {
		return activityList;
	}

	public void setActivityList(List<TYearThActivityRelEntity> activityList) {
		this.activityList = activityList;
	}

	public List<TYearThCommentRelEntity> getComments() {
		return comments;
	}

	public void setComments(List<TYearThCommentRelEntity> comments) {
		this.comments = comments;
	}

	public List<TYearThNewsRelEntity> getNewsList() {
		return newsList;
	}

	public void setNewsList(List<TYearThNewsRelEntity> newsList) {
		this.newsList = newsList;
	}

	public List<TYearThAwardRelEntity> getAwardRels() {
		return awardRels;
	}

	public void setAwardRels(List<TYearThAwardRelEntity> awardRels) {
		this.awardRels = awardRels;
	}

	public List<TYearThOthersRelEntity> getSessions() {
		return sessions;
	}

	public void setSessions(List<TYearThOthersRelEntity> sessions) {
		this.sessions = sessions;
	}

	public String getArtTypeDict() {
		return artTypeDict;
	}

	public void setArtTypeDict(String artTypeDict) {
		this.artTypeDict = artTypeDict;
	}

	public String getYearThIntroduction() {
		return yearThIntroduction;
	}

	public void setYearThIntroduction(String yearThIntroduction) {
		this.yearThIntroduction = yearThIntroduction;
	}

	public String getYearThInfo() {
		return yearThInfo;
	}

	public void setYearThInfo(String yearThInfo) {
		this.yearThInfo = yearThInfo;
	}
	
}