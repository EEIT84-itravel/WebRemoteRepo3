package _02_TripAndJournal.model;

import java.io.Serializable;
public class JournalDetailVO implements Serializable{  //遊記明細
	
	private Integer journalDetailId; //遊記明細編號
	private Integer journalId; //遊記編號
	private Integer sightId; //景點編號
	private Integer sightOrder; //景點順序
	private String sightJournal; //景點的遊記
	
	
	@Override
	public String toString() {
		return "JournalDetailVO [journalDetailId=" + journalDetailId
				+ ", journalId=" + journalId + ", sightId=" + sightId
				+ ", sightOrder=" + sightOrder + ", sightJournal=" + sightJournal
				+ "]";
	}
	public Integer getJournalDetailId() {
		return journalDetailId;
	}
	public void setJournalDetailId(Integer journalDetailId) {
		this.journalDetailId = journalDetailId;
	}
	public Integer getJournalId() {
		return journalId;
	}
	public void setJournalId(Integer journalId) {
		this.journalId = journalId;
	}
	public Integer getSightId() {
		return sightId;
	}
	public void setSightId(Integer sightId) {
		this.sightId = sightId;
	}
	public Integer getSightOrder() {
		return sightOrder;
	}
	public void setSightOrder(Integer sightOrder) {
		this.sightOrder = sightOrder;
	}
	public String getSightJournal() {
		return sightJournal;
	}
	public void setSightJournal(String sightJournal) {
		this.sightJournal = sightJournal;
	}

}
