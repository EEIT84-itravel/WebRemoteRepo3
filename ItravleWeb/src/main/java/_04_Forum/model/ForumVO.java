package _04_Forum.model;

import java.io.Serializable;

public class ForumVO implements Serializable {
	private static final long serialVersionUID = 1L;
	// 編號(forum_id)
	private Integer forumId;
	// 類型(forum_type_id)
	private String forumTypeId;
	// 主題(forum_topic)
	private String forumTopic;
	// 作者(member_id)
	private Integer memberId;
	// 發表時間(forum_time)
	private java.sql.Timestamp forumTime;
	// 內容(forum_content)
	private String forumContent;
	// 瀏覽人次(visitor_num)
	private Integer visitorNum;
	// 回復數(reply_num)
	private Integer replyNum;

	public Integer getForumId() {
		return forumId;
	}

	public void setForumId(Integer forumId) {
		this.forumId = forumId;
	}

	public String getForumTypeId() {
		return forumTypeId;
	}

	public void setForumTypeId(String forumTypeId) {
		this.forumTypeId = forumTypeId;
	}

	public String getForumTopic() {
		return forumTopic;
	}

	public void setForumTopic(String forumTopic) {
		this.forumTopic = forumTopic;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public java.sql.Timestamp getForumTime() {
		return forumTime;
	}

	public void setForumTime(java.sql.Timestamp forumTime) {
		this.forumTime = forumTime;
	}

	public String getForumContent() {
		return forumContent;
	}

	public void setForumContent(String forumContent) {
		this.forumContent = forumContent;
	}

	public Integer getVisitorNum() {
		return visitorNum;
	}

	public void setVisitorNum(Integer visitorNum) {
		this.visitorNum = visitorNum;
	}

	public Integer getReplyNum() {
		return replyNum;
	}

	public void setReplyNum(Integer replyNum) {
		this.replyNum = replyNum;
	}

	@Override
	public String toString() {
		return "ForumVO [forumId=" + forumId + ", forumTypeId=" + forumTypeId
				+ ", forumTopic=" + forumTopic + ", memberId=" + memberId
				+ ", forumTime=" + forumTime + ", forumContent=" + forumContent
				+ ", visitorNum=" + visitorNum + ", replyNum=" + replyNum + "]";
	}

}
