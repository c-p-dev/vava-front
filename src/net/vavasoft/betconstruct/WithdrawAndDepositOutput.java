package net.vavasoft.betconstruct;

public class WithdrawAndDepositOutput {
	
	private boolean hasError;
	private int errorId;
	private String errorDescription;
	private int playerId;
	private String token;
	private double TotalBalance;
	private int platformTransactionId;
	
	public boolean isHasError() {
		return hasError;
	}
	
	public void setHasError(boolean hasError) {
		this.hasError = hasError;
	}
	
	public int getErrorId() {
		return errorId;
	}
	
	public void setErrorId(int errorId) {
		this.errorId = errorId;
	}
	
	public String getErrorDescription() {
		return errorDescription;
	}
	
	public void setErrorDescription(String errorDescription) {
		this.errorDescription = errorDescription;
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
	
	public double getTotalBalance() {
		return TotalBalance;
	}
	
	public void setTotalBalance(double totalBalance) {
		TotalBalance = totalBalance;
	}
	
	public int getPlatformTransactionId() {
		return platformTransactionId;
	}
	
	public void setPlatformTransactionId(int platformTransactionId) {
		this.platformTransactionId = platformTransactionId;
	}
	
}
