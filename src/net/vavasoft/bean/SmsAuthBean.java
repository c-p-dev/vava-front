package net.vavasoft.bean;

public class SmsAuthBean {
	private int smsid;
	private String tel;
	private String authcode;
	private int siteid;
	private String userid;
	private String regdate;
	private String usedate;
	private String state;
	
	public int getSmsid() {
		return smsid;
	}
	public void setSmsid(int smsid) {
		this.smsid = smsid;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAuthcode() {
		return authcode;
	}
	public void setAuthcode(String authcode) {
		this.authcode = authcode;
	}
	public int getSiteid() {
		return siteid;
	}
	public void setSiteid(int siteid) {
		this.siteid = siteid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getUsedate() {
		return usedate;
	}
	public void setUsedate(String usedate) {
		this.usedate = usedate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public char getViewtype() {
		return viewtype;
	}
	public void setViewtype(char viewtype) {
		this.viewtype = viewtype;
	}
	private String ip;
	private char viewtype;

}
