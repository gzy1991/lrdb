package cn.org.cflac.lardb.collection.activity.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IPersistObject;

/**
 * The primary key class for the t_activity_news_rel database table.
 * 
 */
@Embeddable
public class TActivityNewsRelPKEntity implements Serializable{
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="activity_id")
	private String activityId;

	@Column(name="activity_news_id")
	private String activityNewsId;

	public TActivityNewsRelPKEntity() {
	}
	public String getActivityId() {
		return this.activityId;
	}
	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
	public String getActivityNewsId() {
		return this.activityNewsId;
	}
	public void setActivityNewsId(String activityNewsId) {
		this.activityNewsId = activityNewsId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof TActivityNewsRelPKEntity)) {
			return false;
		}
		TActivityNewsRelPKEntity castOther = (TActivityNewsRelPKEntity)other;
		return 
			this.activityId.equals(castOther.activityId)
			&& this.activityNewsId.equals(castOther.activityNewsId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.activityId.hashCode();
		hash = hash * prime + this.activityNewsId.hashCode();
		
		return hash;
	}
}