package bean;

public class CartSelList {
	
	private String sel_id;
	private String sel_price;
	private String market_sus;	
	private String market_vis; 
	private String match_sus;	
	private String match_vis;
	private String match_book;
	private String live_stat;
	private String match_stat;
	private String live;
	
	
	public void setSelid(String sel_id) {
		this.sel_id = sel_id;
	}
	
	public void setSelprice(String sel_price) {
		this.sel_price = sel_price;
	}
	
	public void setKsus(String market_sus) {
		this.market_sus = market_sus;
	}
	
	public void setKvis(String market_vis) {
		this.market_vis = market_vis;
	}
	
	public void setMsus(String match_sus) {
		this.match_sus = match_sus;
	}
	
	public void setMvis(String match_vis) {
		this.match_vis = match_vis;
	}
	
	public void setMbook(String match_book) {
		this.match_book = match_book;
	}
	
	public void setLstat(String live_stat) {
		this.live_stat = live_stat;
	}
	
	public void setMstat(String match_stat) {
		this.match_stat = match_stat;
	}
	
	public void setLive(String live) {
		this.live = live;
	}
	
	public String getSelid() {
		return this.sel_id;
	}
	
	public String getSelprice() {
		return this.sel_price;
	}
	
	public String getKsus() {
		return this.market_sus;
	}
	
	public String getKvis() {
		return this.market_vis;
	}
	
	public String getMsus() {
		return this.match_sus;
	}
	
	public String getMvis() {
		return this.match_vis;
	}
	
	public String getMbook() {
		return this.match_book;
	}
	
	public String getLstat() {
		return this.live_stat;
	}
	
	public String getMstat() {
		return this.match_stat;
	}
	
	public String getLive() {
		return this.live;
	}
	
	
	
}
