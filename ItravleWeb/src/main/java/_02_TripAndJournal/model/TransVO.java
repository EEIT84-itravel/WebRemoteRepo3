package _02_TripAndJournal.model;

import java.io.Serializable;

public class TransVO implements Serializable {

	private static final long serialVersionUID = 1L;
	// 交通編號
	private Integer transId;
	// 交通方式
	private String transFormId;

	public Integer getTransId() {
		return transId;
	}

	public void setTransId(Integer transId) {
		this.transId = transId;
	}

	public String getTransFormId() {
		return transFormId;
	}

	public void setTransFormId(String transFormId) {
		this.transFormId = transFormId;
	}

	@Override
	public String toString() {
		return "TransVO [transId=" + transId + ", transFormId=" + transFormId
				+ "]";
	}

}
