package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_winners_org_rel database table.
 * 
 */
@Entity
@Table(name="t_winners_org_rel")
@NamedQuery(name="TWinnersOrgRelEntity.findAll", query="SELECT t FROM TWinnersOrgRelEntity t")
public class TWinnersOrgRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="winners_org_id")
	private String winnersOrgId;

	@Column(name="org_id")
	private String orgId;

	@Column(name="org_label")
	private String orgLabel;

	@Column(name="winners_id")
	private String winnersId;
	
	@Column(name="org_sort_number")
	private String orgSortNumber;

	public TWinnersOrgRelEntity() {
	}

	public String getWinnersOrgId() {
		return this.winnersOrgId;
	}

	public void setWinnersOrgId(String winnersOrgId) {
		this.winnersOrgId = winnersOrgId;
	}

	public String getOrgId() {
		return this.orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getOrgLabel() {
		return this.orgLabel;
	}

	public void setOrgLabel(String orgLabel) {
		this.orgLabel = orgLabel;
	}

	public String getWinnersId() {
		return this.winnersId;
	}

	public void setWinnersId(String winnersId) {
		this.winnersId = winnersId;
	}

	public String getOrgSortNumber() {
		return orgSortNumber;
	}

	public void setOrgSortNumber(String orgSortNumber) {
		this.orgSortNumber = orgSortNumber;
	}
	
}