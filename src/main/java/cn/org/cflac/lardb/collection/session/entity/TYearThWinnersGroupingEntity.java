package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the t_year_th_winners_grouping database table.
 * 
 */
@Entity
@Table(name="t_year_th_winners_grouping")
@NamedQuery(name="TYearThWinnersGroupingEntity.findAll", query="SELECT t FROM TYearThWinnersGroupingEntity t")
public class TYearThWinnersGroupingEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="winners_grouping_id")
	private String winnersGroupingId;

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

	@Column(name="winners_grouping_name")
	private String winnersGroupingName;

	@Column(name="winners_grouping_sort_number")
	private int winnersGroupingSortNumber;

	@Column(name="year_th_id")
	private String yearThId;
	
	@Transient
	private List<TYearThWinnersEntity> winners;

	public TYearThWinnersGroupingEntity() {
	}

	public String getWinnersGroupingId() {
		return this.winnersGroupingId;
	}

	public void setWinnersGroupingId(String winnersGroupingId) {
		this.winnersGroupingId = winnersGroupingId;
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

	public String getWinnersGroupingName() {
		return this.winnersGroupingName;
	}

	public void setWinnersGroupingName(String winnersGroupingName) {
		this.winnersGroupingName = winnersGroupingName;
	}

	public int getWinnersGroupingSortNumber() {
		return this.winnersGroupingSortNumber;
	}

	public void setWinnersGroupingSortNumber(int winnersGroupingSortNumber) {
		this.winnersGroupingSortNumber = winnersGroupingSortNumber;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public List<TYearThWinnersEntity> getWinners() {
		return winners;
	}

	public void setWinners(List<TYearThWinnersEntity> winners) {
		this.winners = winners;
	}
	
}