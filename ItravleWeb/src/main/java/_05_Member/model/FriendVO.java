package _05_Member.model;

import java.io.Serializable;

public class FriendVO implements Serializable {
	private Integer friendNo;//編號
	private Integer memberId;//會員編號
	private Integer friendId;//好友會員編號
	public Integer getFriendNo() {
		return friendNo;
	}
	public void setFriendNo(Integer friendNo) {
		this.friendNo = friendNo;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public Integer getFriendId() {
		return friendId;
	}
	public void setFriendId(Integer friendId) {
		this.friendId = friendId;
	}
	@Override
	public String toString() {
		return "FriendVO [friendNo=" + friendNo + ", memberId=" + memberId
				+ ", friendId=" + friendId + "]";
	}
	
}
