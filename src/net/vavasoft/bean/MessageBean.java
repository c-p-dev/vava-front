package net.vavasoft.bean;

public class MessageBean {
	private int msgid;
	private int recv_siteid;
	private String recv_userid;
	private String recv_date;
	private int send_siteid;
	private String send_userid;
	private String gubun;
	private String viewtype;
	private String send_date;
	private String title;
	private String txt;
	
	public int getMsgid() {
		return msgid;
	}
	public void setMsgid(int msgid) {
		this.msgid = msgid;
	}
	public int getRecv_siteid() {
		return recv_siteid;
	}
	public void setRecv_siteid(int recv_siteid) {
		this.recv_siteid = recv_siteid;
	}
	public String getRecv_userid() {
		return recv_userid;
	}
	public void setRecv_userid(String recv_userid) {
		this.recv_userid = recv_userid;
	}
	public String getRecv_date() {
		return recv_date;
	}
	public void setRecv_date(String recv_date) {
		this.recv_date = recv_date;
	}
	public int getSend_siteid() {
		return send_siteid;
	}
	public void setSend_siteid(int send_siteid) {
		this.send_siteid = send_siteid;
	}
	public String getSend_userid() {
		return send_userid;
	}
	public void setSend_userid(String send_userid) {
		this.send_userid = send_userid;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getViewtype() {
		return viewtype;
	}
	public void setViewtype(String viewtype) {
		this.viewtype = viewtype;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTxt() {
		return txt;
	}
	public void setTxt(String txt) {
		this.txt = txt;
	}
		
}
