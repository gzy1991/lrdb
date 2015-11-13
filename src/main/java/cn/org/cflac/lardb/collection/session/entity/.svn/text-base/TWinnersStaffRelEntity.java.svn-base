package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_winners_staff_rel database table.
 * 
 */
@Entity
@Table(name="t_winners_staff_rel")
@NamedQuery(name="TWinnersStaffRelEntity.findAll", query="SELECT t FROM TWinnersStaffRelEntity t")
public class TWinnersStaffRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="winners_staff_id")
	private String winnersStaffId;

	@Column(name="staff_id")
	private String staffId;

	@Column(name="winners_id")
	private String winnersId;

	@Column(name="staff_label")
	private String staffLabel;
	
	@Column(name="staff_sort_number")
	private String staffSortNumber;

	public TWinnersStaffRelEntity() {
	}

	public String getWinnersStaffId() {
		return this.winnersStaffId;
	}

	public void setWinnersStaffId(String winnersStaffId) {
		this.winnersStaffId = winnersStaffId;
	}

	public String getStaffId() {
		return this.staffId;
	}

	public void setStaffId(String staffId) {
		this.staffId = staffId;
	}

	public String getWinnersId() {
		return this.winnersId;
	}

	public void setWinnersId(String winnersId) {
		this.winnersId = winnersId;
	}

	public String getStaffLabel() {
		return staffLabel;
	}

	public void setStaffLabel(String staffLabel) {
		this.staffLabel = staffLabel;
	}

	public String getStaffSortNumber() {
		return staffSortNumber;
	}

	public void setStaffSortNumber(String staffSortNumber) {
		this.staffSortNumber = staffSortNumber;
	}
	
}