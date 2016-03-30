package _05_Member.model;

import java.io.Serializable;

public class CollectionVO implements Serializable {
	private Integer collectionNo;//會員收藏編號
	private Integer memberId;//會員編號
	private String typeId;//類型
	private Integer referenceType;//參照編號
	public Integer getCollectionNo() {
		return collectionNo;
	}
	public void setCollectionNo(Integer collectionNo) {
		this.collectionNo = collectionNo;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	public Integer getReferenceType() {
		return referenceType;
	}
	public void setReferenceType(Integer referenceType) {
		this.referenceType = referenceType;
	}
	@Override
	public String toString() {
		return "CollectionVO [collectionNo=" + collectionNo + ", memberId="
				+ memberId + ", typeId=" + typeId + ", referenceType="
				+ referenceType + "]";
	}
	
}
