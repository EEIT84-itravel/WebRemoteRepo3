package _05_Member.model;

import java.io.Serializable;

public class TrackVO implements Serializable {

	private Integer trackNo;//編號
	private Integer memberId;//追蹤者
	private Integer followMember;//被追蹤的作者
	@Override
	public String toString() {
		return "TrackVO [trackNo=" + trackNo + ", memberId=" + memberId
				+ ", followMember=" + followMember + "]";
	}
	public Integer getTrackNo() {
		return trackNo;
	}
	public void setTrackNo(Integer trackNo) {
		this.trackNo = trackNo;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public Integer getFollowMember() {
		return followMember;
	}
	public void setFollowMember(Integer followMember) {
		this.followMember = followMember;
	}
	
	
}
