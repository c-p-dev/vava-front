package bean;

public class BettingListBean {
	
	private String bgid;
	private String bet_money;
	private String expect_rate;
	private String expect_money; 
	private String sel_cnt;
	private String bgresult;
	private String betdate;
	private boolean selected;
	
	public void setBgid(String bgid) {
		this.bgid = bgid;
	}
	
	public void setBmoney(String bet_money) {
		this.bet_money = bet_money;
	}
	
	public void setErate(String expect_rate) {
		this.expect_rate = expect_rate;
	}
	
	public void setEmoney(String expect_money) {
		this.expect_money = expect_money;
	}
	
	public void setScnt(String sel_cnt) {
		this.sel_cnt = sel_cnt;
	}
	
	public void setBresult(String bgresult) {
		this.bgresult = bgresult;
	}
	
	public void setBdate(String betdate) {
		this.betdate = betdate;
	}
	
	public void setSelected(Boolean selected) {
		this.selected = selected;
	}
	
	public String getBgid() {
		return this.bgid;
	}
	
	public String getBmoney() {
		return this.bet_money;
	}
	
	public String getErate() {
		return this.expect_rate;
	}
	
	public String getEmoney() {
		return this.expect_money;
	}
	
	public String getScnt() {
		return this.sel_cnt;
	}
	
	public String getBresult() {
		return this.bgresult;
	}
	
	public String getBdate() {
		return this.betdate;
	}
	
	public Boolean getSelected() {
		return  this.selected;
	}
	
}
