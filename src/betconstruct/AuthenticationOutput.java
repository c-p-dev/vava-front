package betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class AuthenticationOutput {
	
	@SerializedName("OperatorId")
    @Expose
	private int operatorId;
	@SerializedName("Name")
    @Expose
	private String name;
	@SerializedName("NickName")
    @Expose
	private String nickName;
	@SerializedName("UserName")
    @Expose
	private String userName;
	@SerializedName("Password")
    @Expose
	private String password;
	@SerializedName("Token")
    @Expose
	private String token;
	@SerializedName("TotalBalance")
    @Expose
	private double totalBalance;
	@SerializedName("Gender")
    @Expose
	private boolean gender;
	@SerializedName("Currency")
    @Expose
	private String currency;
	@SerializedName("Country")
    @Expose
	private String country;
	@SerializedName("PlayerId")
    @Expose
	private int playerId;
	@SerializedName("UserIP")
    @Expose
	private String userIp;
	@SerializedName("HasError")
    @Expose
	private boolean hasError;
	@SerializedName("ErrorId")
    @Expose
	private int errorId;
	@SerializedName("ErrorDescription")
    @Expose
	private String errorDescription;
	
	public int getOperatorId() {
		return operatorId;
	}
	
	
	public void setOperatorId(int operatorId) {
		this.operatorId = operatorId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
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
	
	public boolean isGender() {
		return gender;
	}
	
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	
	public String getCurrency() {
		return currency;
	}
	
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public String getCountry() {
		return country;
	}
	
	public void setCountry(String country) {
		this.country = country;
	}
	
	public int getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(int playerId) {
		this.playerId = playerId;
	}
	
	public String getUserIp() {
		return userIp;
	}
	
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	
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
	
}
