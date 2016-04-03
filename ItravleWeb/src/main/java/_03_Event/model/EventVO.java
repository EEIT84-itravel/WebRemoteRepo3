package _03_Event.model;

import java.io.Serializable;
import java.sql.Blob;
import java.util.Arrays;

public class EventVO implements Serializable{  //活動
	
	private Integer eventId; //活動編號
	private byte[] eventPhoto; //活動照片(不確定型態)
    private String eventTopic; //活動主題
    private String eventContent; //活動內容
    private java.sql.Date eventStartDate; //起始時間
    private java.sql.Date eventEndDate; //結束時間
    private Integer sightId; //景點
    private boolean eventRemoved; //是否下架
    
    
	@Override
	public String toString() {
		return "EventVO [eventId=" + eventId + ", eventPhoto="
				+ Arrays.toString(eventPhoto) + ", eventTopic=" + eventTopic
				+ ", eventContent=" + eventContent + ", eventStartDate="
				+ eventStartDate + ", eventEndDate=" + eventEndDate
				+ ", sightId=" + sightId + ", eventRemoved=" + eventRemoved
				+ "]";
	}
	public Integer getEventId() {
		return eventId;
	}
	public void setEventId(Integer eventId) {
		this.eventId = eventId;
	}
	public byte[] getEventPhoto() {
		return eventPhoto;
	}
	public void setEventPhoto(byte[] eventPhoto) {
		this.eventPhoto = eventPhoto;
	}
	public String getEventTopic() {
		return eventTopic;
	}
	public void setEventTopic(String eventTopic) {
		this.eventTopic = eventTopic;
	}
	public String getEventContent() {
		return eventContent;
	}
	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}
	public java.sql.Date getEventStartDate() {
		return eventStartDate;
	}
	public void setEventStartDate(java.sql.Date eventStartDate) {
		this.eventStartDate = eventStartDate;
	}
	public java.sql.Date getEventEndDate() {
		return eventEndDate;
	}
	public void setEventEndDate(java.sql.Date eventEndDate) {
		this.eventEndDate = eventEndDate;
	}
	public Integer getSightId() {
		return sightId;
	}
	public void setSightId(Integer sightId) {
		this.sightId = sightId;
	}
	public boolean isEventRemoved() {
		return eventRemoved;
	}
	public void setEventRemoved(boolean eventRemoved) {
		this.eventRemoved = eventRemoved;
	}
    
    
 
	
	
	
	
}
