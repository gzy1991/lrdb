package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.alibaba.fastjson.annotation.JSONField;
import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;
import java.util.Date;


/**
 * The persistent class for the t_year_th_schedule database table.
 * 
 */
@Entity
@Table(name="t_year_th_schedule")
@NamedQuery(name="TYearThScheduleEntity.findAll", query="SELECT t FROM TYearThScheduleEntity t")
public class TYearThScheduleEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="schedule_id")
	private String scheduleId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	@JSONField(format="yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	@Column(name="end_time")
	private Date endTime;

	@Column(name="grouping_id")
	private String groupingId;

	private String invalid;

	@Column(name="last_modify_time")
	private Timestamp lastModifyTime;

	@Column(name="last_modify_user")
	private String lastModifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="schedule_content")
	private String scheduleContent;

	@Column(name="schedule_place")
	private String schedulePlace;

	@Column(name="schedule_sort_number")
	private int scheduleSortNumber;

	@Column(name="schedule_time")
	private String scheduleTime;

	@JSONField(format="yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	@Column(name="start_time")
	private Date startTime;

	public TYearThScheduleEntity() {
	}

	public String getScheduleId() {
		return this.scheduleId;
	}

	public void setScheduleId(String scheduleId) {
		this.scheduleId = scheduleId;
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

	public String getGroupingId() {
		return this.groupingId;
	}

	public void setGroupingId(String groupingId) {
		this.groupingId = groupingId;
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

	public String getScheduleContent() {
		return this.scheduleContent;
	}

	public void setScheduleContent(String scheduleContent) {
		this.scheduleContent = scheduleContent;
	}

	public String getSchedulePlace() {
		return this.schedulePlace;
	}

	public void setSchedulePlace(String schedulePlace) {
		this.schedulePlace = schedulePlace;
	}

	public int getScheduleSortNumber() {
		return this.scheduleSortNumber;
	}

	public void setScheduleSortNumber(int scheduleSortNumber) {
		this.scheduleSortNumber = scheduleSortNumber;
	}

	public String getScheduleTime() {
		return this.scheduleTime;
	}

	public void setScheduleTime(String scheduleTime) {
		this.scheduleTime = scheduleTime;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

}