package net.vavasoft.bean;

public class UserBean {
	private String userid;
	private String passwd;
	private int siteid;
	private int money;
	private int point;
	private String nick;
	private String cell;
	private String regdate;
	private String state;
	private int grade;
	private String watch;
	private String recommend_yn;
	private String charge_level;
	private String bank_name;
	private String bank_owner;
	private String bank_num;
	private String recommand;
	private boolean isValid;
	private int loginStatus; //0  success //1 wrong passwrod // 2 no account 
	
	public int getLoginStatus() {
		return loginStatus;
	}
	public void setLoginStatus(int loginStatus) {
		this.loginStatus = loginStatus;
	}
	public boolean isValid() {
		return isValid;
	}
	public void setValid(boolean isValid) {
		this.isValid = isValid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public int getSiteid() {
		return siteid;
	}
	public void setSiteid(int siteid) {
		this.siteid = siteid;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getCell() {
		return cell;
	}
	public void setCell(String cell) {
		this.cell = cell;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getWatch() {
		return watch;
	}
	public void setWatch(String string) {
		this.watch = string;
	}
	public String getRecommend_yn() {
		return recommend_yn;
	}
	public void setRecommend_yn(String string) {
		this.recommend_yn = string;
	}
	public String getCharge_level() {
		return charge_level;
	}
	public void setCharge_level(String charge_level) {
		this.charge_level = charge_level;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getBank_owner() {
		return bank_owner;
	}
	public void setBank_owner(String bank_owner) {
		this.bank_owner = bank_owner;
	}
	public String getBank_num() {
		return bank_num;
	}
	public void setBank_num(String bank_num) {
		this.bank_num = bank_num;
	}
	public String getRecommand() {
		return recommand;
	}
	public void setRecommand(String recommand) {
		this.recommand = recommand;
	}

	
}
