package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the t_activity_festivalaward_rel database table.
 * 
 */
@Embeddable
public class TActivityFestivalawardRelPKEntity implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="activity_id")
	private String activityId;

	@Column(name="activity_festivalaward_id")
	private String activityFestivalawardId;

	public TActivityFestivalawardRelPKEntity() {
	}
	public String getActivityId() {
		return this.activityId;
	}
	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
	public String getActivityFestivalawardId() {
		return this.activityFestivalawardId;
	}
	public void setActivityFestivalawardId(String activityFestivalawardId) {
		this.activityFestivalawardId = activityFestivalawardId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof TActivityFestivalawardRelPKEntity)) {
			return false;
		}
		TActivityFestivalawardRelPKEntity castOther = (TActivityFestivalawardRelPKEntity)other;
		return 
			this.activityId.equals(castOther.activityId)
			&& this.activityFestivalawardId.equals(castOther.activityFestivalawardId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.activityId.hashCode();
		hash = hash * prime + this.activityFestivalawardId.hashCode();
		
		return hash;
	}
}