package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the t_year_th_opus database table.
 * 
 */
@Entity
@Table(name="t_year_th_opus")
@NamedQuery(name="TYearThOpusEntity.findAll", query="SELECT t FROM TYearThOpusEntity t")
public class TYearThOpusEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="year_th_opus_id")
	private String yearThOpusId;

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

	@Column(name="opus_id")
	private String opusId;

	@Column(name="opus_label")
	private String opusLabel;

	@Column(name="opus_sort_number")
	private int opusSortNumber;

	@Column(name="year_th_id")
	private String yearThId;
	
	@Transient
	private List<TYearThOpusGroupingEntity> opusTypes;

	@Transient
	private String opusName;	
	
	public TYearThOpusEntity() {
	}

	public String getYearThOpusId() {
		return this.yearThOpusId;
	}

	public void setYearThOpusId(String yearThOpusId) {
		this.yearThOpusId = yearThOpusId;
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

	public String getOpusId() {
		return this.opusId;
	}

	public void setOpusId(String opusId) {
		this.opusId = opusId;
	}

	public String getOpusLabel() {
		return this.opusLabel;
	}

	public void setOpusLabel(String opusLabel) {
		this.opusLabel = opusLabel;
	}

	public int getOpusSortNumber() {
		return this.opusSortNumber;
	}

	public void setOpusSortNumber(int opusSortNumber) {
		this.opusSortNumber = opusSortNumber;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public List<TYearThOpusGroupingEntity> getOpusTypes() {
		return opusTypes;
	}

	public void setOpusTypes(List<TYearThOpusGroupingEntity> opusTypes) {
		this.opusTypes = opusTypes;
	}

	public String getOpusName() {
		return opusName;
	}

	public void setOpusName(String opusName) {
		this.opusName = opusName;
	}
	
}