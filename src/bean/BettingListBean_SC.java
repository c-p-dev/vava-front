package bean;

public class BettingListBean_SC {
	
	
	private String bgid;
	private String bet_money;
	private String res_money;
	private String job;
	private String regdate; 

	public void setBgid(String bgid) {
		this.bgid = bgid;
	}
	
	public void setBmoney(String bet_money) {
		this.bet_money = bet_money;
	}
	
	public void setRmoney(String res_money) {
		this.res_money = res_money;
	}
	
	
	public void setJob(String job) {
		this.job = job;
	}
	
	public void setRegdt(String regdate) {
		this.regdate = regdate;
	}
	
	
	public String getBgid() {
		return this.bgid;
	}
	
	public String getBmoney() {
		return this.bet_money;
	}
	
	public String getRmoney() {
		return this.res_money;
	}
	
	public String getJob() {
		return this.job;
	}
	
	public String getRegdt() {
		return this.regdate;
	}
	
}
