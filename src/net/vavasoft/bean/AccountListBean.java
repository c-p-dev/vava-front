package net.vavasoft.bean;

import java.util.List;

public class AccountListBean {
	private int acid;
	private String userid;
	private String siteid;
	private String job;
	private int jobid;
	private String title;
	private String moneypoint;
	private int money;
	private String regdate;
	private int remain_money;
	private int remain_point;
	private String adminid;
	private String fromDate;
	
//	for datatable 
	
	private int dt_Draw;
	private int dt_Start;
	private int dt_Length;
	private int dt_RecordsTotal;
	private int dt_RecordsFiltered;
	private List dt_Data;
	private String dt_Error;
	
	public int getDt_Start() {
		return dt_Start;
	}
	public void setDt_Start(int dt_Start) {
		this.dt_Start = dt_Start;
	}
	public int getDt_Length() {
		return dt_Length;
	}
	public void setDt_Length(int dt_Length) {
		this.dt_Length = dt_Length;
	}

	public int getDt_Draw() {
		return dt_Draw;
	}
	public void setDt_Draw(int dt_Draw) {
		this.dt_Draw = dt_Draw;
	}
	public int getDt_RecordsTotal() {
		return dt_RecordsTotal;
	}
	public void setDt_RecordsTotal(int dt_RecordsTotal) {
		this.dt_RecordsTotal = dt_RecordsTotal;
	}
	public int getDt_RecordsFiltered() {
		return dt_RecordsFiltered;
	}
	public void setDt_RecordsFiltered(int dt_RecordsFiltered) {
		this.dt_RecordsFiltered = dt_RecordsFiltered;
	}
	public List getDt_Data() {
		return dt_Data;
	}
	public void setDt_Data(List dt_Data) {
		this.dt_Data = dt_Data;
	}
	public String getDt_Error() {
		return dt_Error;
	}
	public void setDt_Error(String dt_Error) {
		this.dt_Error = dt_Error;
	}
	

	
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	private String toDate;
	
	public int getAcid() {
		return acid;
	}
	public void setAcid(int acid) {
		this.acid = acid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSiteid() {
		return siteid;
	}
	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public int getJobid() {
		return jobid;
	}
	public void setJobid(int jobid) {
		this.jobid = jobid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMoneypoint() {
		return moneypoint;
	}
	public void setMoneypoint(String moneypoint) {
		this.moneypoint = moneypoint;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getRemain_money() {
		return remain_money;
	}
	public void setRemain_money(int remain_money) {
		this.remain_money = remain_money;
	}
	public int getRemain_point() {
		return remain_point;
	}
	public void setRemain_point(int remain_point) {
		this.remain_point = remain_point;
	}
	public String getAdminid() {
		return adminid;
	}
	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}
}
