package _02_TripAndJournal.model;

import java.io.Serializable;

public class TripCompanionVO implements Serializable{
	private Integer companionId;
	private Integer tripId;
	private Integer memberId;

	@Override
	public String toString() {
		return "TripCompanionVO [companionId=" + companionId + ", tripId="
				+ tripId + ", memberId=" + memberId + "]";
	}

	public Integer getCompanionId() {
		return companionId;
	}

	public void setCompanionId(Integer companionId) {
		this.companionId = companionId;
	}

	public Integer getTripId() {
		return tripId;
	}

	public void setTripId(Integer tripId) {
		this.tripId = tripId;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

}
