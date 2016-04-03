package _02_TripAndJournal.model;

import java.io.Serializable;

public class MessageVO implements Serializable { //留言
    
	private Integer messageId; //留言編號
	private String messageType; //類型
    private Integer memberId; //會員編號
    private String  content; //內容
    private Integer referenceNo; //參照編號
    private java.sql.Timestamp updateTime; //留言時間
    
	@Override
	public String toString() {
		return "MessageVO [messageId=" + messageId + ", messageType="
				+ messageType + ", memberId=" + memberId + ", content="
				+ content + ", referenceNo=" + referenceNo + ", updateTime="
				+ updateTime + "]";
	}
	public Integer getMessageId() {
		return messageId;
	}
	public void setMessageId(Integer messageId) {
		this.messageId = messageId;
	}
	public String getMessageType() {
		return messageType;
	}
	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getReferenceNo() {
		return referenceNo;
	}
	public void setReferenceNo(Integer referenceNo) {
		this.referenceNo = referenceNo;
	}
	public java.sql.Timestamp getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(java.sql.Timestamp updateTime) {
		this.updateTime = updateTime;
	}

}
