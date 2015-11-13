package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;


/**
 * The persistent class for the t_year_th_judge database table.
 * 
 */
@Entity
@Table(name="t_year_th_judge")
@NamedQuery(name="TYearThJudgeEntity.findAll", query="SELECT t FROM TYearThJudgeEntity t")
public class TYearThJudgeEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="year_th_judge_id")
	private String yearThJudgeId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="judge_autograph")
	private String judgeAutograph;

	@Column(name="judge_id")
	private String judgeId;

	@Column(name="judge_introduction")
	private String judgeIntroduction;

	@Column(name="judge_position")
	private String judgePosition;

	@Column(name="judge_sort_number")
	private int judgeSortNumber;

	@Column(name="last_modify_time")
	private Timestamp lastModifyTime;

	@Column(name="last_modify_user")
	private String lastModifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="year_th_id")
	private String yearThId;

	public TYearThJudgeEntity() {
	}

	public String getYearThJudgeId() {
		return this.yearThJudgeId;
	}

	public void setYearThJudgeId(String yearThJudgeId) {
		this.yearThJudgeId = yearThJudgeId;
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

	public String getJudgeAutograph() {
		return this.judgeAutograph;
	}

	public void setJudgeAutograph(String judgeAutograph) {
		this.judgeAutograph = judgeAutograph;
	}

	public String getJudgeId() {
		return this.judgeId;
	}

	public void setJudgeId(String judgeId) {
		this.judgeId = judgeId;
	}

	public String getJudgeIntroduction() {
		return this.judgeIntroduction;
	}

	public void setJudgeIntroduction(String judgeIntroduction) {
		this.judgeIntroduction = judgeIntroduction;
	}

	public String getJudgePosition() {
		return this.judgePosition;
	}

	public void setJudgePosition(String judgePosition) {
		this.judgePosition = judgePosition;
	}

	public int getJudgeSortNumber() {
		return this.judgeSortNumber;
	}

	public void setJudgeSortNumber(int judgeSortNumber) {
		this.judgeSortNumber = judgeSortNumber;
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

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

}