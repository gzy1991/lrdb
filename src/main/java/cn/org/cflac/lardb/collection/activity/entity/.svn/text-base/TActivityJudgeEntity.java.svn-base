package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_activity_judges database table.
 * 
 */
@Entity
@Table(name="t_activity_judges")
@NamedQuery(name="TActivityJudgeEntity.findAll", query="SELECT t FROM TActivityJudgeEntity t")
public class TActivityJudgeEntity  extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="activity_judges_id")
	private String activityJudgesId;

	@Column(name="activity_id")
	private String activityId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="judge_id")
	private String judgeId;

	@Column(name="judge_intro")
	private String judgeIntro;

	@Column(name="judge_name_mix")
	private String judgeNameMix;

	@Column(name="judge_position")
	private String judgePosition;

	@Column(name="judge_tag")
	private String judgeTag;

	@Column(name="lastmodify_time")
	private Timestamp lastmodifyTime;

	@Column(name="lastmodify_user")
	private String lastmodifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="org_code")
	private String orgCode;

	public TActivityJudgeEntity() {
	}

	public String getActivityJudgesId() {
		return this.activityJudgesId;
	}

	public void setActivityJudgesId(String activityJudgesId) {
		this.activityJudgesId = activityJudgesId;
	}

	public String getActivityId() {
		return this.activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
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

	public String getJudgeId() {
		return this.judgeId;
	}

	public void setJudgeId(String judgeId) {
		this.judgeId = judgeId;
	}

	public String getJudgeIntro() {
		return this.judgeIntro;
	}

	public void setJudgeIntro(String judgeIntro) {
		this.judgeIntro = judgeIntro;
	}

	public String getJudgeNameMix() {
		return this.judgeNameMix;
	}

	public void setJudgeNameMix(String judgeNameMix) {
		this.judgeNameMix = judgeNameMix;
	}

	public String getJudgePosition() {
		return this.judgePosition;
	}

	public void setJudgePosition(String judgePosition) {
		this.judgePosition = judgePosition;
	}

	public String getJudgeTag() {
		return this.judgeTag;
	}

	public void setJudgeTag(String judgeTag) {
		this.judgeTag = judgeTag;
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

}