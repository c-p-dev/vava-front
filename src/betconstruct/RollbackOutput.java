package betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class RollbackOutput {
	
	@SerializedName("HasError")
    @Expose
	private boolean hasError;
	@SerializedName("ErrorId")
    @Expose
	private int errorId;
	@SerializedName("ErrorDescription")
    @Expose
	private String errorDescription;
	@SerializedName("TotalBalance")
    @Expose
	private double totalBalance;
	@SerializedName("Token")
    @Expose
	private String token;
	
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
		return totalBalance;
	}
	
	public void setTotalBalance(double totalBalance) {
		this.totalBalance = totalBalance;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
}
