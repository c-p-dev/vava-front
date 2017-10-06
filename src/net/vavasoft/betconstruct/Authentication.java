package net.vavasoft.betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Authentication {
	
	@SerializedName("OperatorId")
    @Expose
	private int operatorId;
	@SerializedName("Token")
    @Expose
	private String token;
	@SerializedName("ClientRfid")
    @Expose
	private String clientRfid;
	@SerializedName("UserName")
    @Expose
	private String userName;
	@SerializedName("Password")
    @Expose
	private String password;
	@SerializedName("PublicKey")
    @Expose
	private String publicKey;
	
	public int getOperatorId() {
		return operatorId;
	}
	
	public void setOperatorId(int operatorId) {
		this.operatorId = operatorId;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
	public String getClientRfid() {
		return clientRfid;
	}
	
	public void setClientRfid(String clientRfid) {
		this.clientRfid = clientRfid;
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
	
	public String getPublicKey() {
		return publicKey;
	}
	
	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}
	
}
