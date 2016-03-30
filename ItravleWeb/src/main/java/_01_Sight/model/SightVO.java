package _01_Sight.model;

import java.io.Serializable;
import java.sql.Time;
import java.sql.Timestamp;




import _00_Misc.model.CodeVO;

public class SightVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer sightId;     //景點編號
	private String sightName; 	 //名稱
	private String regionId; 	 //地區編號
	private String countyId;     //縣市編號
	private String sightTypeId;	 //景點類型編號
	private String ticket;	 	 //門票
	private Time openTime; 		 //開門時間
	private Time closeIime;		 //關門時間
	private Time spendHour;		 //建議停留時間
	private String playPeriod;	 //建議旅行時段	
	private Float score;		 //評分
	private Float longitude;	 //經度
	private Float latitude;		 //緯度
	private Integer watchNum;  	 //瀏覽人次
	private Integer collectNum;	 //收藏人次
	private String phone; 		 //電話
	private String addr;		 //地址
	private String trans;		 //交通方式
	private Integer creator;	 //新增者
	private Timestamp createTime;//新增時間
	private Integer modifier;	 //修改人
	private Timestamp modifyTime;//上次更新時間
	private boolean del;		 //刪除
	
	
	@Override
	public String toString() {
		return "SightVO [sightId=" + sightId + ", sightName=" + sightName
				+ ", regionId=" + regionId + ", countyId=" + countyId
				+ ", sightTypeId=" + sightTypeId + ", ticket=" + ticket
				+ ", openTime=" + openTime + ", closeIime=" + closeIime
				+ ", spendHour=" + spendHour + ", playPeriod=" + playPeriod
				+ ", score=" + score + ", longitude=" + longitude
				+ ", latitude=" + latitude + ", watchNum=" + watchNum
				+ ", collectNum=" + collectNum + ", phone=" + phone + ", addr="
				+ addr + ", trans=" + trans + ", creator=" + creator
				+ ", createTime=" + createTime + ", modifier=" + modifier
				+ ", modifyTime=" + modifyTime + ", del=" + del + "]\n";
	}
	public Integer getSightId() {
		return sightId;
	}
	public void setSightId(Integer sightId) {
		this.sightId = sightId;
	}
	public String getSightName() {
		return sightName;
	}
	public void setSightName(String sightName) {
		this.sightName = sightName;
	}
	public String getRegionId() {
		return regionId;
	}
	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}
	public String getCountyId() {
		return countyId;
	}
	public void setCountyId(String countyId) {
		this.countyId = countyId;
	}
	public String getSightTypeId() {
		return sightTypeId;
	}
	public void setSightTypeId(String sightTypeId) {
		this.sightTypeId = sightTypeId;
	}
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	public Time getOpenTime() {
		return openTime;
	}
	public void setOpenTime(Time openTime) {
		this.openTime = openTime;
	}
	public Time getCloseIime() {
		return closeIime;
	}
	public void setCloseIime(Time closeIime) {
		this.closeIime = closeIime;
	}
	public Time getSpendHour() {
		return spendHour;
	}
	public void setSpendHour(Time spendHour) {
		this.spendHour = spendHour;
	}
	public String getPlayPeriod() {
		return playPeriod;
	}
	public void setPlayPeriod(String layPeriod) {
		this.playPeriod = layPeriod;
	}
	public Float getScore() {
		return score;
	}
	public void setScore(Float score) {
		this.score = score;
	}
	public Float getLongitude() {
		return longitude;
	}
	public void setLongitude(Float longitude) {
		this.longitude = longitude;
	}
	public Float getLatitude() {
		return latitude;
	}
	public void setLatitude(Float latitude) {
		this.latitude = latitude;
	}
	public Integer getWatchNum() {
		return watchNum;
	}
	public void setWatchNum(Integer watchNum) {
		this.watchNum = watchNum;
	}
	public Integer getCollectNum() {
		return collectNum;
	}
	public void setCollectNum(Integer collectNum) {
		this.collectNum = collectNum;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTrans() {
		return trans;
	}
	public void setTrans(String trans) {
		this.trans = trans;
	}
	public Integer getCreator() {
		return creator;
	}
	public void setCreator(Integer creator) {
		this.creator = creator;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Integer getModifier() {
		return modifier;
	}
	public void setModifier(Integer modifier) {
		this.modifier = modifier;
	}
	public Timestamp getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Timestamp modifyTime) {
		this.modifyTime = modifyTime;
	}
	public boolean isDel() {
		return del;
	}
	public void setDel(boolean del) {
		this.del = del;
	}
	
}
