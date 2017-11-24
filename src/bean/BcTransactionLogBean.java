package bean;

public class BcTransactionLogBean {
	
	private int transaction_id;
	private int playerId;
	private int rgs_id;
	private int rgs_related_id;
	private String token;
	private double withdraw_amount;
	private double deposit_amount;
	private int transaction_type;
	private String currency;
	private String date_added;
	private int status;
	private int type_description;

	public int getTransaction_id() {
		return transaction_id;
	}
	
	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}
	
	public int getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(int playerId) {
		this.playerId = playerId;
	}
	
	public int getRgs_id() {
		return rgs_id;
	}
	
	public void setRgs_id(int rgs_id) {
		this.rgs_id = rgs_id;
	}
	
	public int getRgs_related_id() {
		return rgs_related_id;
	}
	
	public void setRgs_related_id(int rgs_related_id) {
		this.rgs_related_id = rgs_related_id;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
	public double getWithdraw_amount() {
		return withdraw_amount;
	}
	
	public void setWithdraw_amount(double withdraw_amount) {
		this.withdraw_amount = withdraw_amount;
	}
	
	public double getDeposit_amount() {
		return deposit_amount;
	}
	
	public void setDeposit_amount(double transaction_amount) {
		this.deposit_amount = transaction_amount;
	}
	
	public int getTransaction_type() {
		return transaction_type;
	}
	
	public void setTransaction_type(int transaction_type) {
		this.transaction_type = transaction_type;
	}
	
	public String getCurrency() {
		return currency;
	}
	
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public String getDate_added() {
		return date_added;
	}
	
	public void setDate_added(String date_added) {
		this.date_added = date_added;
	}
	
	public int getStatus() {
		return status;
	}
	
	public void setStatus(int status) {
		this.status = status;
	}
	
	public int getType_description() {
		return type_description;
	}

	public void setType_description(int type_description) {
		this.type_description = type_description;
	}
}
