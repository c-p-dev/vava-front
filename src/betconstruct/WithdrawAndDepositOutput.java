package betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class WithdrawAndDepositOutput {
	
	@SerializedName("HasError")
    @Expose
	private boolean hasError;
	@SerializedName("ErrorId")
    @Expose
	private int errorId;
	@SerializedName("ErrorDescription")
    @Expose
	private String errorDescription;
	@SerializedName("PlayerId")
    @Expose
	private int playerId;
	@SerializedName("Token")
    @Expose
	private String token;
	@SerializedName("TotalBalance")
    @Expose
	private double totalBalance;
	@SerializedName("PlatformTransactionId")
    @Expose
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
		return totalBalance;
	}
	
	public void setTotalBalance(double totalBalance) {
		this.totalBalance = totalBalance;
	}
	
	public int getPlatformTransactionId() {
		return platformTransactionId;
	}
	
	public void setPlatformTransactionId(int platformTransactionId) {
		this.platformTransactionId = platformTransactionId;
	}
	
}
