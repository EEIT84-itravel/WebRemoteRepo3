package _02_TripAndJournal.model;

import java.io.Serializable;
import java.util.Arrays;

public class JournalPhotoVO implements Serializable{   //遊記照片
	
    private Integer journalPhotoId; //遊記照片編號
    private Integer journalDetailId; //遊記明細編號
    private byte[] journalPhoto; //遊記照片
    private boolean cover; //是否為主圖
    
    
	@Override
	public String toString() {
		return "JournalPhotoVO [journalPhotoId=" + journalPhotoId
				+ ", journalDetailId=" + journalDetailId + ", journalPhoto="
				+ Arrays.toString(journalPhoto) + ", cover=" + cover + "]";
	}
	public Integer getJournalPhotoId() {
		return journalPhotoId;
	}
	public void setJournalPhotoId(Integer journalPhotoId) {
		this.journalPhotoId = journalPhotoId;
	}
	public Integer getJournalDetailId() {
		return journalDetailId;
	}
	public void setJournalDetailId(Integer journalDetailId) {
		this.journalDetailId = journalDetailId;
	}
	public byte[] getJournalPhoto() {
		return journalPhoto;
	}
	public void setJournalPhoto(byte[] journalPhoto) {
		this.journalPhoto = journalPhoto;
	}
	public boolean isCover() {
		return cover;
	}
	public void setCover(boolean cover) {
		this.cover = cover;
	}
    
}
