package _02_TripAndJournal.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class TripDetailVO implements Serializable{
	private Integer tdetailId;
	private Integer tripId;
	private Integer tripOrder;
	private java.sql.Time stayTime;
	private Integer whichDay;
	private String referenceType;
	private Integer referenceNo;
	private String notes;
	private java.math.BigDecimal sightBudget;

	@Override
	public String toString() {
		return "TripDetailVO [tdetailId=" + tdetailId + ", tripId=" + tripId
				+ ", tripOrder=" + tripOrder + ", stayTime=" + stayTime
				+ ", whichDay=" + whichDay + ", referenceType=" + referenceType
				+ ", referenceNo=" + referenceNo + ", notes=" + notes
				+ ", sightBudget=" + sightBudget + "]";
	}

	public Integer getTdetailId() {
		return tdetailId;
	}

	public void setTdetailId(Integer tdetailId) {
		this.tdetailId = tdetailId;
	}

	public Integer getTripId() {
		return tripId;
	}

	public void setTripId(Integer tripId) {
		this.tripId = tripId;
	}

	public Integer getTripOrder() {
		return tripOrder;
	}

	public void setTripOrder(Integer tripOrder) {
		this.tripOrder = tripOrder;
	}

	public java.sql.Time getStayTime() {
		return stayTime;
	}

	public void setStayTime(java.sql.Time stayTime) {
		this.stayTime = stayTime;
	}

	public Integer getWhichDay() {
		return whichDay;
	}

	public void setWhichDay(Integer whichDay) {
		this.whichDay = whichDay;
	}

	public String getReferenceType() {
		return referenceType;
	}

	public void setReferenceType(String referenceType) {
		this.referenceType = referenceType;
	}

	public Integer getReferenceNo() {
		return referenceNo;
	}

	public void setReferenceNo(Integer referenceNo) {
		this.referenceNo = referenceNo;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public java.math.BigDecimal getSightBudget() {
		return sightBudget;
	}

	public void setSightBudget(java.math.BigDecimal sightBudget) {
		this.sightBudget = sightBudget;
	}
}
