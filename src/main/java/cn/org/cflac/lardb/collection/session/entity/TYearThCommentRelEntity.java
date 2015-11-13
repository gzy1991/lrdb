package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_year_th_comment_rel database table.
 * 
 */
@Entity
@Table(name="t_year_th_comment_rel")
@NamedQuery(name="TYearThCommentRelEntity.findAll", query="SELECT t FROM TYearThCommentRelEntity t")
public class TYearThCommentRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="year_th_comment_id")
	private String yearThCommentId;

	@Column(name="comment_id")
	private String commentId;

	@Column(name="year_th_id")
	private String yearThId;
	
	@Column(name="year_th_comment_sort_number")
	private Integer yearThCommentSortNumber;

	public TYearThCommentRelEntity() {
	}

	public String getYearThCommentId() {
		return this.yearThCommentId;
	}

	public void setYearThCommentId(String yearThCommentId) {
		this.yearThCommentId = yearThCommentId;
	}

	public String getCommentId() {
		return this.commentId;
	}

	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public Integer getYearThCommentSortNumber() {
		return yearThCommentSortNumber;
	}

	public void setYearThCommentSortNumber(Integer yearThCommentSortNumber) {
		this.yearThCommentSortNumber = yearThCommentSortNumber;
	}
	
}