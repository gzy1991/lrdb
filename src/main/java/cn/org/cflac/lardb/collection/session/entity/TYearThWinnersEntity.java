package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the t_year_th_winners database table.
 * 
 */
@Entity
@Table(name="t_year_th_winners")
@NamedQuery(name="TYearThWinnersEntity.findAll", query="SELECT t FROM TYearThWinnersEntity t")
public class TYearThWinnersEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="winners_id")
	private String winnersId;

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

	@Column(name="prize_name_one")
	private String prizeNameOne;

	@Column(name="prize_name_two")
	private String prizeNameTwo;

	@Column(name="winners_grouping_id")
	private String winnersGroupingId;

	@Column(name="winners_sort_number")
	private int winnersSortNumber;

	@Transient
	private List<TWinnersStaffRelEntity> staff;
	
	@Transient
	private List<TWinnersOrgRelEntity> orgs;
	
	@Transient
	private List<TWinnersOpusRelEntity> opus;
	
	public TYearThWinnersEntity() {
	}

	public String getWinnersId() {
		return this.winnersId;
	}

	public void setWinnersId(String winnersId) {
		this.winnersId = winnersId;
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

	public String getPrizeNameOne() {
		return this.prizeNameOne;
	}

	public void setPrizeNameOne(String prizeNameOne) {
		this.prizeNameOne = prizeNameOne;
	}

	public String getPrizeNameTwo() {
		return this.prizeNameTwo;
	}

	public void setPrizeNameTwo(String prizeNameTwo) {
		this.prizeNameTwo = prizeNameTwo;
	}

	public String getWinnersGroupingId() {
		return this.winnersGroupingId;
	}

	public void setWinnersGroupingId(String winnersGroupingId) {
		this.winnersGroupingId = winnersGroupingId;
	}

	public int getWinnersSortNumber() {
		return this.winnersSortNumber;
	}

	public void setWinnersSortNumber(int winnersSortNumber) {
		this.winnersSortNumber = winnersSortNumber;
	}

	public List<TWinnersStaffRelEntity> getStaff() {
		return staff;
	}

	public void setStaff(List<TWinnersStaffRelEntity> staff) {
		this.staff = staff;
	}

	public List<TWinnersOrgRelEntity> getOrgs() {
		return orgs;
	}

	public void setOrgs(List<TWinnersOrgRelEntity> orgs) {
		this.orgs = orgs;
	}

	public List<TWinnersOpusRelEntity> getOpus() {
		return opus;
	}

	public void setOpus(List<TWinnersOpusRelEntity> opus) {
		this.opus = opus;
	}
	
}