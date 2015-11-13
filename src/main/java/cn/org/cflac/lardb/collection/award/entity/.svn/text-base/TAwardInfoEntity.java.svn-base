package cn.org.cflac.lardb.collection.award.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the t_award_info database table.
 * 
 */
@Entity
@Table(name="t_award_info")
@NamedQuery(name="TAwardInfoEntity.findAll", query="SELECT t FROM TAwardInfoEntity t")
public class TAwardInfoEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="award_id")
	private String awardId;

	@Column(name="art_type_dict")
	private String artTypeDict;

	@Column(name="award_code")
	private String awardCode;

	@Column(name="award_keyword")
	private String awardKeyword;

	@Column(name="award_level_dict")
	private String awardLevelDict;

	@Column(name="award_nature_dict")
	private String awardNatureDict;

	@Column(name="award_period")
	private Integer awardPeriod;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="last_modify_time")
	private Timestamp lastModifyTime;

	@Column(name="last_modify_user")
	private String lastModifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="picture_id")
	private String pictureId;

	@Column(name="picture_path")
	private String picturePath;

	@Column(name="startup_time")
	private Integer startupTime;
	
	@Transient
	private List<TAwardUnitEntity> unitList;
	
	@Transient
	private List<TAwardCourseEntity> courseList;
	
	@Transient
	private TAwardIntroductionEntity introduction;
	
	@Transient
	private String awardName;

	public TAwardInfoEntity() {
	}

	public String getAwardId() {
		return this.awardId;
	}

	public void setAwardId(String awardId) {
		this.awardId = awardId;
	}

	public String getArtTypeDict() {
		return this.artTypeDict;
	}

	public void setArtTypeDict(String artTypeDict) {
		this.artTypeDict = artTypeDict;
	}

	public String getAwardCode() {
		return this.awardCode;
	}

	public void setAwardCode(String awardCode) {
		this.awardCode = awardCode;
	}

	public String getAwardKeyword() {
		return this.awardKeyword;
	}

	public void setAwardKeyword(String awardKeyword) {
		this.awardKeyword = awardKeyword;
	}

	public String getAwardLevelDict() {
		return this.awardLevelDict;
	}

	public void setAwardLevelDict(String awardLevelDict) {
		this.awardLevelDict = awardLevelDict;
	}

	public String getAwardNatureDict() {
		return this.awardNatureDict;
	}

	public void setAwardNatureDict(String awardNatureDict) {
		this.awardNatureDict = awardNatureDict;
	}

	public Integer getAwardPeriod() {
		return awardPeriod;
	}

	public void setAwardPeriod(Integer awardPeriod) {
		this.awardPeriod = awardPeriod;
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

	public Integer getStartupTime() {
		return startupTime;
	}

	public void setStartupTime(Integer startupTime) {
		this.startupTime = startupTime;
	}

	public List<TAwardUnitEntity> getUnitList() {
		return unitList;
	}

	public void setUnitList(List<TAwardUnitEntity> unitList) {
		this.unitList = unitList;
	}

	public List<TAwardCourseEntity> getCourseList() {
		return courseList;
	}

	public void setCourseList(List<TAwardCourseEntity> courseList) {
		this.courseList = courseList;
	}

	public TAwardIntroductionEntity getIntroduction() {
		return introduction;
	}

	public void setIntroduction(TAwardIntroductionEntity introduction) {
		this.introduction = introduction;
	}

	public String getAwardName() {
		return awardName;
	}

	public void setAwardName(String awardName) {
		this.awardName = awardName;
	}
	
}