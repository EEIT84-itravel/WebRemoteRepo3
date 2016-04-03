package _02_TripAndJournal.model;

import java.io.Serializable;

public class TripVO implements Serializable{
	private Integer tripId;
	private Boolean post;
	private java.sql.Timestamp modifyTime;
	private Integer memberId;
	private String tripName;
	private java.sql.Date tripStartDate;
	private java.sql.Date tripEndDate;
	private java.sql.Time startTime;
	private java.math.BigDecimal totalBudget;// 不確定
	private String regionId;
	private Integer watchNum;
	private String transFormId;
	private String tripIntro;

	@Override
	public String toString() {
		return "TripVO [tripId=" + tripId + ", post=" + post + ", modifyTime="
				+ modifyTime + ", memberId=" + memberId + ", tripName="
				+ tripName + ", tripStartDate=" + tripStartDate
				+ ", tripEndDate=" + tripEndDate + ", startTime=" + startTime
				+ ", totalBudget=" + totalBudget + ", regionId=" + regionId
				+ ", watchNum=" + watchNum + ", transFormId=" + transFormId
				+ ", tripIntro=" + tripIntro + "]";
	}

	public Integer getTripId() {
		return tripId;
	}

	public void setTripId(Integer tripId) {
		this.tripId = tripId;
	}

	public Boolean getPost() {
		return post;
	}

	public void setPost(Boolean post) {
		this.post = post;
	}

	public java.sql.Timestamp getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(java.sql.Timestamp modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public String getTripName() {
		return tripName;
	}

	public void setTripName(String tripName) {
		this.tripName = tripName;
	}

	public java.sql.Date getTripStartDate() {
		return tripStartDate;
	}

	public void setTripStartDate(java.sql.Date tripStartDate) {
		this.tripStartDate = tripStartDate;
	}

	public java.sql.Date getTripEndDate() {
		return tripEndDate;
	}

	public void setTripEndDate(java.sql.Date tripEndDate) {
		this.tripEndDate = tripEndDate;
	}

	public java.sql.Time getStartTime() {
		return startTime;
	}

	public void setStartTime(java.sql.Time startTime) {
		this.startTime = startTime;
	}

	public java.math.BigDecimal getTotalBudget() {
		return totalBudget;
	}

	public void setTotalBudget(java.math.BigDecimal totalBudget) {
		this.totalBudget = totalBudget;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public Integer getWatchNum() {
		return watchNum;
	}

	public void setWatchNum(Integer watchNum) {
		this.watchNum = watchNum;
	}

	public String getTransFormId() {
		return transFormId;
	}

	public void setTransFormId(String transFormId) {
		this.transFormId = transFormId;
	}

	public String getTripIntro() {
		return tripIntro;
	}

	public void setTripIntro(String tripIntro) {
		this.tripIntro = tripIntro;
	}

}
