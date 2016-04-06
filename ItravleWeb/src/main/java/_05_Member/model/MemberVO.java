package _05_Member.model;

import java.io.Serializable;
import java.util.Arrays;

public class MemberVO implements Serializable {
	private Integer memberId;// 會員編號
	private String memberAccount;// 帳號
	private String lastName;// 姓
	private String firstName;// 名
	private String nickname;// 暱稱
	private String password;// 密碼
	private String email;
	private java.sql.Date birth;// 生日
	private byte[] photo;//照片
	private String cellphone;// 電話
	private Boolean admin;// 管理權限
	private Boolean del;// 刪除
	private Integer modifier;// 修改人
	private java.sql.Timestamp modiftyTime;// 修改時間
	
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getMemberAccount() {
		return memberAccount;
	}
	public void setMemberAccount(String memberAccount) {
		this.memberAccount = memberAccount;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public java.sql.Date getBirth() {
		return birth;
	}
	public void setBirth(java.sql.Date birth) {
		this.birth = birth;
	}
	public byte[] getPhoto() {
		return photo;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public Boolean getAdmin() {
		return admin;
	}
	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}
	public Boolean getDel() {
		return del;
	}
	public void setDel(Boolean del) {
		this.del = del;
	}
	public Integer getModifier() {
		return modifier;
	}
	public void setModifier(Integer modifier) {
		this.modifier = modifier;
	}
	public java.sql.Timestamp getModiftyTime() {
		return modiftyTime;
	}
	public void setModiftyTime(java.sql.Timestamp modiftyTime) {
		this.modiftyTime = modiftyTime;
	}
	@Override
	public String toString() {
		return "MemberVO [memberId=" + memberId + ", memberAccount="
				+ memberAccount + ", lastName=" + lastName + ", firstName="
				+ firstName + ", nickname=" + nickname + ", password="
				+ password + ", email=" + email + ", birth=" + birth
				+ ", photo=" + Arrays.toString(photo) + ", cellphone="
				+ cellphone + ", admin=" + admin + ", del=" + del
				+ ", modifier=" + modifier + ", modiftyTime=" + modiftyTime
				+ "]";
	}
	
}
