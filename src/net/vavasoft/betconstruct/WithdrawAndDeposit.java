package net.vavasoft.betconstruct;

public class WithdrawAndDeposit {
	
	private int operatorId;
	private int playerId;
	private String token;
	private double withdrawAmount;
	private double depositAmount;
	private String currency;
	private int gameId;
	private int rgsTransactionId;
	private int rgsRelatedTransactionId;
	private int typeId;
	private int bonusDefId;
	private String publicKey;
	
	public int getOperatorId() {
		return operatorId;
	}
	
	public void setOperatorId(int operatorId) {
		this.operatorId = operatorId;
	}
	
	public int getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(int playerId) {
		this.playerId = playerId;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
	public double getWithdrawAmount() {
		return withdrawAmount;
	}
	
	public void setWithdrawAmount(double withdrawAmount) {
		this.withdrawAmount = withdrawAmount;
	}
	
	public double getDepositAmount() {
		return depositAmount;
	}
	
	public void setDepositAmount(double depositAmount) {
		this.depositAmount = depositAmount;
	}
	
	public String getCurrency() {
		return currency;
	}
	
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public int getGameId() {
		return gameId;
	}
	
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	
	public int getRgsTransactionId() {
		return rgsTransactionId;
	}
	
	public void setRgsTransactionId(int rgsTransactionId) {
		this.rgsTransactionId = rgsTransactionId;
	}
	
	public int getRgsRelatedTransactionId() {
		return rgsRelatedTransactionId;
	}
	
	public void setRgsRelatedTransactionId(int rgsRelatedTransactionId) {
		this.rgsRelatedTransactionId = rgsRelatedTransactionId;
	}
	
	public int getTypeId() {
		return typeId;
	}
	
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	
	public int getBonusDefId() {
		return bonusDefId;
	}
	
	public void setBonusDefId(int bonusDefId) {
		this.bonusDefId = bonusDefId;
	}
	
	public String getPublicKey() {
		return publicKey;
	}
	
	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}
	
}
