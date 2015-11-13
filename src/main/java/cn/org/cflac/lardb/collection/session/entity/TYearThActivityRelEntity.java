package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import com.alibaba.fastjson.annotation.JSONField;
import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_year_th_activity_rel database table.
 * 
 */
@Entity
@Table(name="t_year_th_activity_rel")
@NamedQuery(name="TYearThActivityRelEntity.findAll", query="SELECT t FROM TYearThActivityRelEntity t")
public class TYearThActivityRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="year_th_activity_id")
	private String yearThActivityId;

	@Column(name="activity_id")
	private String activityId;

	@Column(name="year_th_id")
	private String yearThId;
	
	@Column(name="year_th_activity_sort_number")
	private Integer yearThActivitySortNumber;
	
	@JSONField(format="yyyy-MM-dd")
	@Transient
	private Date activityBeginDate;

	@JSONField(format="yyyy-MM-dd")
	@Transient
	private Date activityEndDate;

	@Transient
	private String activityName;

	public TYearThActivityRelEntity() {
	}

	public String getYearThActivityId() {
		return this.yearThActivityId;
	}

	public void setYearThActivityId(String yearThActivityId) {
		this.yearThActivityId = yearThActivityId;
	}

	public String getActivityId() {
		return this.activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public Integer getYearThActivitySortNumber() {
		return yearThActivitySortNumber;
	}

	public void setYearThActivitySortNumber(Integer yearThActivitySortNumber) {
		this.yearThActivitySortNumber = yearThActivitySortNumber;
	}

	public Date getActivityBeginDate() {
		return activityBeginDate;
	}

	public void setActivityBeginDate(Date activityBeginDate) {
		this.activityBeginDate = activityBeginDate;
	}

	public Date getActivityEndDate() {
		return activityEndDate;
	}

	public void setActivityEndDate(Date activityEndDate) {
		this.activityEndDate = activityEndDate;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	
}