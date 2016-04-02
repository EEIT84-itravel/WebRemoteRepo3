package _02_TripAndJournal.model;

import java.io.Serializable;

public class JournalVO implements Serializable{   //遊記
	private Integer journalId; //遊記編號
	private boolean post;    //發布狀態
	private Integer memberId;  //發布者
	private java.sql.Timestamp modifyTime; //修改時間
	private String journalName; //遊記名稱
	private String journalIntro; //遊記簡介
	private java.sql.Date beginTime;  //起始時間
	private java.sql.Date endTime;  //結束時間
	private String regionId;  //地區
	private Integer visitorNum;  //瀏覽人次
	
	@Override
	public String toString() {
		return "JournalVO [journalId=" + journalId + ", post=" + post
				+ ", memberId=" + memberId + ", modifyTime=" + modifyTime
				+ ", journalName=" + journalName + ", journalIntro="
				+ journalIntro + ", beginTime=" + beginTime + ", endTime="
				+ endTime + ", regionId=" + regionId + ", visitorNum="
				+ visitorNum + "]";
	}
	public Integer getJournalId() {
		return journalId;
	}
	public void setJournalId(Integer journalId) {
		this.journalId = journalId;
	}
	public boolean isPost() {
		return post;
	}
	public void setPost(boolean post) {
		this.post = post;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public java.sql.Timestamp getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(java.sql.Timestamp modifyTime) {
		this.modifyTime = modifyTime;
	}
	public String getJournalName() {
		return journalName;
	}
	public void setJournalName(String journalName) {
		this.journalName = journalName;
	}
	public String getJournalIntro() {
		return journalIntro;
	}
	public void setJournalIntro(String journalIntro) {
		this.journalIntro = journalIntro;
	}
	public java.sql.Date getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(java.sql.Date beginTime) {
		this.beginTime = beginTime;
	}
	public java.sql.Date getEndTime() {
		return endTime;
	}
	public void setEndTime(java.sql.Date endTime) {
		this.endTime = endTime;
	}
	public String getRegionId() {
		return regionId;
	}
	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}
	public Integer getVisitorNum() {
		return visitorNum;
	}
	public void setVisitorNum(Integer visitorNum) {
		this.visitorNum = visitorNum;
	}

}
