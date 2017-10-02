package net.vavasoft.betconstruct;

public class RollbackOutput {
	
	private boolean hasError;
	private int errorId;
	private String errorDescription;
	private double TotalBalance;
	private String Token;
	
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
	
	public double getTotalBalance() {
		return TotalBalance;
	}
	
	public void setTotalBalance(double totalBalance) {
		TotalBalance = totalBalance;
	}
	
	public String getToken() {
		return Token;
	}
	
	public void setToken(String token) {
		Token = token;
	}
	
}
