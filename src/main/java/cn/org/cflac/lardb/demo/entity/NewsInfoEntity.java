package cn.org.cflac.lardb.demo.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.css.sword.core.kernel.base.dataElement.AbsPersistObject;

/**
 * NewsInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "news_info")
public class NewsInfoEntity extends AbsPersistObject {

    private static final long serialVersionUID = 9054457632975386941L;

    @Id
    @Column(name = "news_id")
    private String newsId;

    @Column(name = "template_id")
    private String templateId;

    @Column(name = "art_type")
    private String artType;

    @Column(name = "title")
    private String title;

    @Column(name = "author")
    private String author;

    @Column(name = "published_date")
    private Date publishedDate;

    public String getNewsId() {
        return newsId;
    }

    public void setNewsId(String newsId) {
        this.newsId = newsId;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getArtType() {
        return artType;
    }

    public void setArtType(String artType) {
        this.artType = artType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(Date publishedDate) {
        this.publishedDate = publishedDate;
    }

}