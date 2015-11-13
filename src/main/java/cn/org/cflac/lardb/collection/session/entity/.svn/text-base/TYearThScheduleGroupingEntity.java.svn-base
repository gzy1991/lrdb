package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the t_year_th_schedule_grouping database table.
 * 
 */
@Entity
@Table(name="t_year_th_schedule_grouping")
@NamedQuery(name="TYearThScheduleGroupingEntity.findAll", query="SELECT t FROM TYearThScheduleGroupingEntity t")
public class TYearThScheduleGroupingEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="schedule_grouping_id")
	private String scheduleGroupingId;

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

	@Column(name="schedule_grouping_name")
	private String scheduleGroupingName;

	@Column(name="schedule_grouping_sort_number")
	private int scheduleGroupingSortNumber;

	@Column(name="year_th_id")
	private String yearThId;
	
	@Transient
	private List<TYearThScheduleEntity> schedules;

	public TYearThScheduleGroupingEntity() {
	}

	public String getScheduleGroupingId() {
		return this.scheduleGroupingId;
	}

	public void setScheduleGroupingId(String scheduleGroupingId) {
		this.scheduleGroupingId = scheduleGroupingId;
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

	public String getScheduleGroupingName() {
		return this.scheduleGroupingName;
	}

	public void setScheduleGroupingName(String scheduleGroupingName) {
		this.scheduleGroupingName = scheduleGroupingName;
	}

	public int getScheduleGroupingSortNumber() {
		return this.scheduleGroupingSortNumber;
	}

	public void setScheduleGroupingSortNumber(int scheduleGroupingSortNumber) {
		this.scheduleGroupingSortNumber = scheduleGroupingSortNumber;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public List<TYearThScheduleEntity> getSchedules() {
		return schedules;
	}

	public void setSchedules(List<TYearThScheduleEntity> schedules) {
		this.schedules = schedules;
	}
	
}