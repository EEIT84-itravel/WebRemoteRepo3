package _02_TripAndJournal.model;


import java.io.Serializable;


public class LabelTripAndJournalVO implements Serializable {
	private static final long serialVersionUID = 1L;
	// 編號(reference_no)
	private Integer labelDetailId;
	// 內容編號(reference_type)
	private String referenceType;
	// 參照編號(reference_type)
	private Integer referenceNo;
	// 標籤編號(label_id)
	private String labelId;

	public Integer getLabelDetailId() {
		return labelDetailId;
	}

	public void setLabelDetailId(Integer labelDetailId) {
		this.labelDetailId = labelDetailId;
	}

	public String getReferenceType() {
		return referenceType;
	}

	public void setReferenceType(String referenceType) {
		this.referenceType = referenceType;
	}

	public Integer getReferenceNo() {
		return referenceNo;
	}

	public void setReferenceNo(Integer referenceNo) {
		this.referenceNo = referenceNo;
	}

	public String getLabelId() {
		return labelId;
	}

	public void setLabelId(String labelId) {
		this.labelId = labelId;
	}

	@Override
	public String toString() {
		return "LabelTripAndJournalVO [labelDetailId=" + labelDetailId
				+ ", referenceType=" + referenceType + ", referenceNo="
				+ referenceNo + ", labelId=" + labelId + "]";
	}

}
