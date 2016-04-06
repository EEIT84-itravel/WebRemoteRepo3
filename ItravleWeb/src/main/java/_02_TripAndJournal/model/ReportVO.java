package _02_TripAndJournal.model;

import java.io.Serializable;

public class ReportVO implements Serializable { //檢舉

	private Integer reportId; //檢舉編號
	private String referenceType; //內容類型
	private Integer referenceNo; //參照編號
	private Integer reporter; //檢舉人
	private String reportType; //檢舉類型
	private String content; //詳細內容
	private java.sql.Timestamp reportTime; //檢舉時間
	private Integer prosecutor; //被檢舉人
	private String processStatusId; //處理狀態

	@Override
	public String toString() {
		return "ReportVO [reportId=" + reportId + ", referenceType="
				+ referenceType + ", referenceNo=" + referenceNo
				+ ", reportor=" + reporter + ", reportType=" + reportType
				+ ", content=" + content + ", reportTime=" + reportTime
				+ ", prosecutor=" + prosecutor + ", processStatusId="
				+ processStatusId + "]";
	}
	public Integer getReportId() {
		return reportId;
	}
	public void setReportId(Integer reportId) {
		this.reportId = reportId;
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
	public Integer getReporter() {
		return reporter;
	}
	public void setReporter(Integer reporter) {
		this.reporter = reporter;
	}
	public String getReportType() {
		return reportType;
	}
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Timestamp getReportTime() {
		return reportTime;
	}
	public void setReportTime(java.sql.Timestamp reportTime) {
		this.reportTime = reportTime;
	}
	public Integer getProsecutor() {
		return prosecutor;
	}
	public void setProsecutor(Integer prosecutor) {
		this.prosecutor = prosecutor;
	}
	public String getProcessStatusId() {
		return processStatusId;
	}
	public void setProcessStatusId(String processStatusId) {
		this.processStatusId = processStatusId;
	}
	
}

