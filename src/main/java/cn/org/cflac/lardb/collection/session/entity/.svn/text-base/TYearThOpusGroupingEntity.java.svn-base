package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_year_th_opus_grouping database table.
 * 
 */
@Entity
@Table(name="t_year_th_opus_grouping")
@NamedQuery(name="TYearThOpusGroupingEntity.findAll", query="SELECT t FROM TYearThOpusGroupingEntity t")
public class TYearThOpusGroupingEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="grouping_id")
	private String groupingId;

	@Column(name="grouping_name")
	private String groupingName;

	@Column(name="year_th_opus_id")
	private String yearThOpusId;

	public TYearThOpusGroupingEntity() {
	}

	public String getGroupingId() {
		return this.groupingId;
	}

	public void setGroupingId(String groupingId) {
		this.groupingId = groupingId;
	}

	public String getGroupingName() {
		return this.groupingName;
	}

	public void setGroupingName(String groupingName) {
		this.groupingName = groupingName;
	}

	public String getYearThOpusId() {
		return this.yearThOpusId;
	}

	public void setYearThOpusId(String yearThOpusId) {
		this.yearThOpusId = yearThOpusId;
	}

}